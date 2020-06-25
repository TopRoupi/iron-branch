var cookie = require("../packs/cookies");

$(document).ready(function(e){
  $('.search-panel .dropdown-menu').find('a').click(function(e) {
    e.preventDefault();
    var param = $(this).attr("href").replace("#","");
    var concept = $(this).text();
    $('.search-panel span#search_concept').text(concept);
    $('.input-group #capital_param').val(param);
  });

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

  var params = new window.URLSearchParams(window.location.search);

  $('#constitution').val(params.get('constitution'));

  $('#status').val(params.get('status'));

  if(params.get('capital_param') == '>'){
    $('#greather').click();
  }
  if(params.get('capital_param') == '<'){
    $('#less').click();
  }
  if(params.get('capital_param') == '='){
    $('#equals').click();
  }
});
