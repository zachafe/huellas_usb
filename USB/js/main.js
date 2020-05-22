/**
* Este metodo es  logout del sistema
* @author:Andres Felipe Quintero 2020-05-17
* @version:1.0
* @return:destruye variables de session
*/
function logout()
{
    var parameters = {'object':'user','method':'logout','parameters':'0'};
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
                    location.href='../';
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
/**
* Este metodo es  logout del sistema
* @author:Andres Felipe Quintero 2020-05-17
* @version:1.0
* @return:Menu del sistema  validar permisos
*/
function menuPermission(objeto,method)
{
    //menu,listWay
    var parameters = {'object':objeto,'method':method,'parameters':'0'};
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
                //console.warn(parsed.type);
                if (parsed.type==='success'){
                    switch (method)
                    {
                        case 'registerDba':
                                location.href='createDbaView.php';
                            break;
                        case 'listDba':
                                location.href='listDbaView.php';
                        break;    
                        case 'createFootprint':
                                location.href='createFootprintView.php';
                        break; 
                        case 'listFootPrint':
                                location.href='listFootprintView.php';
                        break; 
                        default:
                            // statements_def
                            break;
                    }
                    
                }else if(parsed.type==='errorSession'){
                    location.href='../index.php';
                }else{
                    var strPrintout='';
                    strPrintout+='<div class="alert alert-danger" role="alert">';
                    strPrintout+='<center>No tiene permisos para ingresar</center>';
                    strPrintout+='</center>';
                    strPrintout+='</div>';
                    $("#response").html(strPrintout);
                }
            }
    });
} 
/**
* @method ESTE METODO EVALUA UN EXPRESION REGULAR SOBRE UN CAMPO
* @author:Andres Felipe Quintero 2020-05-18
* @param Obj $campo srint nombre del campo
* @param Obj $regexp string expresion regular
* @param Obj $flagObligatorio int bandera si es obligatorio o no
* @param Obj $mess string de mensaje
* @method validarCampoInput
* @return true o false
* @version:1.0
* @return:confirmacion de ingreso
*/
function validarCampoInput(campo,regexp,flagObligatorio,mess)
{   
    //CAPTURAR VALOR DEL CAMPO
    var valor=campo.value;
    //CAPTURAR EL JQUERY PARA QUE HAGA LA BUSQUEDAD POR ID PARA NO USAR $("#identificacion")
    var JqueryCampo=$(campo);
    //PROCESAR LA EXPRESION REGULAR
    var regexpAux = new RegExp(regexp,'i');
    //VALIDAR SI CAMPO ES OBLIGATORIO O NO
    if(flagObligatorio==1 || (valor!=null && valor.length !=0))
    {
        //VALIDAR QUE EL CAMPO NO VENGA VACIDO
        if( valor == null || valor.length == 0 || /^\s+$/.test(valor) )
        {   
            var strPrintout='';
            strPrintout+='<div class="alert alert-danger" role="alert">';
            strPrintout+='<center>El campo esta vacido</center>';
            strPrintout+='</center>';
            strPrintout+='</div>';
            $("#response").html(strPrintout);
            JqueryCampo.focus();
            return false;
        }
        //VALIDAR QUE CUMPLA CON LA EXPRESION REGULAR
        else if(regexpAux.test(valor))
        {
            $("#response").html('');
            return true;
        }
        else
        {
            var strPrintout='';
            strPrintout+='<div class="alert alert-danger" role="alert">';
            strPrintout+='<center>El campo debe cumplir con '+mess+'</center>';
            strPrintout+='</center>';
            strPrintout+='</div>';
            $("#response").html(strPrintout);
            JqueryCampo.focus();
            return false;   
        }
    }
    //SI NO ES OBLIGATORIO SE ENVIA AL GO
    else
    {
        return true;
    }
}
/**
* @method ESTE METODO ES PARA EVALUAR UN CAMPO SELECT
* @author:Andres Felipe Quintero 2020-05-18
* @param Obj $campo srint nombre del campo
* @param Obj $flagObligatorio int bandera si es obligatorio o no
* @param Obj $mess string de mensaje
* @method validarCampoInput
* @return true o false
* @version:1.0
* @return:confirmacion de ingreso
*/
//VALIDAR CAMPOS SELECTS
function validarCampoSelect(campo,flagObligatorio,mess)
{   
    //CAPTURAR VALOR DEL CAMPO
    var valor=campo.value;
    //CAPTURAR EL JQUERY PARA QUE HAGA LA BUSQUEDAD POR ID PARA NO USAR $("#identificacion")
    var JqueryCampo=$(campo);
    //VALIDAR SI CAMPO ES OBLIGATORIO O NO
    if(flagObligatorio==1 || (valor!=null && valor.length !=0))
    {
        if( valor == 0 )
        {   
            var strPrintout='';
            strPrintout+='<div class="alert alert-danger" role="alert">';
            strPrintout+='<center>Debe seleccionar una Opcion '+mess+'</center>';
            strPrintout+='</center>';
            strPrintout+='</div>';
            $("#response").html(strPrintout);
            JqueryCampo.focus();
            return false;
        }
        else 
        {
            $("#response").html('');
            return true;
        }
    }
    else
    {
        return true;
    }    
}