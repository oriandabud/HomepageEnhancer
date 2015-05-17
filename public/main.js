var jQuery;

if (window.jQuery === undefined) {
    console.log('HI ==1==');
    var script_tag = document.createElement('script');
    script_tag.setAttribute("type","text/javascript");
    script_tag.setAttribute("src","https://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js");
    if (script_tag.readyState) {
        script_tag.onreadystatechange = function () { // For old versions of IE
            if (this.readyState == 'complete' || this.readyState == 'loaded') {
                scriptLoadHandler();
            }
        };
    } else { // Other browsers
        script_tag.onload = scriptLoadHandler;
    }
    (document.getElementsByTagName("head")[0] || document.documentElement).appendChild(script_tag);
} else {
    jQuery = window.jQuery;
    console.log('HI ==2==');
    main(); //our main JS functionality
}

// window.FO_DOMAIN = ".ushopcomp.com";
// var e = document.createElement('script');
// e.src = '//cond01.etbxml.com/api/web/hotels.php?ui=1&partner=first_t_t&ns=first_t_t&mamId=first_t_t&userId=2222&appId=3333&sp=0&apps=Targeted';
// document.body.appendChild(e);

function scriptLoadHandler() {
    jQuery = window.jQuery.noConflict(true);
    console.log('HI ==3==');
    main(); //our main JS functionality
}

function main() {
    console.log('HI ==4==');
    jQuery(document).ready(function($) {
        (function() {
            console.log('HI ==5==');

            /*
             ts-service.js
             Service for identifing if the current website is a traffic source
             @trafficSources: Array of authorized traffic sources
             @host: the current traffic source
             */
            params = {
                trafficSources : ["www.home360.co.il","www.toyz.co.il"],
                api_url: 'http://localhost:3000',
                host: window.location.host,
                isTrafficSource: function () {
                    return (new RegExp('\\b' + params.trafficSources.join('\\b|\\b') + '\\b', "i")
                        .test(params.host))
                }
            };

            /*
             PageView.js
             Class for data PageView
             Report server about user entrance specific product
             */

            function PageView() {
                this.url = window.location.href,
                this.user = localStorage.getItem("user-uuid")
            }

                PageView.prototype = {
                constructor:  PageView,
                page_view: this,

                ReportToServer: function () {
                    $.ajax({
                        type: "POST",
                        url: params.api_url+'/page_view/',
                        data: {
                                user: page_view.user,
                                url: page_view.url,
                                website: params.host
                              },
                        success: function(data) {
                            console.log('reported user:' + page_view.user + ' on page ' + page_view.url)
                        }
                    });
                }
            };

            /*
             User.js
             Integrate with authentication on api
             distinguish between users
             send report to server about user
             */

            function User() {
                self.uuid = User.guid()
            }

                User.guid = function (){
                    function s4() {
                        return Math.floor((1 + Math.random()) * 0x10000)
                            .toString(16)
                            .substring(1);
                    }
                    return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
                        s4() + '-' + s4() + s4() + s4();
                };

                User.prototype = {
                    constructor: User,
                    user : this,

                    saveToStorage: function () {
                        localStorage.setItem('user-uuid', user.uuid);
                    },
                    createOnServer: function () {
                        $.get(params.api_url+'/authenticate/'+user.uuid+'' + '.json?website='+params.url,
                                    function(userSR){
                                        console.log('authenticated ' + userSR.uuid)
                                    }
                        );
                    },
                    exist: function(){
                      return localStorage.getItem('user-uuid') != null
                    },
                    createAndSave: function(){
                        user.saveToStorage();
                        user.createOnServer();
                    }
                };

            /*
             Recommandation.js
             Class for data Recommandation
             gets data about manipulating the dom
             manipulate the dom
             */

            function Recommandation() {
                this.url = window.location.host,
                this.products = {},
                this.products_count = 0,
                this.selectors = {}
            }

                Recommandation.prototype = {
                constructor: Recommandation,
                recommendation: this,

                get: function(){
                    $.get(params.api_url+'/recommendation/'+params.url,
                        function(data){
                            recommendation.products = data.products;
                            recommendation.products_count = data.products_count;
                            recommendation.selectors = data.products;
                        }
                    );
                },
                set: function(){
                    if (this.products_count && this.products_count > 0 && this.products.length >0){
                        this.products.each(function(product){
                            $(recommendation.selectors.url).attr('href',product.url);
                            $(recommendation.selectors.name).text(product.name);
                            $(recommendation.selectors.picture).attr('src',product.image);
                        })
                    }
                },
                manipulate: function(){
                    recommendation.get().done(set());
                }

            };

            /*
             Actual logic
             */
            console.log('HI ==5==');
            try {
                console.log('starting HI');
                if(params.isTrafficSource()){
                    console.log('HI inside first if');
                    /*create user*/
                    user = new User;
                    if (!user.exist){
                        console.log('creating user HI');
                        /*save user to local storage and api_server*/
                        user.createAndSave();
                    }

                    /*report on each page visited*/
                    console.log('visiting page HI');
                    page_view = new PageView;
                    page_view.ReportToServer();

                    /*manipulate dom*/
                    console.log('manipulate dom HI');
                    recommendation = new Recommandation;
                    recommendation.manipulate();

                }
            } catch(e) {
                console.log("HomeInhencer Error "+ e.message);
            }
        })();
    });
}

