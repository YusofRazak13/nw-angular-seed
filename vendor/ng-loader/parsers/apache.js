parsers = typeof(parsers) == "undefined" ? {} : parsers;
parsers.DO = function(reqs, comp, html){
  var $body = $(html).find('table tr:nth-of-type(n+4):not(:last-of-type)');
  var $list = $body.find('td:eq(1)').map(function(index){
    return reqs[comp.url + '/' + $('a', this).attr('href')] = 
      comp.url + '/' + $('a', this).attr('href');
  }).toArray();
  return $list;
};