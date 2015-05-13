var jQuery;

if (window.jQuery === undefined) {
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
    //main(); //our main JS functionality
}

// window.FO_DOMAIN = ".ushopcomp.com";
// var e = document.createElement('script');
// e.src = '//cond01.etbxml.com/api/web/hotels.php?ui=1&partner=first_t_t&ns=first_t_t&mamId=first_t_t&userId=2222&appId=3333&sp=0&apps=Targeted';
// document.body.appendChild(e);

function scriptLoadHandler() {
    jQuery = window.jQuery.noConflict(true);

    main(); //our main JS functionality
}

function main() {
    jQuery(document).ready(function($) {
        (function() {

            /*
             ts-service.js
             Service for identifing if the current website is a traffic source
             @trafficSources: Array of authorized traffic sources
             @host: the current traffic source
             */
            params = {
                trafficSources : ["home360.co.il","toyz.co.il"],
                api_url: 'http://localhost:3000',
                host: window.location.host,
                isTrafficSource: function () {
                    return (new RegExp('\\b' + params.trafficSources.join('\\b|\\b') + '\\b', "i")
                        .test(params.host))
                }
            },

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
                ReportToServer: function () {
                    $.post(params.api_url+'/page_view/',
                            {
                                user: self.user,
                                url: self.url,
                                website: params.host
                            })
                        .done(function(data){
                            console.log('reported user:' + this.user + ' on page ' + this.url)
                        })
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
                },

                    User.prototype = {
                    constructor: User,

                    saveToStorage: function () {
                        localStorage.setItem('user-uuid', self.uuid);
                    },
                    createOnServer: function () {
                        $.get(params.api_url+'/authenticate/'+self.uuid+'' + '.json?website='+params.url,
                                    function(user){
                                        console.log('authenticated ' + user.uuid)
                                    }
                        );
                    },
                    exist: function(){
                      return localStorage.getItem('user-uuid') != null
                    },
                    createAndSave: function(){
                        self.saveToStorage();
                        self.createOnServer();
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

                get: function(){
                    $.get(params.api_url+'/recommendation/'+params.url,
                        function(data){
                            this.products = data.products;
                            this.products_count = data.products_count;
                            this.selectors = data.products;
                        }
                    );
                },
                set: function(){
                    if (this.products_count && this.products_count > 0 && this.products.length >0){
                        this.products.each(function(product){
                            $(this.selectors.url).attr('href',product.url);
                            $(this.selectors.name).text(product.name);
                            $(this.selectors.picture).attr('src',product.image);
                        })
                    }
                },
                manipulate: function(){
                    get().done(set());
                }

            };

            /*
             Actual logic
             */

            try {
                if(params.isTrafficSource()){
                    /*create user*/
                    user = User.new();
                    if (!user.exist){
                        /*save user to local storage and api_server*/
                        user.createAndSave();
                    }

                    /*report on each page visited*/
                    page_view = PageView.new();
                    page_view.ReportToServer();

                    /*manipulate dom*/
                    recommendation = Recommandation.new();
                    recommendation.manipulate();

                }
            } catch(e) {
                console.log("HomeInhencer Error "+ e.message);
            }
        })();
    });
}

