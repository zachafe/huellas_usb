<?php
if (isset($_SESSION['ingreso']) && $_SESSION['ingreso'] == 'YES')
{
?>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">Latin's Dynami</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
<div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto ">
      <li class="nav-item active dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">DBA</a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" onclick='menuPermission("menu","registerDba");'>Registrar DBA</a>
          <a class="dropdown-item" onclick='menuPermission("menu","listDba");'>Listar DBA</a>
        </div>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Huellas</a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item" onclick='menuPermission("menu","createFootprint");'>Crear Huella</a>
          <a class="dropdown-item" onclick='menuPermission("menu","listFootPrint");'>Listar Huellas</a>
        </div>
      </li>
    </ul>
    <!--INFORMACION DE SESSION-->
    <ul class="navbar-nav right">
        <li class="nav-item active dropdown">
        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <?php echo $_SESSION['mail'];?>
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
          <a class="dropdown-item"><b><?php echo $_SESSION['perfil'];?></b></a>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" onclick="logout();">Cerrar Session</a>
        </div>
      </li>
    </ul> 
  </div>
</nav>
<br>
<br>
<?php
}
else
{
  header("location:../");
}