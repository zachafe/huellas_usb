<?php
session_start();
//print_r($_SESSION);
if (isset($_SESSION['ingreso']) && $_SESSION['ingreso'] == 'YES')
{
?>
<!--Pagina principal USB Diseño Andres F. Quintero 2020-05-17-->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Principal</title>
	<link rel="stylesheet" href="../css/bootstrap.min.css">
</head>
<body>
	<!-- MENU navbar -->
	<?php require_once 'navbarHaderView.php';?>	
    <center>
	<div class="container">
    	<div class="card text-center">
			<div class="card-header">Bienvenido a Latin's Dynamic</div>
			<div class="card-body">
				<h5 class="card-title">Sistema Integrado de Gestion de Huellas DBA</h5>
				<div>
					<img src="../images/principal.jpeg">	
				</div>
				<div class="form-group">
					<div id="response" class="text-center"></div>
				</div>
			</div> 
		</div>
	</div>
    </center>
</body>
<script src="../js/jquery-3.4.1.min.js"></script>
<script src="../js/bootstrap.min.js"></script>  
<script src="../js/main.js"></script>  
</html>
<?php
} else {
	header("location:../");
}