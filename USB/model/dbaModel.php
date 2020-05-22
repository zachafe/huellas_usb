<?php
/**
* Clase para conectar a dba MYSQL
*
* Permite Conectar base de datos MYSQL
*
* @package dbaModel
* @author Andres Felipe Quintero <afquinterot@correo.usbcali.edu.co>
* @copyright Todos los derechos reservados. USB. 2020.
* @since Versión 1.0, revisión 20200516.
* @version 1.0
*/
abstract class dbaModel{

    protected  $strHost='localhost';
    protected  $strUser='root';
    protected  $strPass='felipe';
    protected  $strDbName='USB_APP';
    protected  $strQuery;
    private    $conn;
    /**
	*
	* Realizar la conexion con DBA MYSQL
	*
	* @package dbaModel.connection
	* @author Andres Felipe Quintero <afquinterot@correo.usbcali.edu.co>
	* @copyright Todos los derechos reservados. USB. 2020.
	* @since Versión 1.0, revisión 20200516.
	* @version 1.0
	*/
    private function connection(){
        $this->conn= new mysqli($this->strHost,$this->strUser,$this->strPass,$this->strDbName);
    }
    /**
	*
	* Realizar la desconexion con DBA MYSQL
	*
	* @package dbaModel.disconnection
	* @author Andres Felipe Quintero <afquinterot@correo.usbcali.edu.co>
	* @copyright Todos los derechos reservados. USB. 2020.
	* @since Versión 1.0, revisión 20200516.
	* @version 1.0
    */
    private function disconnection(){
        $this->conn->close();
    }
    /**
	* Metodo para ejectuar query tipo SELECT,INSERTE,DELETE,UPDATE en DBA MYSQL
	*
	* @package userModel.executeSelect
	* @author Andres Felipe Quintero <afquinterot@correo.usbcali.edu.co>
    * @copyright Todos los derechos reservados. USB. 2020.
    * @param string $strType query, sentencia
    * @return object $obj Retorna objeto
	* @since Versión 1.0, revisión 20200516.
	* @version 1.0
	*/
    public function executeSql($strType){
        $objReturn = new stdClass;
        $objReturn->sql=$this->strQuery;
        $arrData= array();
        $this->connection();
        try {
            //VALIDAR CONEXION
            if(!$this->conn->connect_error){
                $resultado=$this->conn->query($this->strQuery);
                //VALIDAR SENTENCIA SQL
                if($resultado){

                    switch ($strType){
                        case 'query':
                                //LLEGAR ARRAGLO
                                while ($drFila = $resultado->fetch_array(MYSQLI_ASSOC)) {
                                    $arrData[] = $drFila;//	Agregar fila al arreglo de resultados
                                }
                                if(!empty($arrData)){
                                    $objReturn->tipo="succes";
                                    $objReturn->msg="se encontro la informacion";
                                    $objReturn->data=$arrData;
                                }else{
                                    throw new Exception("sql no obtuvo informacion");
                                }
                            break;
                        case 'sentencia':
                                $arrData['affected_rows']=$this->conn->affected_rows;
                                $arrData['insert_id']=$this->conn->insert_id;
                                $arrData['error']=$this->conn->error;
                                $objReturn->data=$arrData;
                                if($this->conn->insert_id!=0 || $this->conn->affected_rows!=0){
                                    $objReturn->tipo="succes";
                                    $objReturn->msg="se ejecuto correctamente SQL";
                                }else{
                                    throw new Exception("no se realizo ninguna modificacion");
                                }
                            break;
                        default:
                                throw new Exception("Metodo no encontrado");
                            break;
                    }
                    $this->disconnection();
                }
                else{
                    $error= preg_replace('/\'/','',$this->conn->error);
                    throw new Exception("Error Sql".$error);     
                }
            }else{
               throw new Exception("Error conectado a la DBA".$this->conn->connect_error);
            }
        }catch (Exception $e){
            $objReturn->tipo="error";
            $objReturn->msg=$e->getMessage();
        }
        return $objReturn;
    }
}

