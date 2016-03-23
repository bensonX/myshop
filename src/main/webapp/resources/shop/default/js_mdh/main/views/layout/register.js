;define(['jquery', 'backbone'], function ($, backbone) {

  var Views = backbone.View.extend({
    el: 'body',

    events: function () {

    },

    initialize: function() {
      this.render();
      return this;
    },

    render: function () {
      
    }
  });

  return Views;
})