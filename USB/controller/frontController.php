<?php
/**
* Libreria principal frontcontroller para registro de todas las transaciones
* @author:Andres Felipe Quintero 2020-05-20
* @version:1.0
*/
session_start();
include '../model/libraries.php';
//VALIDAR QUE VENGAN LOS PARAMETROS REQUERIDOS
if(isset($_REQUEST["object"]) && isset($_REQUEST["method"]))
{
	$object = $_REQUEST["object"];
	$method = $_REQUEST["method"];
	$objParameters = $_REQUEST["parameters"];
}
else
{
	echo '{"type":"error","mess":"No se logro localizar el atributo \'object\' o \'method\'. 
	Verificar que se esten .enviando.","object":'.$_REQUEST["object"].',"method":'.$_REQUEST["method"].'}';
	exit();
}
//LOGIN
if($object == 'user')
{
	$controles[$object]= new userModel();
	switch ($method)
	{
		case 'authentication':
			$controles[$object]->executeController($method,$objParameters);
		exit();
		break;
		case 'logout':
			$controles[$object]->executeController($method,$objParameters);
		exit();
		default:
		break;
	}
}
//VALIDAR QUE LA SESSION ESTE INICIADA
if(!isset($_SESSION['perfil']))
{
	$strRta= new stdClass();
	$strRta->type='errorSession';
	$strRta->mess='Usuario no ha iniciado sesion';
	echo json_encode($strRta);
	exit();
}
//VALIDAR LOS PERMISOS DE CADA TRANSACION
$checker = new userModel();
//PERMISOS DE MENU
if($object == 'menu')
{
	echo json_encode($checker->checkCommand($method,$object,$_SESSION['perfil']));
	exit();
}
//PERMISOS DE OTROS METODO DIFERENTE DEL MENU
$check = $checker->checkCommand($method,$object,$_SESSION['perfil']);
if($check->type=='success'){
	//EJECTUAR LOS DEMAS METODOS
	$controles = array();
	try
	{
		//ARMAR ARREGLO CON LOS FRONT CONTROLLERS
		$controles = array();
		$controles['dbaUser']= 'dbaUser';
		$controles['footPrint']= 'footPrint';
		//$controles['customer']= 'CustomerController';
		//$controles['ot']= 'OtController';
		//$controles['userTools']= 'userController';
		//$controles['print']= 'PrintController';

		try
		{
			if(isset($controles[$object])){
				eval('$control = new '.$controles[$object].'();');
				//CAPTURAR SALIDA PARA ALMACENAR
				ob_start();
				$control->executeController($method,$objParameters);
				$outPrint = ob_get_contents();	
				ob_end_clean();
				echo $outPrint;
				//SI LA VARIABLE DE SESSION LOG ESTA EN 0 REGISTATRA LA TRANSACION EN LA DBA
				if($check->data=='1'){
					
					$arrParameters=array();
					$arrParameters['LOGIN']=$_SESSION['login'];
					$arrParameters['PROFILE']=$_SESSION['perfil'];
					$arrParameters['OBJET']=$object;
					$arrParameters['METHOD']=$method;
					$arrParameters['PARAMETERS']=json_encode($objParameters);
					$arrParameters['RESPONSE']=$outPrint;
					//print_r($arrParameters);
					$insertTransacion=$checker->recordTransaction($arrParameters);
					//print_r($insertTransacion);
				}
			}else{
				throw new Exception('El method enviado no existe');
			}
		}catch(Exception $e){
			$state = "ERROR";
			$rta = new StdClass();
			$rta->type = 'error';
			$rta->mess = 'Error ejecutando el method.('.$e->getMessage().')';
			echo json_encode($rta);
		}
	}catch(Exception $e){
		$state = "ERROR";
		$rta = new StdClass();
		$rta->type = 'error';
		$rta->mess = 'Error en creación de clases.('.$e->getMessage().')';
		echo json_encode($rta);
	}		
}else{
	echo '{"type":"error","mess":"Perfil no tiene permisos"}';
}	
