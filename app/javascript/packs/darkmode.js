var cookie = require("./cookies");

var darkmode = cookie.getCookie("darkmode");

var DarkReader = require('darkreader');

if (darkmode != "") {
  DarkReader.setFetchMethod(window.fetch)
  DarkReader.enable({
    brightness: 100,
    contrast: 95
  });
}