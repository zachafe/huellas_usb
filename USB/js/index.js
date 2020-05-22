/**
* Este metodo es para autorizar la entrada al sistema
* @author:Andres Felipe Quintero 2020-05-16
* @version:1.0
* @return:confirmacion de ingreso
*/
function authentication()
{
	var strLogin=login.value;
	var strPassword=password.value;
	if( /^[\w.]+$/.test(strLogin)  && strPassword.length != 0 )
    {
    	var arrData = new Object();
		arrData.login=strLogin;
		arrData.password=strPassword;
		var parameters = {'object':'user','method':'authentication','parameters':arrData};
	    $.ajax({
	            url:'controller/frontController.php',
	            type:'POST',
	            data:parameters,
	            beforeSend: function(objeto){
	            $("#response").html("<img src='images/loader.gif'>");
	            },
	            success:function(data)
	            {
	            	$("#response").html("");
					var parsed = JSON.parse(data);
	            	if (parsed.type==='success')
	            	{
						location.href='view/principalView.php';	
	            	}
	            	else 
	            	{
	            		var strPrintout='';
	            		strPrintout+='<div class="alert alert-danger" role="alert">';
						strPrintout+='<center>No se pudo autenticar</center>';
						strPrintout+='</center>';
						strPrintout+='</div>';
						$("#response").html(strPrintout);
	            	}	
	            }
	    })
	}
    else
    {
		var strPrintout='';
		strPrintout+='<div class="alert alert-danger" role="alert">';
		strPrintout+='<center>Error al autenticar</center>';
		strPrintout+='</center>';
		strPrintout+='</div>';
		$("#response").html(strPrintout);    		
    }	
}
/**
* @author:Andres Felipe Quintero 2020-05-16
* @version:1.0
*/
function enterLogin(e)
{   
	if (e.keyCode == 13) 
	{
		authentication();
	}
}
