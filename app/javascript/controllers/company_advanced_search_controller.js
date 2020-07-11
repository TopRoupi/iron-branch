var cookie = require("../packs/cookies");

$(document).ready(function(e){
  if(cookie.getCookie("ad-opt") == 'true')
    $("#ad-opt").addClass('show')
  else
    $("#ad-opt").addClass('hide')

  $("#ad-btn").on("click", function(){
    if(cookie.getCookie("ad-opt") == 'true')
      cookie.setCookie("ad-opt", 'false', 365);
    else
      cookie.setCookie("ad-opt", 'true', 365);
  }); 
});
