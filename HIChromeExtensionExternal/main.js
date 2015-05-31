// Get script from external source
// prod_url = https://blooming-cliffs-1855.herokuapp.com
// dev_url = http://localhost:3000
(function() {
	var url = 'https://homepage-enhancer.herokuapp.com';
	$('head').prepend("<script type='text/javascript' src='"+url+"/main.js'>");
})();


// for develop
//(function() {
//    var url = 'http://localhost:3000';
//    $('head').prepend("<script type='text/javascript' src='"+url+"/main.js'>");
//})();