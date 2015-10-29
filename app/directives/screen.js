function Screen($rootScope, $location){

  var bindMouseEvents = function(elem){
    // mouse events
    return elem;
  };
  var bindKeyEvents = function(elem){
    var modifierKey = "", actualKey = "", func = null;

    elem.on('keydown', function(e){
      modifierKey = "";

      if (e.ctrlKey) modifierKey = "CTRL+"
      if (e.shiftKey) modifierKey = "SHIFT+"
      if (e.altKey) modifierKey = "ALT+"
      if (e.metaKey) modifierKey = "META+"

      actualKey = String.fromCharCode(e.keyCode);
      func = $root.keyEvents[modifierKey+actualKey];
      if(!func){
        func = $root.keyEvents[modifierKey+e.keyCode];
      }
      if(!func){
        // console.log(modifierKey, e.keyCode)
      }

      if(func) func(e);

      if( $root.keyEvents['*'] ){
        $root.keyEvents['*'].call();
      }
    });
    // key events
    return elem;
  };
  return {
    link: function($scope, $elem, $attrs){
      scope = $scope;
      bindMouseEvents($elem);
      bindKeyEvents($elem);
    }
  };
}