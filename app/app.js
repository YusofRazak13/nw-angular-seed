ngLoader({
  done: function(components){
    var myApp = angular.module("myApp", ['ngSanitize']);
    for(var compType in components){
      components[compType].forEach(function(comp){
        myApp[compType](comp.named, comp.func);
      });
    }
    angular.bootstrap(document, ['myApp']);
  }
});