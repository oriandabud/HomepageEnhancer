// Get script from external source
// prod_url = https://blooming-cliffs-1855.herokuapp.com
// dev_url = http://localhost:3000
(function() {
	var url = 'http://localhost:3000';
	$('head').prepend("<script type='text/javascript' src='"+url+"/main.js'>");
})();
