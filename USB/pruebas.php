<?php
$fecha = date_create_from_format('m/d/Y', 'Feb/15/2009');
echo date_format($fecha, 'Y-m-d');
