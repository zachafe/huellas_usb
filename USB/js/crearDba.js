$(function()
{
	//console.warn(method);
	//console.warn(id);
	switch (method)
	{
		case 'createDba':
			$('#buttonCreateDba').show();
			$('#buttonCleanFields').show();
			$('#buttonEdit').hide();
			break;
		case 'editDba':
			$('#buttonCreateDba').hide();
			$('#buttonCleanFields').hide();
			$('#buttonEdit').show();
			var arrData = new Object();
			arrData.ID_DBA=id;
			var parameters = {'object':'dbaUser','method':'viewDba','parameters':arrData};
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
		                //console.warn(parsed);
		                if (parsed.type==='success'){   
		                	//console.warn(parsed.data['0']['nombres']);
		                	$("#strIp").prop( "disabled", false );
		                	$("#strIp").val(parsed.data['0']['IP']);
		                	$("#strDbaName").prop( "disabled", false );
		                	$("#strDbaName").val(parsed.data['0']['NAME']);
		                	$("#strUser").prop( "disabled", false );
		                	$("#strUser").val(parsed.data['0']['USER']);
		                	$("#strPassword").prop( "disabled", false );
		                	$("#strPassword").val(parsed.data['0']['PASSWORD']);
		                	$("#typeDba").prop( "disabled", false );
		                	$("#typeDba").val(parsed.data['0']['TYPE']);
		                	$("#observation").prop( "disabled", false );
		                	$("#observation").val(parsed.data['0']['OBSERVATION']);
		                }else{
		                    var strPrintout='';
		                    strPrintout+='<div class="alert alert-danger" role="alert">';
		                    strPrintout+='<center>'+parsed.msg+'</center>';
		                    strPrintout+='</center>';
		                    strPrintout+='</div>';
		                    $("#response").html(strPrintout);
		                }  
		            }
		    })
			break;
		case 'viewDba':
			$('#buttonCreateDba').hide();
			$('#buttonCleanFields').hide();
			$('#buttonEdit').hide();
			var arrData = new Object();
			arrData.ID_DBA=id;
			var parameters = {'object':'dbaUser','method':'viewDba','parameters':arrData};
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
		                //console.warn(parsed);
		                if (parsed.type==='success'){   
		                	//console.warn(parsed.data['0']['nombres']);
		                	$("#strIp").prop( "disabled", true );
		                	$("#strIp").val(parsed.data['0']['IP']);
		                	$("#strDbaName").prop( "disabled", true );
		                	$("#strDbaName").val(parsed.data['0']['NAME']);
		                	$("#strUser").prop( "disabled", true );
		                	$("#strUser").val(parsed.data['0']['USER']);
		                	$("#strPassword").prop( "disabled", true );
		                	$("#strPassword").val(parsed.data['0']['PASSWORD']);
		                	$("#typeDba").prop( "disabled", true );
		                	$("#typeDba").val(parsed.data['0']['TYPE']);
		                	$("#observation").prop( "disabled", true );
		                	$("#observation").val(parsed.data['0']['OBSERVATION']);
		                }else{
		                    var strPrintout='';
		                    strPrintout+='<div class="alert alert-danger" role="alert">';
		                    strPrintout+='<center>'+parsed.msg+'</center>';
		                    strPrintout+='</center>';
		                    strPrintout+='</div>';
		                    $("#response").html(strPrintout);
		                }  
		            }
		    })
			break;		
	}
});	
/**
* @method Este metodo para crear DBA
* @author:Andres Felipe Quintero 2020-05-22
* @return JSON con informacion si se creo o no
* @version:1.0
*/
$("#buttonCreateDba").click(function(){
	//console.warn('button');
    if(!(validarCampoInput(strIp,'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',1,' Ip invalida')== false || validarCampoInput(strDbaName,'^.{1,32}$',1,'Alfanumerico')== false || validarCampoInput(strUser,'^.{1,32}$',1,'Alfanumerico')== false || validarCampoInput(strPassword,'^.{1,32}$',1,'Alfanumerico')== false || validarCampoSelect(typeDba,1,'Tipo DBA')== false)){

        //console.warn("entro");
		//ARMAR OBJETO
		var arrData = new Object();
		arrData.NAME=strDbaName.value;
		arrData.IP =strIp.value;
		arrData.USER =strUser.value;
		arrData.PASSWORD  =strPassword.value;
		arrData.TYPE =typeDba.value;
		arrData.OBSERVATION =observation.value;
		//console.warn(arrData);	
        if (confirm('¿Estas seguro que desea crear la DBA'))
        { 
			var parameters = {'object':'dbaUser','method':'createDba','parameters':arrData};
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
		                //console.warn(parsed);
		                if (parsed.type==='success')
		                {   
		                    var strPrintout='';
		                    strPrintout+='<div class="alert alert-success" role="alert">';
		                    strPrintout+='<center>'+parsed.msg+'</center>';
		                    strPrintout+='</center>';
		                    strPrintout+='</div>';
		                    $("#response").html(strPrintout); 
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
		    })
		}    
	}	
});
/**
* @method Este metodo para crear DBA
* @author:Andres Felipe Quintero 2020-05-22
* @return JSON con informacion si se creo o no
* @version:1.0
*/
$("#buttonEdit").click(function(){
	//console.warn('button');
    if(!(validarCampoInput(strIp,'^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$',1,' Ip invalida')== false || validarCampoInput(strDbaName,'^.{1,32}$',1,'Alfanumerico')== false || validarCampoInput(strUser,'^.{1,32}$',1,'Alfanumerico')== false || validarCampoInput(strPassword,'^.{1,32}$',1,'Alfanumerico')== false || validarCampoSelect(typeDba,1,'Tipo DBA')== false)){

        //console.warn("entro");
		//ARMAR OBJETO
		var arrData = new Object();
		arrData.ID_DBA=id;
		arrData.NAME=strDbaName.value;
		arrData.IP =strIp.value;
		arrData.USER =strUser.value;
		arrData.PASSWORD  =strPassword.value;
		arrData.TYPE =typeDba.value;
		arrData.OBSERVATION =observation.value;
		//console.warn(arrData);	
        if (confirm('¿Estas seguro que desea modificar la DBA'))
        { 
			var parameters = {'object':'dbaUser','method':'editDbaSet','parameters':arrData};
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
		                //console.warn(parsed);
		                if (parsed.type==='success')
		                {   
		                    var strPrintout='';
		                    strPrintout+='<div class="alert alert-success" role="alert">';
		                    strPrintout+='<center>'+parsed.msg+'</center>';
		                    strPrintout+='</center>';
		                    strPrintout+='</div>';
		                    $("#response").html(strPrintout); 
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
		    })
		}    
	}	
});
/**
* @method Este metodo para limpiar los campos
* @author:Andres Felipe Quintero 2020-05-18
* @version:1.0
*/
$("#buttonCleanFields").click(function(){	
//console.warn('limpiar campos');
	$("#strIp").val('');
	$("#strDbaName").val('');
	$("#typeDba").val('0');
	$("#strUser").val('');
	$("#strPassword").val('');
	$("#observation").val('');
	$("#response").html("");
});	