<?php
require_once 'dbaModel.php';
/**
* Clase para user del sistema
*
* Permite administras los user del sistma
*
* @package dbaModel
* @author Andres Felipe Quintero <afquinterot@correo.usbcali.edu.co>
* @copyright Todos los derechos reservados. USB. 2020.
* @since Versión 1.0, revisión 20200516.
* @version 1.0
*/
class userModel extends dbaModel{
	
	/**
	* Metodo para invocar los metodos de la clase a traves del frontEnd
	*
	* @package userModel.executeController
	* @author Andres Felipe Quintero <afquinterot@correo.usbcali.edu.co>
	* @copyright Todos los derechos reservados. USB. 2020.
    * @param string $strMethod nombre metodo.
    * @param array  $arrParameters.
	* @return object $obj Retorna objeto
	* @since Versión 1.0, revisión 20200516.
	* @version 1.0
	*/
	public function executeController($strMethod,$arrParameters)
	{
		switch ($strMethod)
		{
			case 'authentication':
			echo json_encode($this->authentication($arrParameters));
			break;
			case 'logout':
			echo json_encode($this->logout($arrParameters));
			break;
			default:
				$objReturn = new stdClass;
				$objReturn->tipo="error";
				$objReturn->msg="metodo desconocido";
				echo json_encode($objReturn);
			break;
		}
	}
	/**
	* Metodo para validar si el cliente pude registrase al sistema
	*
	* @package userModel.authentication
	* @author Andres Felipe Quintero <afquinterot@correo.usbcali.edu.co>
	* @copyright Todos los derechos reservados. USB. 2020.
    * @param string $strMethod nombre metodo.
    * @param object  $objParameters.
	* @return object $obj Retorna objeto
	* @since Versión 1.0, revisión 20200516.
	* @version 1.0
	*/
	public function authentication($arrParameters)
	{
		$objReturn = new stdClass;
		try {
			$strLogin=$arrParameters['login'];
			$strPassword=md5($arrParameters['password']);
			$this->strQuery = "SELECT * FROM USERS a INNER JOIN PROFILE b ON a.FK_PROFILE=b.ID  WHERE LOGIN = '$strLogin' AND PASSWORD = '$strPassword' LIMIT 1;";
			$exucuteConsulta = $this->executeSql('query');
			if($exucuteConsulta->tipo=='succes'){
				$_SESSION['id_usuarios']= $exucuteConsulta->data[0]['ID_USERS'];
				$_SESSION['login'] = $exucuteConsulta->data[0]['LOGIN'];
				$_SESSION['perfil'] = $exucuteConsulta->data[0]['NAME'];
				$_SESSION['mail'] = $exucuteConsulta->data[0]['MAIL'];
				$_SESSION['ingreso'] ='YES';
				$objReturn->type='success';
				$objReturn->mess='login OK';
			}	
			else
			{
				//throw new Exception($exucuteConsulta->msg);
				throw new Exception("Error al autenticar");
			}
		}catch (Exception $e){
            $objReturn->tipo="error";
            $objReturn->msg=$e->getMessage();
        }
        return $objReturn;
		
	}
	/**
	* Metodo destruir la sessiones
	*
	* @package userModel.logout
	* @author Andres Felipe Quintero <afquinterot@correo.usbcali.edu.co>
	* @copyright Todos los derechos reservados. USB. 2020.
    * @return object $obj Retorna objeto
	* @since Versión 1.0, revisión 20200516.
	* @version 1.0
	*/
	public function logout()
	{
		session_destroy();
		$objReturn= new stdClass();
		$objReturn->type='success';
		$objReturn->msg='logout OK';

		return $objReturn;
	}
	/**
	* @method Para validar que el perfil tenga permisos sobre la accion
	*
	* @package userModel.checkCommand
	* @author Andres Felipe Quintero <afquinterot@correo.usbcali.edu.co>
	* @copyright Todos los derechos reservados. USB. 2020.
	* @param string $command Name command 
	* @param string $object Name Objet
	* @param string $profile Name profile
	* @return object typo json con la confimarcion y si el perfil es logueable para guardar transaciones
	* @since Versión 1.0, revisión 20200516.
	* @version 1.0
	*/
	public function checkCommand($method, $object, $profile)
	{
		$objReturn= new stdClass();
		try {
			$this->strQuery = "SELECT ".$profile.",LOG FROM COMMANDS WHERE OBJET = '".$object."' AND METHOD  = '".$method."' AND ".$profile." LIKE '1';";
			$exucuteConsulta = $this->executeSql('query');
			if($exucuteConsulta->tipo=='succes'){
				
				$_SESSION['log'] =$exucuteConsulta->data[0]['LOG'];
				$objReturn->type='success';
				$objReturn->data=$exucuteConsulta->data[0]['LOG'];
				$objReturn->mess='permit OK';
			}
			else{
				throw new Exception("permit NOK");
			}
		}catch (Exception $e){
            $objReturn->tipo="error";
            $objReturn->msg=$e->getMessage();
        }
        return $objReturn;	
	}
	/**
	* @method Para registrar las transaciones solicitadas por el frontcontroller
	*
	* @package userModel.recordTransaction
	* @author Andres Felipe Quintero <afquinterot@correo.usbcali.edu.co>
	* @copyright Todos los derechos reservados. USB. 2020.
	* @param string $command Name command 
	* @param string $object Name Objet
	* @param string $profile Name profile
	* @return object typo json con la confimarcion y si el perfil es logueable para guardar transaciones
	* @since Versión 1.0, revisión 20200516.
	* @version 1.0
	*/
	public function recordTransaction($arrParameters)
	{
		//print_r($arrParameters);
		$objReturn= new stdClass();
		try {
			$this->strQuery="INSERT INTO TRANSACTIONS SET ";
			foreach ($arrParameters as $key => $value)
			{
				$this->strQuery.="$key='$value',";
			}
			//AGREGAR VARIABLES DE CONTROL
			$this->strQuery.="CREATION_DATE=NOW(),CREATED_BY='".$_SESSION['id_usuarios']."';";
			$exucuteConsulta = $this->executeSql('sentencia');
			if($exucuteConsulta->tipo=='succes'){
				$objReturn->type='success';
				$objReturn->mess='se registro la transaccion correctamente'.$exucuteConsulta->msg;
			}
			else{
				throw new Exception($exucuteConsulta->msg);
			}
		}catch (Exception $e){
            $objReturn->tipo="error";
            $objReturn->msg=$e->getMessage();
        }
        return $objReturn;	
	}				
}