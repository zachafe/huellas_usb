<?php
session_start();
//print_r($_SESSION);
if (isset($_SESSION['ingreso']) && $_SESSION['ingreso'] == 'YES')
{
?>
<!--Pagina principal medical Group Diseño Andres F. Quintero 2020-05-18-->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Listar Dba</title>
	<link rel="stylesheet" href="../css/bootstrap.min.css">
	<link rel="stylesheet" type="text/css" href="../lib/DataTables/datatables.min.css"/>
</head>
<body>
	<!-- MENU navbar -->
	<?php require_once 'navbarHaderView.php';?>	
    <!-- BIENVENIDAD MEDICALGROUP -->
    	<div class="container">
    		<div class="table-responsive">
    			<table class="table table-striped table-hover table-condensed" id="myTable">
    				<thead>
    					<tr>
    						<th>Name DBA</th>
    						<th>IP DBA</th>
    						<th>User DBA</th>
    						<th>TIPO DBA</th>
                            <th>FECHA CREACION DBA</th>
                            <th>CREADO POR</th>
    						<th>OBSERVACION</th>
    						<th>Opciones</th>
    					</tr>
    				</thead>
    				<tbody id="dataTable">
    					<!--DATA -->
    				</tbody>
    			</table>
    		</div>
    		<div class="form-group">
				<div id="response" class="text-center"></div>
			</div>
    	</div>	
    
</body>
<script src="../js/jquery-3.4.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>   
<script src="../js/listDba.js"></script> 
<script src="../js/main.js"></script> 
<script type="text/javascript" src="../lib/DataTables/datatables.min.js"></script>
</html>
<?php
} else {
	header("location:../");
}