parsers = typeof(parsers) == "undefined" ? {} : parsers;
parsers.RGX = /addRow\(\"[^\"]+\"\,\"([^\"]+)\"[^\)]+\)/g
parsers.DO = function(reqs, comp, html){
  var $list = [];
  html.replace(parsers.RGX, function(a, url){
    if( url !== ".." && url !== ".htaccess" ){
      $list.push(comp.url + '/' + url);
      reqs[comp.url + '/' + url] = comp.url + '/' + url; 
    }
  });
  return $list;
}