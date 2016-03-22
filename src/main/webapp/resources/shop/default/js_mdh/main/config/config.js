// Require.js Configurations
require.config({

  baseUrl: "/js/main/",

  paths: {

    "jquery": "../lib/jquery/1.12.0/jquery.min"

  },

  shim: {

  },

  urlArgs: lop.load.version

});

require([lop.load.filesToLoad()["dev-init"]], function (cc) {
  
})