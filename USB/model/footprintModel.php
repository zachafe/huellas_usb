<?php
/**
* Clase para manejar las huellas
*
* @package footPrint
* @author Andres Felipe Quintero <afquinterot@correo.usbcali.edu.co>
* @copyright Todos los derechos reservados. USB. 2020.
* @since Versión 1.0, revisión 20200516.
* @version 1.0
*/
class footPrint extends dbaModel{

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
            case 'compareFootprintOther':
                echo json_encode($this->compareFootprintOther($arrParameters));
                break;
            case 'compareFootprintSystem':
                echo json_encode($this->compareFootprintSystem($arrParameters));
                break;
			case 'generarHuella':
			echo json_encode($this->generarHuella($arrParameters));
                break;
            case 'listFootPrint':
            case 'viewFootprint':    
            case 'compareFootprint':    
                echo json_encode($this->listFootPrint($arrParameters));
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
	* Metodo para listar las huellas registradas
	*
	* @package footPrint.listFootPrint
	* @author Andres Felipe Quintero <afquinterot@correo.usbcali.edu.co>
	* @copyright Todos los derechos reservados. USB. 2020.
    * @param string $strMethod nombre metodo.
    * @param object  $objParameters.
	* @return object $obj Retorna objeto
	* @since Versión 1.0, revisión 20200516.
	* @version 1.0
	*/
	public function listFootPrint($arrParameters)
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
				$this->strQuery = "SELECT *,a.CREATION_DATE,b.PASSWORD as PASSWORDDB
                                   FROM FOOTPRINT a 
                                   INNER JOIN DBA b ON a.FK_DBA=b.ID_DBA  
                                   INNER JOIN USERS c ON a.CREATED_BY=c.ID_USERS $where;";
				$exucuteConsulta = $this->executeSql('query');
				if($exucuteConsulta->tipo=='succes'){
					$objReturn->type='success';
					$objReturn->data=$exucuteConsulta->data;
					$objReturn->msg=$exucuteConsulta->msg;
				}
				else{
					throw new Exception($exucuteConsulta->msg);
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
    public function generarHuella($arrParameters)
    {
        $objReturn= new stdClass();
        try {
            $objReturn->data=new stdClass();
            //print_r($arrParameters);
            $printHuellas=$this->imprimirHuellaSistema($arrParameters);
            if($printHuellas->type=='success'){
                $objReturn->data=$printHuellas->data;
                //print_r($objReturn->data);
                //exit();
                //INSERT EN DBA DE APP
                $this->strHost='localhost';
                $this->strUser='root';
                $this->strPass='felipe';
                $this->strDbName='USB_APP';   
                $this->strQuery="INSERT INTO FOOTPRINT SET FK_DBA='".$arrParameters['ID_DBA']."',FOOTPRINT='".json_encode($objReturn)."',CREATION_DATE=NOW(),CREATED_BY='".$_SESSION['id_usuarios']."'";
                //echo "INSERT INTO FOOTPRINT SET FK_DBA='".$arrParameters['ID_DBA']."',FOOTPRINT='".json_encode($objReturn)."',CREATION_DATE=NOW(),CREATED_BY='".$_SESSION['id_usuarios']."' ";
                $exucuteConsulta = $this->executeSql('sentencia');
                if($exucuteConsulta->tipo=='succes'){
                    $objReturn->type='success';
                    $objReturn->msg='se registro la huella correctamente'.$exucuteConsulta->msg;
                }
                else{
                    throw new Exception($exucuteConsulta->msg);
                }
            }else{
                throw new Exception("error generando huella");
            }
            $objReturn->data=$printHuellas->data;
        }catch (Exception $e){
            $objReturn->tipo="error";
            $objReturn->msg=$e->getMessage();
        }
        return $objReturn;
    }
    /*
    *
    */
    public function imprimirHuellaSistema($arrParameters){

        $objReturn= new stdClass();
        try {
            $objReturn->data=new stdClass();
            //print_r($arrParameters);
            //INICIALIZAR LA DBA EN EL ESQUEMA
            $this->strHost=$arrParameters['IP'];
            $this->strUser=$arrParameters['USER'];
            $this->strPass=$arrParameters['PASSWORD'];
            //$this->strDbName=$arrParameters['DB_NAME'];
            $this->strDbName='information_schema';
            //INFO DBA
            $objReturn->idDba=$arrParameters['ID_DBA'];
            $objReturn->nameDba=$arrParameters['DB_NAME'];
            $objReturn->ipDba=$arrParameters['IP'];
            $objReturn->type='success';
            //TRAER VERSION
            $this->strQuery = "SHOW GLOBAL VARIABLES LIKE '%version%';";
            $exucuteversion = $this->executeSql('query');
            $objReturn->data->versiones=array();
            if($exucuteversion->tipo=='succes'){
                //$objReturn->data->versiones=$exucuteversion->data;
                foreach ($exucuteversion->data as $key => $value) {
                    $aux=new stdClass();
                    $aux->Variable_name=$value['Variable_name'];
                    //$aux['Value']=$value['Value'];
                    //$aux['ACTION_STATEMENT']=$value['ACTION_STATEMENT'];
                    $aux->sha256=hash('sha256',$value['Value']);
                    array_push($objReturn->data->versiones,$aux);
                }    
            }
            //TRIGGERS
            $this->strQuery = "SELECT TRIGGER_NAME, 'TRIGGER',ACTION_STATEMENT FROM TRIGGERS t WHERE TRIGGER_SCHEMA ='".$arrParameters['DB_NAME']."';";
            $exucuteTriggers = $this->executeSql('query');
            $objReturn->data->triggers=array();
            if($exucuteTriggers->tipo=='succes'){
                foreach ($exucuteTriggers->data as $key => $value) {
                    $aux= new stdClass();
                    $aux->TRIGGER_NAME=$value['TRIGGER_NAME'];
                    $aux->ROUTINE_TYPE=$value['TRIGGER'];
                    //$aux['ACTION_STATEMENT']=$value['ACTION_STATEMENT'];
                    $aux->sha256=hash('sha256',$value['ACTION_STATEMENT']);
                    array_push($objReturn->data->triggers,$aux);
                }
            }
            //VISTAS
            $this->strQuery = "SELECT TABLE_NAME, 'VIEW', VIEW_DEFINITION FROM VIEWS v WHERE TABLE_SCHEMA  ='".$arrParameters['DB_NAME']."';";
            $exucuteVistas = $this->executeSql('query');
            $objReturn->data->vistas=array();
            if($exucuteVistas->tipo=='succes'){
                foreach ($exucuteVistas->data as $key => $value) {
                    $aux= new stdClass();
                    $aux->TABLE_NAME=$value['TABLE_NAME'];
                    $aux->ROUTINE_TYPE=$value['VIEW'];
                    //$aux['VIEW_DEFINITION']=$value['VIEW_DEFINITION'];
                    $aux->sha256=hash('sha256',$value['VIEW_DEFINITION']);
                    array_push($objReturn->data->vistas,$aux);
                }
            }
            //RUTINAS (PROCEDURE Y FUNCIONES)
            $this->strQuery = "SELECT ROUTINE_NAME, ROUTINE_TYPE, ROUTINE_DEFINITION FROM ROUTINES r WHERE ROUTINE_SCHEMA ='".$arrParameters['DB_NAME']."';";
            $exucuteRutinas = $this->executeSql('query');
            $objReturn->data->rutinas=array();
            if($exucuteRutinas->tipo=='succes'){
                foreach ($exucuteRutinas->data as $key => $value) {
                    $aux= new stdClass();
                    $aux->ROUTINE_NAME=$value['ROUTINE_NAME'];
                    $aux->ROUTINE_TYPE=$value['ROUTINE_TYPE'];
                    //$aux['ROUTINE_DEFINITION']=$value['ROUTINE_DEFINITION'];
                    $aux->sha256=hash('sha256',$value['ROUTINE_DEFINITION']);
                    array_push($objReturn->data->rutinas,$aux);
                }
            }
            //TABLAS
            $this->strDbName=$arrParameters['DB_NAME'];
            $this->strQuery = "SHOW TABLES;";
            $exucuteTablas = $this->executeSql('query');
            $objReturn->data->tablas=array();
            if($exucuteTablas->tipo=='succes'){
                foreach ($exucuteTablas->data as $key => $value){
                    $strTabla="Tables_in_".$arrParameters['DB_NAME'];
                    //RECORRER LAS TABLAS
                    $this->strQuery = "SHOW CREATE TABLE ".$value[$strTabla].";";
                    $exucuteTabla= $this->executeSql('query');
                    if($exucuteTabla->tipo=='succes'){
                        //print_r($exucuteTabla->data);
                        //echo $exucuteTabla->data[0]['Table'];
                        //echo $exucuteTabla->data[0]['Create Table'];
                        if(!empty($exucuteTabla->data[0]['Table'])){
                            $aux= new stdClass();
                            $aux->TABLA= $exucuteTabla->data[0]['Table'];
                            $aux->ROUTINE_TYPE="TABLAS";
                            //$aux['ROUTINE_DEFINITION']=$exucuteTabla->data[0]['Create Table'];
                            $aux->sha256=hash('sha256',$exucuteTabla->data[0]['Create Table']);
                            array_push($objReturn->data->tablas,$aux);
                        }
                    }    
                }    
            } 
        }catch (Exception $e){
            $objReturn->tipo="error";
            $objReturn->msg=$e->getMessage();
        }
        return $objReturn;
    }
    /*
    *
    */
    public function searchObj($opcion,$arrBuscar,$referencia,$valor){
        //0 SI ES IGUAL 1 SI CAMBIO EL HASH
        $respuesta=0;
        switch ($opcion) {
            case 'tablas':
                    foreach ($arrBuscar as $key => $value){
                        if($value->TABLA==$referencia){
                            if($value->sha256!=$valor){
                                $respuesta=1;
                            }
                        }
                    }
                break;
            case 'versiones':
                foreach ($arrBuscar as $key => $value){
                    if($value->Variable_name==$referencia){
                        if($value->sha256!=$valor){
                            $respuesta=1;
                        }
                    }
                }
                break;
            case 'triggers':
                foreach ($arrBuscar as $key => $value){
                    if($value->TRIGGER_NAME==$referencia){
                        if($value->sha256!=$valor){
                            $respuesta=1;
                        }
                    }
                }
                break;
            case 'vistas':
                foreach ($arrBuscar as $key => $value){
                    if($value->TABLE_NAME==$referencia){
                        if($value->sha256!=$valor){
                            $respuesta=1;
                        }
                    }
                }
                    break;  
            case 'rutinas':
                foreach ($arrBuscar as $key => $value){
                    if($value->ROUTINE_NAME==$referencia){
                        if($value->sha256!=$valor){
                            $respuesta=1;
                        }
                    }
                }
                    break;                    
        }
        return $respuesta;
    }
    /*
    *
    */
    public function compareFootprintSystem($arrParameters){

        $objReturn= new stdClass();
        $objReturn->data=new stdClass();
        try {
            $huella=$this->listFootPrint($arrParameters);
            //print_r($huella);
            if($huella->type=='success'){
                $objReturn->type='success';
                $objReturn->msg='comparador de huella';
                $objReturn->data->IP=$huella->data[0]['IP'];
                $objReturn->data->USER=$huella->data[0]['USER'];
                $objReturn->data->PASSWORDDB=$huella->data[0]['PASSWORDDB'];
                $objReturn->data->ID_DBA=$huella->data[0]['ID_DBA'];
                $objReturn->data->NAME=$huella->data[0]['NAME'];


                $arrParSearch=array();
                $arrParSearch['IP']=$huella->data[0]['IP'];
                $arrParSearch['USER']=$huella->data[0]['USER'];
                $arrParSearch['PASSWORD']=$huella->data[0]['PASSWORDDB'];
                $arrParSearch['ID_DBA']=$huella->data[0]['ID_DBA'];
                $arrParSearch['DB_NAME']=$huella->data[0]['NAME'];
                //OBJETOS A COMPARAR
                $huellaDba=json_decode($huella->data[0]['FOOTPRINT']);
                $huellaSistema=$this->imprimirHuellaSistema($arrParSearch);
                //VERSIONES
                $versionesHuella=$huellaDba->data->versiones;
                $versioensSistemas=$huellaSistema->data->versiones;
                $objReturn->data->versiones=array();
                foreach ($versionesHuella as $key => $value){
                    $aux=new stdClass();
                    $aux->Variable_name=$value->Variable_name;
                    $aux->sha256=$value->sha256;
                    $aux->flagModificado=$this->searchObj('versiones',$versioensSistemas,$value->Variable_name,$value->sha256);
                    array_push($objReturn->data->versiones,$aux);
                } 
                //////////////////////////////////////TRIGGERS////////////////////////////////////////
                $triggersHuella=$huellaDba->data->triggers;
                $triggersSistemas=$huellaSistema->data->triggers;
                $objReturn->data->triggers=array();
                foreach ($triggersHuella as $key => $value){
                    $aux=new stdClass();
                    $aux->TRIGGER_NAME=$value->TRIGGER_NAME;
                    $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                    $aux->sha256=$value->sha256;
                    $aux->flagModificado=$this->searchObj('triggers',$triggersSistemas,$value->TRIGGER_NAME,$value->sha256);
                    array_push($objReturn->data->triggers,$aux);
                }
                //TRIGGERS ELIMINADAS
                $objReturn->data->triggerEliminados=array();
                $diffTriggerEliminados = array_udiff($triggersHuella,$triggersSistemas,
                    function ($obj_a, $obj_b){
                        return strcmp($obj_a->TRIGGER_NAME, $obj_b->TRIGGER_NAME);
                    }
                );
                foreach ($diffTriggerEliminados as $key => $value) {
                    $aux=new stdClass();
                    $aux->TRIGGER_NAME=$value->TRIGGER_NAME;
                    $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                    $aux->sha256=$value->sha256;
                    array_push($objReturn->data->triggerEliminados,$aux);
                }
                //TRIGGERS CREADAS
                $objReturn->data->triggerCreados=array();
                $diffTriggerCreados = array_udiff($triggersSistemas,$triggersHuella,
                    function ($obj_a, $obj_b){
                        return strcmp($obj_a->TRIGGER_NAME, $obj_b->TRIGGER_NAME);
                    }
                );
                foreach ($diffTriggerCreados as $key => $value){
                    $aux=new stdClass();
                    $aux->TRIGGER_NAME=$value->TRIGGER_NAME;
                    $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                    $aux->sha256=$value->sha256;
                    array_push($objReturn->data->triggerCreados,$aux);
                }
                //////////////////////////////////////VISTAS//////////////////////////////////////
                $vistaHuella=$huellaDba->data->vistas;
                $vistaSistemas=$huellaSistema->data->vistas;
                $objReturn->data->vistas=array();
                foreach ($vistaHuella as $key => $value){
                    $aux=new stdClass();
                    $aux->TABLE_NAME=$value->TABLE_NAME;
                    $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                    $aux->sha256=$value->sha256;
                    $aux->flagModificado=$this->searchObj('vistas',$vistaSistemas,$value->TABLE_NAME,$value->sha256);
                    array_push($objReturn->data->vistas,$aux);
                }
                //TABLAS ELIMINADAS
                $objReturn->data->vistasEliminadas=array();
                $diffVistasEliminadas = array_udiff($vistaHuella,$vistaSistemas,
                    function ($obj_a, $obj_b){
                        return strcmp($obj_a->TABLE_NAME, $obj_b->TABLE_NAME);
                    }
                );
                foreach ($diffVistasEliminadas as $key => $value) {
                    $aux=new stdClass();
                    $aux->TABLE_NAME=$value->TABLE_NAME;
                    $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                    $aux->sha256=$value->sha256;
                    array_push($objReturn->data->vistasEliminadas,$aux);
                }
                //TABLAS CREADAS
                $objReturn->data->vistaCreadas=array();
                $diffVistasCreadas = array_udiff($vistaSistemas,$vistaHuella,
                    function ($obj_a, $obj_b){
                        return strcmp($obj_a->TABLE_NAME, $obj_b->TABLE_NAME);
                    }
                );
                foreach ($diffVistasCreadas as $key => $value){
                    $aux=new stdClass();
                    $aux->TABLE_NAME=$value->TABLE_NAME;
                    $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                    $aux->sha256=$value->sha256;
                    array_push($objReturn->data->vistaCreadas,$aux);
                }
                ///////////////////////////////////////RUTINAS (PROCEDURE Y FUNCIONES)///////////////////////////////////////
                $rutinasHuella=$huellaDba->data->rutinas;
                $rutinasSistemas=$huellaSistema->data->rutinas;
                $objReturn->data->rutinas=array();
                foreach ($rutinasHuella as $key => $value){
                    $aux=new stdClass();
                    $aux->ROUTINE_NAME=$value->ROUTINE_NAME;
                    $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                    $aux->sha256=$value->sha256;
                    $aux->flagModificado=$this->searchObj('rutinas',$rutinasSistemas,$value->ROUTINE_NAME,$value->sha256);
                    array_push($objReturn->data->rutinas,$aux);
                }
                //TABLAS ELIMINADAS
                $objReturn->data->rutinasEliminadas=array();
                $diffRutinasEliminadas = array_udiff($rutinasHuella,$rutinasSistemas,
                    function ($obj_a, $obj_b){
                        return strcmp($obj_a->ROUTINE_NAME, $obj_b->ROUTINE_NAME);
                    }
                );
                foreach ($diffRutinasEliminadas as $key => $value) {
                    $aux=new stdClass();
                    $aux->ROUTINE_NAME=$value->ROUTINE_NAME;
                    $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                    $aux->sha256=$value->sha256;
                    array_push($objReturn->data->rutinasEliminadas,$aux);
                }
                //TABLAS CREADAS
                $objReturn->data->rutinasCreadas=array();
                $diffRutinasCreadas = array_udiff($rutinasSistemas,$rutinasHuella,
                    function ($obj_a, $obj_b){
                        return strcmp($obj_a->ROUTINE_NAME, $obj_b->ROUTINE_NAME);
                    }
                );
                foreach ($diffRutinasCreadas as $key => $value){
                    $aux=new stdClass();
                    $aux->ROUTINE_NAME=$value->ROUTINE_NAME;
                    $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                    $aux->sha256=$value->sha256;
                    array_push($objReturn->data->rutinasCreadas,$aux);
                }
                ///////////////////////////////////// TABLAS /////////////////////////////////////
                $tablasHuella=$huellaDba->data->tablas;
                $tablasSistemas=$huellaSistema->data->tablas;
                $objReturn->data->tablas=array();
                foreach ($tablasHuella as $key => $value){
                    $aux=new stdClass();
                    $aux->TABLA=$value->TABLA;
                    $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                    $aux->sha256=$value->sha256;
                    $aux->flagModificado=$this->searchObj('tablas',$tablasSistemas,$value->TABLA,$value->sha256);
                    array_push($objReturn->data->tablas,$aux);
                }
                //TABLAS ELIMINADAS
                $objReturn->data->tablasEliminadas=array();
                $diffTablasEliminadas = array_udiff($tablasHuella,$tablasSistemas,
                    function ($obj_a, $obj_b){
                        return strcmp($obj_a->TABLA, $obj_b->TABLA);
                    }
                );
                foreach ($diffTablasEliminadas as $key => $value) {
                    $aux=new stdClass();
                    $aux->TABLA=$value->TABLA;
                    $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                    $aux->sha256=$value->sha256;
                    array_push($objReturn->data->tablasEliminadas,$aux);
                }
                //TABLAS CREADAS
                $objReturn->data->tablasCreadas=array();
                $diffTablasCreadas = array_udiff($tablasSistemas,$tablasHuella,
                    function ($obj_a, $obj_b){
                        return strcmp($obj_a->TABLA, $obj_b->TABLA);
                    }
                );
                foreach ($diffTablasCreadas as $key => $value){
                    $aux=new stdClass();
                    $aux->TABLA=$value->TABLA;
                    $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                    $aux->sha256=$value->sha256;
                    array_push($objReturn->data->tablasCreadas,$aux);
                }
                //EXAMPLE DE BUSCAR DIFERENCIA DE OBJETOS////////////
                /*//BUSCAR LA DIFERENCIA DE OBJETOS
                $array1 = $tablasHuella;
                $array2 = $tablasSistemas;
                $diff = array_udiff($array2, $array1,
                    function ($obj_a, $obj_b) {
                        //print_r($obj_b->TABLA);
                        return strcmp($obj_a->TABLA, $obj_b->TABLA);
                    }
                );
                print_r($diff);*/
            }else{
                throw new Exception("error comparando huellas");
            }
        }catch (Exception $e){
            $objReturn->tipo="error";
            $objReturn->msg=$e->getMessage();
        }
        return $objReturn;
    }
    /*
    *
    *
    */
    public function compareFootprintOther($arrParameters){

        $objReturn= new stdClass();
        $objReturn->data=new stdClass();
        try {
            //print_r($arrParameters);
            if($arrParameters!='default')
			{
                $huellaOriginal=$this->listFootPrint(array("ID_FOOTPRINT"=>$arrParameters['ID_HUELLA_ORIGINAL']));
                $huellaComparar=$this->listFootPrint(array("ID_FOOTPRINT"=>$arrParameters['ID_HUELLA_COMPARAR']));
                //print_r($huellaOriginal);
                //print_r($huellaComparar);
                if($huellaOriginal->type=='success' || $huellaComparar->type=='success'){
                    $objReturn->type='success';
                    $objReturn->msg='comparador de huella';
                    
                    //OBJETOS A COMPARAR
                    $huellaDba=json_decode($huellaOriginal->data[0]['FOOTPRINT']);
                    $huellaSistema=json_decode($huellaComparar->data[0]['FOOTPRINT']);
                    //print_r($huellaDba);
                    //print_r($huellaSistema);
                    //exit();
                    //VERSIONES
                    $versionesHuella=$huellaDba->data->versiones;
                    $versioensSistemas=$huellaSistema->data->versiones;
                    $objReturn->data->versiones=array();
                    foreach ($versionesHuella as $key => $value){
                        $aux=new stdClass();
                        $aux->Variable_name=$value->Variable_name;
                        $aux->sha256=$value->sha256;
                        $aux->flagModificado=$this->searchObj('versiones',$versioensSistemas,$value->Variable_name,$value->sha256);
                        array_push($objReturn->data->versiones,$aux);
                    } 
                    //////////////////////////////////////TRIGGERS////////////////////////////////////////
                    $triggersHuella=$huellaDba->data->triggers;
                    $triggersSistemas=$huellaSistema->data->triggers;
                    $objReturn->data->triggers=array();
                    foreach ($triggersHuella as $key => $value){
                        $aux=new stdClass();
                        $aux->TRIGGER_NAME=$value->TRIGGER_NAME;
                        $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                        $aux->sha256=$value->sha256;
                        $aux->flagModificado=$this->searchObj('triggers',$triggersSistemas,$value->TRIGGER_NAME,$value->sha256);
                        array_push($objReturn->data->triggers,$aux);
                    }
                    //TRIGGERS ELIMINADAS
                    $objReturn->data->triggerEliminados=array();
                    $diffTriggerEliminados = array_udiff($triggersHuella,$triggersSistemas,
                        function ($obj_a, $obj_b){
                            return strcmp($obj_a->TRIGGER_NAME, $obj_b->TRIGGER_NAME);
                        }
                    );
                    foreach ($diffTriggerEliminados as $key => $value) {
                        $aux=new stdClass();
                        $aux->TRIGGER_NAME=$value->TRIGGER_NAME;
                        $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                        $aux->sha256=$value->sha256;
                        array_push($objReturn->data->triggerEliminados,$aux);
                    }
                    //TRIGGERS CREADAS
                    $objReturn->data->triggerCreados=array();
                    $diffTriggerCreados = array_udiff($triggersSistemas,$triggersHuella,
                        function ($obj_a, $obj_b){
                            return strcmp($obj_a->TRIGGER_NAME, $obj_b->TRIGGER_NAME);
                        }
                    );
                    foreach ($diffTriggerCreados as $key => $value){
                        $aux=new stdClass();
                        $aux->TRIGGER_NAME=$value->TRIGGER_NAME;
                        $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                        $aux->sha256=$value->sha256;
                        array_push($objReturn->data->triggerCreados,$aux);
                    }
                    //////////////////////////////////////VISTAS//////////////////////////////////////
                    $vistaHuella=$huellaDba->data->vistas;
                    $vistaSistemas=$huellaSistema->data->vistas;
                    $objReturn->data->vistas=array();
                    foreach ($vistaHuella as $key => $value){
                        $aux=new stdClass();
                        $aux->TABLE_NAME=$value->TABLE_NAME;
                        $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                        $aux->sha256=$value->sha256;
                        $aux->flagModificado=$this->searchObj('vistas',$vistaSistemas,$value->TABLE_NAME,$value->sha256);
                        array_push($objReturn->data->vistas,$aux);
                    }
                    //TABLAS ELIMINADAS
                    $objReturn->data->vistasEliminadas=array();
                    $diffVistasEliminadas = array_udiff($vistaHuella,$vistaSistemas,
                        function ($obj_a, $obj_b){
                            return strcmp($obj_a->TABLE_NAME, $obj_b->TABLE_NAME);
                        }
                    );
                    foreach ($diffVistasEliminadas as $key => $value) {
                        $aux=new stdClass();
                        $aux->TABLE_NAME=$value->TABLE_NAME;
                        $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                        $aux->sha256=$value->sha256;
                        array_push($objReturn->data->vistasEliminadas,$aux);
                    }
                    //TABLAS CREADAS
                    $objReturn->data->vistaCreadas=array();
                    $diffVistasCreadas = array_udiff($vistaSistemas,$vistaHuella,
                        function ($obj_a, $obj_b){
                            return strcmp($obj_a->TABLE_NAME, $obj_b->TABLE_NAME);
                        }
                    );
                    foreach ($diffVistasCreadas as $key => $value){
                        $aux=new stdClass();
                        $aux->TABLE_NAME=$value->TABLE_NAME;
                        $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                        $aux->sha256=$value->sha256;
                        array_push($objReturn->data->vistaCreadas,$aux);
                    }
                    ///////////////////////////////////////RUTINAS (PROCEDURE Y FUNCIONES)///////////////////////////////////////
                    $rutinasHuella=$huellaDba->data->rutinas;
                    $rutinasSistemas=$huellaSistema->data->rutinas;
                    $objReturn->data->rutinas=array();
                    foreach ($rutinasHuella as $key => $value){
                        $aux=new stdClass();
                        $aux->ROUTINE_NAME=$value->ROUTINE_NAME;
                        $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                        $aux->sha256=$value->sha256;
                        $aux->flagModificado=$this->searchObj('rutinas',$rutinasSistemas,$value->ROUTINE_NAME,$value->sha256);
                        array_push($objReturn->data->rutinas,$aux);
                    }
                    //TABLAS ELIMINADAS
                    $objReturn->data->rutinasEliminadas=array();
                    $diffRutinasEliminadas = array_udiff($rutinasHuella,$rutinasSistemas,
                        function ($obj_a, $obj_b){
                            return strcmp($obj_a->ROUTINE_NAME, $obj_b->ROUTINE_NAME);
                        }
                    );
                    foreach ($diffRutinasEliminadas as $key => $value) {
                        $aux=new stdClass();
                        $aux->ROUTINE_NAME=$value->ROUTINE_NAME;
                        $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                        $aux->sha256=$value->sha256;
                        array_push($objReturn->data->rutinasEliminadas,$aux);
                    }
                    //TABLAS CREADAS
                    $objReturn->data->rutinasCreadas=array();
                    $diffRutinasCreadas = array_udiff($rutinasSistemas,$rutinasHuella,
                        function ($obj_a, $obj_b){
                            return strcmp($obj_a->ROUTINE_NAME, $obj_b->ROUTINE_NAME);
                        }
                    );
                    foreach ($diffRutinasCreadas as $key => $value){
                        $aux=new stdClass();
                        $aux->ROUTINE_NAME=$value->ROUTINE_NAME;
                        $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                        $aux->sha256=$value->sha256;
                        array_push($objReturn->data->rutinasCreadas,$aux);
                    }
                    ///////////////////////////////////// TABLAS /////////////////////////////////////
                    $tablasHuella=$huellaDba->data->tablas;
                    $tablasSistemas=$huellaSistema->data->tablas;
                    $objReturn->data->tablas=array();
                    foreach ($tablasHuella as $key => $value){
                        $aux=new stdClass();
                        $aux->TABLA=$value->TABLA;
                        $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                        $aux->sha256=$value->sha256;
                        $aux->flagModificado=$this->searchObj('tablas',$tablasSistemas,$value->TABLA,$value->sha256);
                        array_push($objReturn->data->tablas,$aux);
                    }
                    //TABLAS ELIMINADAS
                    $objReturn->data->tablasEliminadas=array();
                    $diffTablasEliminadas = array_udiff($tablasHuella,$tablasSistemas,
                        function ($obj_a, $obj_b){
                            return strcmp($obj_a->TABLA, $obj_b->TABLA);
                        }
                    );
                    foreach ($diffTablasEliminadas as $key => $value) {
                        $aux=new stdClass();
                        $aux->TABLA=$value->TABLA;
                        $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                        $aux->sha256=$value->sha256;
                        array_push($objReturn->data->tablasEliminadas,$aux);
                    }
                    //TABLAS CREADAS
                    $objReturn->data->tablasCreadas=array();
                    $diffTablasCreadas = array_udiff($tablasSistemas,$tablasHuella,
                        function ($obj_a, $obj_b){
                            return strcmp($obj_a->TABLA, $obj_b->TABLA);
                        }
                    );
                    foreach ($diffTablasCreadas as $key => $value){
                        $aux=new stdClass();
                        $aux->TABLA=$value->TABLA;
                        $aux->ROUTINE_TYPE=$value->ROUTINE_TYPE;
                        $aux->sha256=$value->sha256;
                        array_push($objReturn->data->tablasCreadas,$aux);
                    }
                    
                }else{
                    throw new Exception("error comparando huellas");
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

}    