<?php
session_start();
//print_r($_SESSION);
if (isset($_SESSION['ingreso']) && $_SESSION['ingreso'] == 'YES')
{
	$method="createDba";
	$id="default";
	if(isset($_REQUEST['method']) && isset($_REQUEST['id']))
	{
		$method=$_REQUEST['method'];
		$id=$_REQUEST['id'];
	}
?>
<!--Pagina principal medical Group Diseño Andres F. Quintero 2020-05-17-->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Registrar DBA</title>
	<link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>
	<!-- MENU navbar -->
	<?php require_once 'navbarHaderView.php';?>	
    <center>
	<div class="container">
    	<div class="card text-left">
			<div class="card-header"><center>Registrar DBA</center></div>
			<div class="card-body">
				<!--INICIO-->
				<form>
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="name">Ip:</label>
							<input type="text" class="form-control" id="strIp" placeholder="127.0.0.1">
						</div>
						<div class="form-group col-md-6">
							<label for="lastname">Nombre DBA</label>
							<input type="text" class="form-control" id="strDbaName" placeholder="MYDBA">
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="name">User:</label>
							<input type="text" class="form-control" id="strUser" placeholder="USER">
						</div>
						<div class="form-group col-md-6">
							<label for="lastname">Password:</label>
							<input type="password" class="form-control" id="strPassword" placeholder="PASSWORD">
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="typeDba">Tipo DBA</label>
							<select id="typeDba" class="form-control">
								  <option value="0" selected>Seleccionar T. DBA</option>
	                              <option value="MYSQL">MYSQL</option>
	                        </select>
						</div>
					</div>
					<div class="form-group">
							<label for="observation">Observacion</label>
							<textarea class="form-control" id="observation" rows="2"></textarea>
					</div>
					<div class="form-group">
						<div id="response" class="text-center"></div>
					</div>
					<div class="form-row">
						<div class="form-group col-md-4">
							<button type="button" class="btn btn-primary" id="buttonCreateDba">Crear DBA</button>
						</div>
						<div class="form-group col-md-4">
							<button type="button" class="btn btn-success" id="buttonEdit">Editar DBA</button>
						</div>	
						<div class="form-group col-md-4">
							<button type="button" class="btn btn-secondary" id="buttonCleanFields">Limpiar Campos</button>
						</div>	
					</div>	
				</form>
				<!--fin -->	
			</div> 
			
		</div>
	</div>
    </center>
</body>
<script src="../js/jquery-3.4.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/main.js"></script> 
<script>var method = '<?php echo $method;?>';var id = '<?php echo $id;?>';</script> 
<script src="../js/crearDba.js"></script> 
</html>
<?php
} else {
	header("location:../");
}