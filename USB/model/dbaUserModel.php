<?php
require_once 'dbaModel.php';
/**
* Clase para registra transaciones en la dba
*
* @package footprint
* @author Andres Felipe Quintero <afquinterot@correo.usbcali.edu.co>
* @copyright Todos los derechos reservados. USB. 2020.
* @since Versión 1.0, revisión 20200516.
* @version 1.0
*/
class dbaUser extends dbaModel{
    /**
	* Metodo para invocar los metodos de la clase a traves del frontEnd
	*
	* @package dbaUser.executeController
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
			case 'createDba':
			echo json_encode($this->createDba($arrParameters));
			break;
			case 'listDba':
			case 'viewDba':	
			case 'editDba':		
				echo json_encode($this->listDba($arrParameters));
				break;
			case 'editDbaSet':
				echo json_encode($this->editDbaSet($arrParameters));
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
	* Metodo para crear informacion de DBA
	*
	* @package dbaUser.createDba
	* @author Andres Felipe Quintero <afquinterot@correo.usbcali.edu.co>
	* @copyright Todos los derechos reservados. USB. 2020.
    * @param string $strMethod nombre metodo.
    * @param object  $objParameters.
	* @return object $obj Retorna objeto
	* @since Versión 1.0, revisión 20200516.
	* @version 1.0
	*/
	public function createDba($arrParameters)
	{
		$objReturn= new stdClass();
		try {
			$this->strQuery="INSERT INTO DBA SET ";
			foreach ($arrParameters as $key => $value)
			{
				$this->strQuery.="$key='$value',";
			}
			//AGREGAR VARIABLES DE CONTROL
			$this->strQuery.="CREATION_DATE=NOW(),CREATED_BY='".$_SESSION['id_usuarios']."';";
			$exucuteConsulta = $this->executeSql('sentencia');
			//print_r($exucuteConsulta);
			if($exucuteConsulta->tipo=='succes'){
				$objReturn->type='success';
				$objReturn->msg='se creo DBA correctamente msg: '.$exucuteConsulta->msg;
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
	/**
	* Metodo para listar las dba registradas
	*
	* @package dbaUser.listDba
	* @author Andres Felipe Quintero <afquinterot@correo.usbcali.edu.co>
	* @copyright Todos los derechos reservados. USB. 2020.
    * @param string $strMethod nombre metodo.
    * @param object  $objParameters.
	* @return object $obj Retorna objeto
	* @since Versión 1.0, revisión 20200516.
	* @version 1.0
	*/
	public function listDba($arrParameters)
	{
		$objReturn= new stdClass();
		try {
			if($arrParameters!='default')
			{
				$where="WHERE 1";
				if($arrParameters!='0'){
					foreach ($arrParameters as $key => $value){
						$where.=" AND $key='$value'";
					}
				}
				$this->strQuery = "SELECT *,a.PASSWORD FROM DBA a INNER JOIN USERS b ON a.CREATED_BY=b.ID_USERS $where;";
				$exucuteConsulta = $this->executeSql('query');
				if($exucuteConsulta->tipo=='succes'){
					$objReturn->type='success';
					$objReturn->data=$exucuteConsulta->data;
					$objReturn->msg=$exucuteConsulta->msg;
				}
				else{
					throw new Exception("permit NOK");
				}
			}else{
				$objReturn->type='success';
				$objReturn->msg="OK";
			}	
		}catch (Exception $e){
            $objReturn->tipo="error";
            $objReturn->msg=$e->getMessage();
        }
        return $objReturn;
	}
	/**
	* Metodo para update informacion de DBA
	*
	* @package dbaUser.editDbaSet
	* @author Andres Felipe Quintero <afquinterot@correo.usbcali.edu.co>
	* @copyright Todos los derechos reservados. USB. 2020.
    * @param string $strMethod nombre metodo.
    * @param object  $objParameters.
	* @return object $obj Retorna objeto
	* @since Versión 1.0, revisión 20200516.
	* @version 1.0
	*/
	public function editDbaSet($arrParameters)
	{
		$objReturn= new stdClass();
		$intId=$arrParameters['ID_DBA'];
		unset($arrParameters['ID_DBA']);
		try {
			$this->strQuery="UPDATE DBA SET ";
			foreach ($arrParameters as $key => $value)
			{
				$this->strQuery.="$key='$value',";
			}
			//AGREGAR VARIABLES DE CONTROL
			$this->strQuery.="MODIFIED_DATE=NOW(),MODIFIED_BY='".$_SESSION['id_usuarios']."' WHERE ID_DBA='".$intId."';";
			$exucuteConsulta = $this->executeSql('sentencia');
			if($exucuteConsulta->tipo=='succes'){
				$objReturn->type='success';
				$objReturn->msg='se actualizo DBA correctamente msg: '.$exucuteConsulta->msg;
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