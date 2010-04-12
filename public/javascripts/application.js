// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
  var process = function(result){
    if(result[0] != "complete"){
      $("#process").append($('<h2>' + result[0] + '</h2><p>' + result[1] + '</p>'));
      var url = document.baseURI;
      if(url[url.length-1] == "/")
        url = url.slice(0,url.length-1);
      if(result[0] != "notlogin")
        $.getJSON(url + "/process", process);
    } else {
      location.reload();
    };
  };
  $("#process").each(function(){
    process(["start", ""]);
  });
});