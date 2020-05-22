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
	<title>Crear Huella</title>
	<link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>
	<!-- MENU navbar -->
	<?php require_once 'navbarHaderView.php';?>	
    <center>
	<div class="container">
    	<div class="card text-left">
			<div class="card-header"><center>Crear Huella</center></div>
			<div class="card-body">
				<!--INICIO-->
				<form>
					<div class="form-row">
                        <div class="form-group col-md-12">
							<label for="selectDba">Selecionar DBA</label>
							<select id="selectDba" class="form-control">
								  <option value="0" selected>Seleccionar DBA</option>
	                        </select>
						</div>
                    </div>
                    <div class="form-row">
						<div class="form-group col-md-6">
							<label for="name">User:</label>
							<input type="text" class="form-control" id="strUser" placeholder="USER" disabled>
						</div>
						<div class="form-group col-md-6">
							<label for="lastname">Password:</label>
							<input type="password" class="form-control" id="strPassword" placeholder="PASSWORD" disabled>
						</div>
                    </div>
                    <div class="form-row">
						<div class="form-group col-md-6">
							<label for="name">Ip:</label>
							<input type="text" class="form-control" id="strIp" placeholder="127.0.0.1" disabled>
						</div>
						<div class="form-group col-md-6">
							<label for="lastname">Nombre DBA</label>
							<input type="text" class="form-control" id="strDbaName" placeholder="MYDBA" disabled>
						</div>
					</div>
					<div class="form-group">
						<div id="response" class="text-center"></div>
					</div>
					<!-- PINTAR HUELLA -->
					<div id="accordion">
						<div class="card">
							<div class="card-header">
								<a class="card-link" data-toggle="collapse" href="#version">Variables Globales</a>
							</div>
							<div id="version" class="collapse show" data-parent="#accordion">
								<div class="card-body">
									<div id="versionData"></div>
								</div>
							</div>
						</div>
						<div class="card">
							<div class="card-header">
								<a class="card-link" data-toggle="collapse" href="#tablas">Tablas</a>
							</div>
							<div id="tablas" class="collapse" data-parent="#accordion">
								<div class="card-body">
									<div id="tablasData"></div>
								</div>
							</div>
						</div>
						<div class="card">
							<div class="card-header">
								<a class="collapsed card-link" data-toggle="collapse" href="#rutinas">Rutinas</a>
							</div>
							<div id="rutinas" class="collapse" data-parent="#accordion">
								<div class="card-body">
									<div id="rutinasData"></div>
								</div>
							</div>
						</div>
						<div class="card">
							<div class="card-header">
								<a class="collapsed card-link" data-toggle="collapse" href="#triggers">Triggers</a>
							</div>
							<div id="triggers" class="collapse" data-parent="#accordion">
								<div class="card-body">
									<div id="triggersData"></div>
								</div>
							</div>
						</div>
						<div class="card">
							<div class="card-header">
								<a class="collapsed card-link" data-toggle="collapse" href="#vistas">Vistas</a>
							</div>
							<div id="vistas" class="collapse" data-parent="#accordion">
								<div class="card-body">
									<div id="vistasData"></div>
								</div>
							</div>
						</div>
					</div> 
					<br>
					<!-- FIN DE PINTAR HUELLA -->
					<div class="form-row">
						<div class="form-group col-md-4">
							<button type="button" class="btn btn-primary" id="buttonGenerarHuella">Generar Huella</button>
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
<script src="../js/creteFootprint.js"></script> 
</html>
<?php
} else {
	header("location:../");
}