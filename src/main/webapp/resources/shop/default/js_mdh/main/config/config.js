/**
 * 主要引入第三方插件加载
 *
 */
require.config({

  baseUrl: common.loading.hostPath()+'main/views',

  paths: {

    "jquery": "../../third/jquery.min",

    "backbone": "../../third/backbone",

    "touchSlider": "../../third/touchSlider"

  },

  shim: {
    "backbone": ['jquery'],

    "touchSlider": ['jquery']
  },

  urlArgs: common.loading.version

});

require([common.loading.viewsJsPath], function (views) {
  new views();
})