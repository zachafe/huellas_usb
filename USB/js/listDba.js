$(document).ready(function(){
    loadPage(1);
});

function loadPage(page){
var parameters = {'object':'dbaUser','method':'listDba','parameters':'0'};
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
                var strPrintout="";
                //ARMAR STRING
                for(var x in parsed.data)
                {
                    strPrintout+='<tr>';
                    strPrintout+='<td>'+parsed.data[x]['NAME']+'</td>';
                    strPrintout+='<td>'+parsed.data[x]['IP']+'</td>';
                    strPrintout+='<td>'+parsed.data[x]['USER']+'</td>';
                    strPrintout+='<td>'+parsed.data[x]['TYPE']+'</td>';
                    strPrintout+='<td>'+parsed.data[x]['CREATION_DATE']+'</td>';
                    strPrintout+='<td>'+parsed.data[x]['LOGIN']+'</td>';
                    strPrintout+='<td>'+parsed.data[x]['OBSERVATION']+'</td>';
                    strPrintout+='<td><span type="button" onclick="loadMethod('+parsed.data[x]['ID_DBA']+',\'viewDba\');" class="badge badge-primary">Ver</span> <span type="button" onclick="loadMethod('+parsed.data[x]['ID_DBA']+',\'editDba\');" class="badge badge-secondary">Editar</span></td>';
                    strPrintout+='</tr>';	
                    //parsed.data[x]['id_pacientes']
                }	
                $("#dataTable").html(strPrintout);
                $('#myTable').DataTable();
            }else if(parsed.type==='errorSession'){
                //console.warn('error en session');
                location.href='../index.php';
            }else {
                var strPrintout='';
                strPrintout+='<div class="alert alert-warning" role="alert">';
                strPrintout+='<center>'+parsed.msg+'</center>';
                strPrintout+='</center>';
                strPrintout+='</div>';
                $("#response").html(strPrintout);
            }
        }
})
}

function loadMethod(intId,method)
{
//console.warn('id'+intId);
//console.warn('method'+method);
//var arrData = new Object();
//arrData.idCustomer=intId;
var parameters = {'object':'dbaUser','method':method,'parameters':'default'};
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
            switch (method)
            {
                case 'viewDba':
                    location.href='createDbaView.php?method=viewDba&id='+intId;
                break;
                case 'editDba':
                    location.href='createDbaView.php?method=editDba&id='+intId;
                break;   
            }
        }else if(parsed.type==='errorSession'){
            //console.warn('error en session');
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
})
}
