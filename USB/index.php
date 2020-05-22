<!--Pagina Inicial Latin's Dynamic Diseño Andres F. Quintero 2020-05-16-->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Login</title>
	<link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
	<!-- Fixed navbar -->
	<nav class="nav">
		<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Latin's Dynamic</a>
	</nav>
	<br>
	<br>
	<!--INICIO LOGIN-->
	<div class="container">
		<div class="card">
			<div class="card-header">Iniciar Sesion</div>
			<div class="card-body">
				<div class="form-group">
					<label>Login</label>
					<input type="text" class="form-control" id="login"  placeholder="Login">
				</div>
				<div class="form-group">
					<label>Password</label>
					<input type="password" class="form-control" id="password" placeholder="Password" onkeypress="enterLogin(event);">
				</div>
				<div class="form-group">
					<div id="response" class="text-center"></div>
				</div>
				<button type="button" class="btn btn-primary" id="authentication" onclick="authentication();">Ingresar</button>
			</div> 
		</div>
	</div>
</body>
<script src="js/jquery-3.4.1.min.js"></script>
<script src="js/bootstrap.min.js"></script>  
<script src="js/index.js"></script>
</html>