// Generated by CoffeeScript 1.3.3
(function() {

  require.config({
    paths: {
      jQuery: 'libs/jquery-1.7.1',
      Underscore: 'libs/underscore-min',
      Backbone: 'libs/backbone-min'
    },
    shim: {
      Backbone: {
        deps: ['jQuery', 'Underscore'],
        exports: 'Backbone'
      },
      Underscore: {
        exports: '_'
      },
      jQuery: {
        exports: 'jQuery'
      }
    }
  });

  require(['views/AppView'], function(AppView) {
    return new AppView;
  });

}).call(this);
