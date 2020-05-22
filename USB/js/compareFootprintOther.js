$(function(){
    //LISTAR DBA
    var parametros = id.split("-");
    var fkDba=parametros['0'];
    var idHuella=parametros['1'];
	var arrData = new Object();
    arrData.FK_DBA=fkDba;
    var parameters = {'object':'footPrint','method':'listFootPrint','parameters':arrData};
    $.ajax({
            url:'../controller/frontController.php',
            type:'POST',
            data:parameters,
            beforeSend: function(objeto){
            $("#response").html("<img src='../images/loader.gif'>");
            },
            success:function(data)
            {
                $("#response").html("");
                var parsed = JSON.parse(data);
                if (parsed.type==='success')
                {   
                    $("#idHuellaOriginal").val(idHuella);
                    $("#strUser").val(parsed.data[0]['USER']);
                    $("#strPassword").val(parsed.data[0]['PASSWORDDB']);
                    $("#strIp").val(parsed.data[0]['IP']);
                    $("#strDbaName").val(parsed.data[0]['NAME']);
                    var strPrintout="<option value='0' selected>Seleccionar Huella</option>";
                    //ARMAR STRING
                    for(var x in parsed.data)
                    {
                        if(parsed.data[x]['ID_FOOTPRINT']!=idHuella){
                            //console.warn(parsed.data[x]['nombre_departamento']);
                            strPrintout+="<option value="+parsed.data[x]['ID_FOOTPRINT']+">"+parsed.data[x]['NAME']+'-'+parsed.data[x]['CREATION_DATE']+"</option>";
                        }
                          
                    } 
                    $(selectHuella).html(strPrintout); 
                }
                else 
                {
                    var strPrintout='';
                    strPrintout+='<div class="alert alert-danger" role="alert">';
                    strPrintout+='<center>'+parsed.msg+'</center>';
                    strPrintout+='</center>';
                    strPrintout+='</div>';
                    $("#response").html(strPrintout);
                }  
            }
    });
});	
$("#selectHuella").change(function(){
    var idHuella=idHuellaOriginal.value;
    var idHuellaComparar=selectHuella.value;
    var arrData = new Object();
    arrData.ID_HUELLA_ORIGINAL=idHuella;
    arrData.ID_HUELLA_COMPARAR=idHuellaComparar;
    //console.warn(arrData);
    if(id!='0'){
        var parameters = {'object':'footPrint','method':'compareFootprintOther','parameters':arrData};
        $.ajax({
            url:'../controller/frontController.php',
            type:'POST',
            data:parameters,
            beforeSend: function(objeto){
            $("#response").html("<img src='../images/loader.gif'>");
            },
            success:function(data)
            {
                $("#response").html("");
                var parsed = JSON.parse(data);
                console.warn(parsed);
                if (parsed.type==='success')
                {   
                    //PINTAR VERSIONES
                    var strPrintoutVersiones='';
                    if(parsed.data.versiones.length > 0){
                        //console.warn("entro");
                        for(var x in parsed.data.versiones)
                            {
                                if(parsed.data.versiones[x].flagModificado==1){
                                    strPrintoutVersiones+='<div class="form-row alert alert-danger">';
                                }else{
                                    strPrintoutVersiones+='<div class="form-row">';
                                }
                                //console.warn(x);
                                //console.warn(parsed.data.tablas[x].TABLA);
                                strPrintoutVersiones+='<div class="form-group col-md-3">';
                                strPrintoutVersiones+='<label for="name">Nombre de la Variable:</label>';
                                strPrintoutVersiones+='<input type="text" class="form-control" value="'+parsed.data.versiones[x].Variable_name+'" disabled>';
                                strPrintoutVersiones+='</div>';
                                strPrintoutVersiones+='<div class="form-group col-md-9">';
                                strPrintoutVersiones+='<label for="lastname">Codigo sha256</label>';
                                strPrintoutVersiones+='<input type="text" class="form-control"value="'+parsed.data.versiones[x].sha256+'" disabled>';
                                strPrintoutVersiones+='</div>';
                                strPrintoutVersiones+='</div>';
                            } 
                    }else{
                            strPrintoutVersiones+='<div class="alert alert-warning" role="alert">';
                            strPrintoutVersiones+='<center>No Contiene tablas la dba</center>';
                            strPrintoutVersiones+='</center>';
                            strPrintoutVersiones+='</div>';
                    }
                    $("#versionData").html(strPrintoutVersiones);
                    //PINTAR TABLAS
                    var strPrintoutTablas='';
                    if(parsed.data.tablas.length > 0){
                        //console.warn("entro");
                        for(var x in parsed.data.tablas)
                            {
                                if(parsed.data.tablas[x].flagModificado==1){
                                    strPrintoutTablas+='<div class="form-row alert alert-danger">';
                                }else{
                                    strPrintoutTablas+='<div class="form-row">';
                                }
                                //console.warn(x);
                                //console.warn(parsed.data.tablas[x].TABLA);
                                strPrintoutTablas+='<div class="form-group col-md-3">';
                                strPrintoutTablas+='<label for="name">Nombre de la Tabla:</label>';
                                strPrintoutTablas+='<input type="text" class="form-control" value="'+parsed.data.tablas[x].TABLA+'" disabled>';
                                strPrintoutTablas+='</div>';
                                strPrintoutTablas+='<div class="form-group col-md-9">';
                                strPrintoutTablas+='<label for="lastname">Codigo sha256</label>';
                                strPrintoutTablas+='<input type="text" class="form-control"value="'+parsed.data.tablas[x].sha256+'" disabled>';
                                strPrintoutTablas+='</div>';
                                strPrintoutTablas+='</div>';
                            } 
                    }else{
                            strPrintoutTablas+='<div class="alert alert-warning" role="alert">';
                            strPrintoutTablas+='<center>No Contiene tablas la dba</center>';
                            strPrintoutTablas+='</center>';
                            strPrintoutTablas+='</div>';
                    }
                    $("#tablasData").html(strPrintoutTablas);
                    //PINTAR TABLAS ELIMINADAS 
                    var strPrintoutTablasEliminadas='';
                    if(parsed.data.tablasEliminadas.length > 0){
                        //console.warn("entro");
                        strPrintoutTablasEliminadas+='<div class="alert alert-danger" role="alert">Tablas Eliminadas</div>';
                        for(var x in parsed.data.tablasEliminadas)
                            {
                                //console.warn(x);
                                //console.warn(parsed.data.tablas[x].TABLA);
                                strPrintoutTablasEliminadas+='<div class="form-row">';
                                strPrintoutTablasEliminadas+='<div class="form-group col-md-3">';
                                strPrintoutTablasEliminadas+='<label for="name">Nombre de la Tabla:</label>';
                                strPrintoutTablasEliminadas+='<input type="text" class="form-control" value="'+parsed.data.tablasEliminadas[x].TABLA+'" disabled>';
                                strPrintoutTablasEliminadas+='</div>';
                                strPrintoutTablasEliminadas+='<div class="form-group col-md-9">';
                                strPrintoutTablasEliminadas+='<label for="lastname">Codigo sha256</label>';
                                strPrintoutTablasEliminadas+='<input type="text" class="form-control"value="'+parsed.data.tablasEliminadas[x].sha256+'" disabled>';
                                strPrintoutTablasEliminadas+='</div>';
                                strPrintoutTablasEliminadas+='</div>';
                            } 
                    }else{
                            strPrintoutTablasEliminadas+='<div class="alert alert-warning" role="alert">';
                            strPrintoutTablasEliminadas+='<center>No Contiene tablas eliminadas</center>';
                            strPrintoutTablasEliminadas+='</center>';
                            strPrintoutTablasEliminadas+='</div>';
                    }
                    $("#tablasEliminadasData").html(strPrintoutTablasEliminadas);
                    //PINTAR TABLA CREADAS
                    var strPrintoutTablasCreadas='';
                    if(parsed.data.tablasCreadas.length > 0){
                        //console.warn("entro");
                        strPrintoutTablasCreadas+='<div class="alert alert-danger" role="alert">Tablas Creadas</div>';
                        for(var x in parsed.data.tablasCreadas)
                            {
                                //console.warn(x);
                                //console.warn(parsed.data.tablas[x].TABLA);
                                strPrintoutTablasCreadas+='<div class="form-row">';
                                strPrintoutTablasCreadas+='<div class="form-group col-md-3">';
                                strPrintoutTablasCreadas+='<label for="name">Nombre de la Tabla:</label>';
                                strPrintoutTablasCreadas+='<input type="text" class="form-control" value="'+parsed.data.tablasCreadas[x].TABLA+'" disabled>';
                                strPrintoutTablasCreadas+='</div>';
                                strPrintoutTablasCreadas+='<div class="form-group col-md-9">';
                                strPrintoutTablasCreadas+='<label for="lastname">Codigo sha256</label>';
                                strPrintoutTablasCreadas+='<input type="text" class="form-control"value="'+parsed.data.tablasCreadas[x].sha256+'" disabled>';
                                strPrintoutTablasCreadas+='</div>';
                                strPrintoutTablasCreadas+='</div>';
                            } 
                    }else{
                            strPrintoutTablasCreadas+='<div class="alert alert-warning" role="alert">';
                            strPrintoutTablasCreadas+='<center>No Contiene tablas creadas</center>';
                            strPrintoutTablasCreadas+='</center>';
                            strPrintoutTablasCreadas+='</div>';
                    }
                    $("#tablasCreadasData").html(strPrintoutTablasCreadas);
                    //Rutinas
                    var strPrintoutRutinas='';
                    if(parsed.data.rutinas.length > 0){
                            //console.warn("entro");
                            for(var x in parsed.data.rutinas)
                            {
                                if(parsed.data.rutinas[x].flagModificado==1){
                                    strPrintoutRutinas+='<div class="form-row alert alert-danger">';
                                }else{
                                    strPrintoutRutinas+='<div class="form-row">';
                                }
                                //console.warn(x);
                                //console.warn(parsed.data.tablas[x].TABLA);
                                strPrintoutRutinas+='<div class="form-group col-md-3">';
                                strPrintoutRutinas+='<label for="name">Nombre de la Rutina:</label>';
                                strPrintoutRutinas+='<input type="text" class="form-control" value="'+parsed.data.rutinas[x].ROUTINE_NAME+'" disabled>';
                                strPrintoutRutinas+='</div>';
                                strPrintoutRutinas+='<div class="form-group col-md-2">';
                                strPrintoutRutinas+='<label for="name">Tipo de rutina:</label>';
                                strPrintoutRutinas+='<input type="text" class="form-control" value="'+parsed.data.rutinas[x].ROUTINE_TYPE+'" disabled>';
                                strPrintoutRutinas+='</div>';
                                strPrintoutRutinas+='<div class="form-group col-md-7">';
                                strPrintoutRutinas+='<label for="name">Codigo sha256:</label>';
                                strPrintoutRutinas+='<input type="text" class="form-control" value="'+parsed.data.rutinas[x].sha256+'" disabled>';
                                strPrintoutRutinas+='</div>';
                                strPrintoutRutinas+='</div>';
                            } 
                        }else{
                            //console.warn("no encontro rutinas");
                            strPrintoutRutinas+='<div class="alert alert-warning" role="alert">';
                            strPrintoutRutinas+='<center>No contienen rutinas la DBA</center>';
                            strPrintoutRutinas+='</center>';
                            strPrintoutRutinas+='</div>';
                        }
                        $("#rutinasData").html(strPrintoutRutinas);
                        
                        //PINTAR RUTINAS ELIMINADAS 
                        var strPrintoutRutinasEliminadas='';
                        if(parsed.data.rutinasEliminadas.length > 0){
                            //console.warn("entro");
                            strPrintoutRutinasEliminadas+='<div class="alert alert-danger" role="alert">Rutinas Eliminadas</div>';
                            for(var x in parsed.data.rutinasEliminadas)
                                {
                                    //console.warn(x);
                                    //console.warn(parsed.data.tablas[x].TABLA);
                                    strPrintoutRutinasEliminadas+='<div class="form-row">';
                                    strPrintoutRutinasEliminadas+='<div class="form-group col-md-3">';
                                    strPrintoutRutinasEliminadas+='<label for="name">Nombre de la Rutina:</label>';
                                    strPrintoutRutinasEliminadas+='<input type="text" class="form-control" value="'+parsed.data.rutinasEliminadas[x].ROUTINE_NAME+'" disabled>';
                                    strPrintoutRutinasEliminadas+='</div>';
                                    strPrintoutRutinasEliminadas+='<div class="form-group col-md-2">';
                                    strPrintoutRutinasEliminadas+='<label for="name">Tipo de rutina:</label>';
                                    strPrintoutRutinasEliminadas+='<input type="text" class="form-control" value="'+parsed.data.rutinasEliminadas[x].ROUTINE_TYPE+'" disabled>';
                                    strPrintoutRutinasEliminadas+='</div>';
                                    strPrintoutRutinasEliminadas+='<div class="form-group col-md-7">';
                                    strPrintoutRutinasEliminadas+='<label for="name">Codigo sha256:</label>';
                                    strPrintoutRutinasEliminadas+='<input type="text" class="form-control" value="'+parsed.data.rutinasEliminadas[x].sha256+'" disabled>';
                                    strPrintoutRutinasEliminadas+='</div>';
                                    strPrintoutRutinasEliminadas+='</div>';
                                } 
                        }else{
                                strPrintoutRutinasEliminadas+='<div class="alert alert-warning" role="alert">';
                                strPrintoutRutinasEliminadas+='<center>No Contiene Rutinas eliminadas</center>';
                                strPrintoutRutinasEliminadas+='</center>';
                                strPrintoutRutinasEliminadas+='</div>';
                        }
                        $("#rutinasEliminadasData").html(strPrintoutRutinasEliminadas);
                        //RUTINAS CREADAS
                        var strPrintoutRutinasCreadas='';
                        if(parsed.data.rutinasCreadas.length > 0){
                            //console.warn("entro");
                            strPrintoutRutinasCreadas+='<div class="alert alert-danger" role="alert">Rutinas Creadas</div>';
                            for(var x in parsed.data.rutinasCreadas)
                                {
                                    //console.warn(x);
                                    //console.warn(parsed.data.tablas[x].TABLA);
                                    strPrintoutRutinasCreadas+='<div class="form-row">';
                                    strPrintoutRutinasCreadas+='<div class="form-group col-md-3">';
                                    strPrintoutRutinasCreadas+='<label for="name">Nombre de la Rutina:</label>';
                                    strPrintoutRutinasCreadas+='<input type="text" class="form-control" value="'+parsed.data.rutinasCreadas[x].ROUTINE_NAME+'" disabled>';
                                    strPrintoutRutinasCreadas+='</div>';
                                    strPrintoutRutinasCreadas+='<div class="form-group col-md-2">';
                                    strPrintoutRutinasCreadas+='<label for="name">Tipo de rutina:</label>';
                                    strPrintoutRutinasCreadas+='<input type="text" class="form-control" value="'+parsed.data.rutinasCreadas[x].ROUTINE_TYPE+'" disabled>';
                                    strPrintoutRutinasCreadas+='</div>';
                                    strPrintoutRutinasCreadas+='<div class="form-group col-md-7">';
                                    strPrintoutRutinasCreadas+='<label for="name">Codigo sha256:</label>';
                                    strPrintoutRutinasCreadas+='<input type="text" class="form-control" value="'+parsed.data.rutinasCreadas[x].sha256+'" disabled>';
                                    strPrintoutRutinasCreadas+='</div>';
                                    strPrintoutRutinasCreadas+='</div>';
                                } 
                        }else{
                                strPrintoutRutinasCreadas+='<div class="alert alert-warning" role="alert">';
                                strPrintoutRutinasCreadas+='<center>No Contiene Rutinas creadas</center>';
                                strPrintoutRutinasCreadas+='</center>';
                                strPrintoutRutinasCreadas+='</div>';
                        }
                        $("#rutinasCreadasData").html(strPrintoutRutinasCreadas);
                        //TRIGGERS
                        var strPrintoutTriggers='';
                        if(parsed.data.triggers.length > 0){
                                //console.warn("entro");
                                for(var x in parsed.data.triggers)
                                {
                                    if(parsed.data.triggers[x].flagModificado==1){
                                        strPrintoutTriggers+='<div class="form-row alert alert-danger">';
                                    }else{
                                        strPrintoutTriggers+='<div class="form-row">';
                                    }
                                    //console.warn(x);
                                    //console.warn(parsed.data.tablas[x].TABLA);
                                    strPrintoutTriggers+='<div class="form-group col-md-3">';
                                    strPrintoutTriggers+='<label for="name">Nombre del Trigger:</label>';
                                    strPrintoutTriggers+='<input type="text" class="form-control" value="'+parsed.data.triggers[x].TRIGGER_NAME+'" disabled>';
                                    strPrintoutTriggers+='</div>';
                                    strPrintoutTriggers+='<div class="form-group col-md-9">';
                                    strPrintoutTriggers+='<label for="name">Codigo sha256:</label>';
                                    strPrintoutTriggers+='<input type="text" class="form-control" value="'+parsed.data.triggers[x].sha256+'" disabled>';
                                    strPrintoutTriggers+='</div>';
                                    strPrintoutTriggers+='</div>';
                                } 
                        }else{
                            //console.warn("no encontro rutinas");
                            strPrintoutTriggers+='<div class="alert alert-warning" role="alert">';
                            strPrintoutTriggers+='<center>No contienen triggers la DBA</center>';
                            strPrintoutTriggers+='</center>';
                            strPrintoutTriggers+='</div>';
                        }
                        $("#triggersData").html(strPrintoutTriggers);
                        //TRIGGER ELIMINADOS
                        var strPrintoutTriggersEliminadas='';
                        if(parsed.data.triggerEliminados.length > 0){
                            //console.warn("entro");
                            strPrintoutTriggersEliminadas+='<div class="alert alert-danger" role="alert">Triggers Eliminadas</div>';
                            for(var x in parsed.data.triggerEliminados)
                                {
                                    //console.warn(x);
                                    //console.warn(parsed.data.tablas[x].TABLA);
                                    strPrintoutTriggersEliminadas+='<div class="form-row">';
                                    strPrintoutTriggersEliminadas+='<div class="form-group col-md-3">';
                                    strPrintoutTriggersEliminadas+='<label for="name">Nombre del Trigger:</label>';
                                    strPrintoutTriggersEliminadas+='<input type="text" class="form-control" value="'+parsed.data.triggerEliminados[x].TRIGGER_NAME+'" disabled>';
                                    strPrintoutTriggersEliminadas+='</div>';
                                    strPrintoutTriggersEliminadas+='<div class="form-group col-md-9">';
                                    strPrintoutTriggersEliminadas+='<label for="name">Codigo sha256:</label>';
                                    strPrintoutTriggersEliminadas+='<input type="text" class="form-control" value="'+parsed.data.triggerEliminados[x].sha256+'" disabled>';
                                    strPrintoutTriggersEliminadas+='</div>';
                                    strPrintoutTriggersEliminadas+='</div>';
                                } 
                        }else{
                                strPrintoutTriggersEliminadas+='<div class="alert alert-warning" role="alert">';
                                strPrintoutTriggersEliminadas+='<center>No Contiene Triggers eliminados</center>';
                                strPrintoutTriggersEliminadas+='</center>';
                                strPrintoutTriggersEliminadas+='</div>';
                        }
                        $("#triggersEliminadasData").html(strPrintoutTriggersEliminadas);
                        //TRIGGER CREADOS
                        var strPrintoutTriggersCreadoss='';
                        if(parsed.data.triggerCreados.length > 0){
                            //console.warn("entro");
                            strPrintoutTriggersCreadoss+='<div class="alert alert-danger" role="alert">Triggers Creados</div>';
                            for(var x in parsed.data.triggerCreados)
                                {
                                    //console.warn(x);
                                    //console.warn(parsed.data.tablas[x].TABLA);
                                    strPrintoutTriggersCreadoss+='<div class="form-row">';
                                    strPrintoutTriggersCreadoss+='<div class="form-group col-md-3">';
                                    strPrintoutTriggersCreadoss+='<label for="name">Nombre del Trigger:</label>';
                                    strPrintoutTriggersCreadoss+='<input type="text" class="form-control" value="'+parsed.data.triggerCreados[x].TRIGGER_NAME+'" disabled>';
                                    strPrintoutTriggersCreadoss+='</div>';
                                    strPrintoutTriggersCreadoss+='<div class="form-group col-md-9">';
                                    strPrintoutTriggersCreadoss+='<label for="name">Codigo sha256:</label>';
                                    strPrintoutTriggersCreadoss+='<input type="text" class="form-control" value="'+parsed.data.triggerCreados[x].sha256+'" disabled>';
                                    strPrintoutTriggersCreadoss+='</div>';
                                    strPrintoutTriggersCreadoss+='</div>';
                                } 
                        }else{
                                strPrintoutTriggersCreadoss+='<div class="alert alert-warning" role="alert">';
                                strPrintoutTriggersCreadoss+='<center>No Contiene Triggers Creados</center>';
                                strPrintoutTriggersCreadoss+='</center>';
                                strPrintoutTriggersCreadoss+='</div>';
                        }
                        $("#triggersCreadasData").html(strPrintoutTriggersCreadoss);
                        //VISTAS
                        var strPrintoutVistas='';
                        if(parsed.data.vistas.length > 0){
                                //console.warn("entro");
                                for(var x in parsed.data.vistas)
                                {
                                    if(parsed.data.vistas[x].flagModificado==1){
                                        strPrintoutVistas+='<div class="form-row alert alert-danger">';
                                    }else{
                                        strPrintoutVistas+='<div class="form-row">';
                                    }
                                    //console.warn(x);
                                    //console.warn(parsed.data.tablas[x].TABLA);
                                    strPrintoutVistas+='<div class="form-group col-md-3">';
                                    strPrintoutVistas+='<label for="name">Nombre de la vista:</label>';
                                    strPrintoutVistas+='<input type="text" class="form-control" value="'+parsed.data.vistas[x].TABLE_NAME+'" disabled>';
                                    strPrintoutVistas+='</div>';
                                    strPrintoutVistas+='<div class="form-group col-md-9">';
                                    strPrintoutVistas+='<label for="name">Codigo sha256:</label>';
                                    strPrintoutVistas+='<input type="text" class="form-control" value="'+parsed.data.vistas[x].sha256+'" disabled>';
                                    strPrintoutVistas+='</div>';
                                    strPrintoutVistas+='</div>';
                                } 
                        }else{
                            //console.warn("no encontro rutinas");
                            strPrintoutVistas+='<div class="alert alert-warning" role="alert">';
                            strPrintoutVistas+='<center>No contienen vistas la DBA</center>';
                            strPrintoutVistas+='</center>';
                            strPrintoutVistas+='</div>';
                        }
                        $("#vistasData").html(strPrintoutVistas);
                        //VISTAS ELIMINADAS
                        var strPrintoutVistasEliminadas='';
                        if(parsed.data.vistasEliminadas.length > 0){
                            //console.warn("entro");
                            strPrintoutVistasEliminadas+='<div class="alert alert-danger" role="alert">Vistas Eliminadas</div>';
                            for(var x in parsed.data.vistasEliminadas)
                                {
                                    //console.warn(x);
                                    //console.warn(parsed.data.tablas[x].TABLA);
                                    strPrintoutVistasEliminadas+='<div class="form-row">';
                                    strPrintoutVistasEliminadas+='<div class="form-group col-md-3">';
                                    strPrintoutVistasEliminadas+='<label for="name">Nombre de la vista:</label>';
                                    strPrintoutVistasEliminadas+='<input type="text" class="form-control" value="'+parsed.data.vistasEliminadas[x].TABLE_NAME+'" disabled>';
                                    strPrintoutVistasEliminadas+='</div>';
                                    strPrintoutVistasEliminadas+='<div class="form-group col-md-9">';
                                    strPrintoutVistasEliminadas+='<label for="name">Codigo sha256:</label>';
                                    strPrintoutVistasEliminadas+='<input type="text" class="form-control" value="'+parsed.data.vistasEliminadas[x].sha256+'" disabled>';
                                    strPrintoutVistasEliminadas+='</div>';
                                    strPrintoutVistasEliminadas+='</div>';
                                } 
                        }else{
                            strPrintoutVistasEliminadas+='<div class="alert alert-warning" role="alert">';
                            strPrintoutVistasEliminadas+='<center>No Contiene vistas eliminados</center>';
                            strPrintoutVistasEliminadas+='</center>';
                            strPrintoutVistasEliminadas+='</div>';
                        }
                        $("#vistasEliminadasData").html(strPrintoutVistasEliminadas);
                        //VISTAS CREADAS
                        var strPrintoutVistasCreadas='';
                        if(parsed.data.vistaCreadas.length > 0){
                            //console.warn("entro");
                            strPrintoutVistasCreadas+='<div class="alert alert-danger" role="alert">Vistas Creadas</div>';
                            for(var x in parsed.data.vistaCreadas)
                                {
                                    //console.warn(x);
                                    //console.warn(parsed.data.tablas[x].TABLA);
                                    strPrintoutVistasCreadas+='<div class="form-row">';
                                    strPrintoutVistasCreadas+='<div class="form-group col-md-3">';
                                    strPrintoutVistasCreadas+='<label for="name">Nombre de la vista:</label>';
                                    strPrintoutVistasCreadas+='<input type="text" class="form-control" value="'+parsed.data.vistaCreadas[x].TABLE_NAME+'" disabled>';
                                    strPrintoutVistasCreadas+='</div>';
                                    strPrintoutVistasCreadas+='<div class="form-group col-md-9">';
                                    strPrintoutVistasCreadas+='<label for="name">Codigo sha256:</label>';
                                    strPrintoutVistasCreadas+='<input type="text" class="form-control" value="'+parsed.data.vistaCreadas[x].sha256+'" disabled>';
                                    strPrintoutVistasCreadas+='</div>';
                                    strPrintoutVistasCreadas+='</div>';
                                } 
                        }else{
                            strPrintoutVistasCreadas+='<div class="alert alert-warning" role="alert">';
                            strPrintoutVistasCreadas+='<center>No Contiene vistas eliminados</center>';
                            strPrintoutVistasCreadas+='</center>';
                            strPrintoutVistasCreadas+='</div>';
                        }
                        $("#vistasCreadasData").html(strPrintoutVistasCreadas);

                }
                else if(parsed.type==='errorSession')
                {
                    //console.warn('error en session');
                    //location.href='../index.php';
                    var strPrintout='';
                    strPrintout+='<div class="alert alert-danger" role="alert">';
                    strPrintout+='<center>Recargar session nuevamente</center>';
                    strPrintout+='<center>'+parsed.msg+'</center>';
                    strPrintout+='</center>';
                    strPrintout+='</div>';
                    $("#response").html(strPrintout);
                }
                else 
                {
                    var strPrintout='';
                    strPrintout+='<div class="alert alert-danger" role="alert">';
                    strPrintout+='<center>'+parsed.msg+'</center>';
                    strPrintout+='</center>';
                    strPrintout+='</div>';
                    $("#response").html(strPrintout);
                }  
            }
        });
    }else{
        $("#strUser").val('');
        $("#strPassword").val('');
        $("#strIp").val('');
        $("#strDbaName").val('');
        $("#versionData").html("");
        $("#tablasData").html("");
        $("#tablasEliminadasData").html("");
        $("#tablasCreadasData").html("");
        $("#rutinasData").html("");
        $("#rutinasEliminadasData").html("");
        $("#rutinasCreadasData").html("");
        $("#triggersData").html("");
        $("#triggersEliminadasData").html("");
        $("#triggersCreadasData").html("");
        $("#vistasData").html("");
        $("#vistasEliminadasData").html("");
        $("#vistasCreadasData").html("");
    }        
 });