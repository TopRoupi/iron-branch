import { Controller } from "stimulus"

var cookie = require("../packs/cookies");

export default class extends Controller {
  static targets = [ "darkswitch" ];

  switch(event){
    var DarkReader = require('darkreader');

    if (event.currentTarget.checked == true){
      cookie.setCookie("darkmode", 'true', 365);

      DarkReader.setFetchMethod(window.fetch)

      DarkReader.enable({
        brightness: 100,
        contrast: 95
      });
    }
    else{
      DarkReader.disable();

      cookie.setCookie("darkmode", '', 365);
    }
  }

  connect() {
    var darkmode = cookie.getCookie("darkmode");

    if (darkmode != "")
      this.darkswitchTarget.checked = true;
    else
      this.darkswitchTarget.checked = false;
  }
}