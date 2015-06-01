## HomepageEnhancer

Clone the project:

```
git clone https://github.com/oriandabud/HomepageEnhancer.git
```

#### To test the extension

1. Open you chrome browser
2. In the address line type: chrome://extensions/
3. Make sure the checkbox titled "Developer Mode" is checked
5. Click on "Load unpacked extension..."
6. Select the folder "HEChromeExtensionExternal" and click "Select"

Once you have done this you will be able to test the extension once you enter parameters to db


### To setup the dev environment

**Note**: these steps require you have Git and a working Rails environment setup.

1. cd into directory created when cloning the app
2. run the following command to setup and populate the database:

```rake db:setup```

3. start the server by running:

```rails s```


You will also need to change two lines in the code to develop locally:
1. In app/public/main.js:

```javascript
function API(viewSrvc) {
    // for develop
    //api_url: 'http://localhost:3000',
    api_url: 'https://homepage-enhancer.herokuapp.com',
}
```


Change the line api_url to equal the dev_url

2. In HEChromeExtensionExternal/main.js
```javascript
// prod_url = https://homepage-enhancer.herokuapp.com
// dev_url = http://localhost:3000
(function() {
	var url = 'https://homepage-enhancer.herokuapp.com'
	$('head').append("<script type='text/javascript' src='"+url+"/main.js'>");
	$('head').append("<link rel='stylesheet' type='text/css' href='"+url+"/main.css'>");
})();
```

Change the line var url to equal the dev_url

**Note**: After making changes to HEChromeExtensionExternal/main.js you will need to:

1. go to chrome://extensions/
2. find the extension "HomepageEnhancer-dev-with-external"
3. click "Reload"


### to run with ssl on develop

 thin start -p 3010 --ssl --ssl-key-file ~/.ssl/server.key --ssl-cert-file ~/.ssl/server.crt
 add config.force_ssl = true to develop.rb

