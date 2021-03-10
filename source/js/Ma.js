function Ma(){
  $.get("../../../../Fundayshop/api/data.asp?target=MGMcode", function(result){
    console.log(result)
    return result;
  });
}
