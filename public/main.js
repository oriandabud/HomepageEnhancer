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
    main(); //our main JS functionality
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
                trafficSources : ["www.home360.co.il","www.toyz.co.il","www.baligam.co.il"],
                // for develop
                //api_url: 'http://localhost:3000',
                api_url: 'http://localhost:3000',
                host: window.location.host,
                host_name: window.location.host.split('.')[1],
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
                this.user = localStorage.getItem("user-uuid"+params.api_url)
            }

                PageView.prototype = {
                constructor:  PageView,
                page_view: this,

                ReportToServer: function () {

                    $.ajax({
                        type: "POST",
                        url: params.api_url+'/websites/'+ params.host_name +'/page_view/',
                        data: {
                                uuid: page_view.user,
                                url: page_view.url
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
                        localStorage.setItem('user-uuid'+params.api_url, User.guid());
                    },
                    createOnServer: function () {
                        $.get(params.api_url+'/websites/'+ params.host_name +'/authenticate/'+user.uuid+'' + '.json',
                                    function(userSR){
                                        console.log('authenticated ' + userSR.uuid)
                                    }
                        );
                    },
                    exist: function(){
                      return localStorage.getItem('user-uuid'+ params.api_url) != null
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
                this.num_of_products = 1,
                this.home_page = {}
            }

                Recommandation.prototype = {
                constructor: Recommandation,
                recommendation: this,

                get: function(callback){
                    $.ajax({
                        type: "GET",
                        url: params.api_url + '/websites/'+params.host_name+'/recommendation/',
                        data: {
                            uuid: localStorage.getItem('user-uuid' + params.api_url),
                            url: window.location.host
                        },
                        success: function(data){
                            data = data.website;
                            console.log('products:'+data.products +'\n' + 'num_of_products:'+data.num_of_products +'\n'+ 'selectors:'+data.home_page);
                            recommendation.products = data.products;
                            recommendation.num_of_products = data.num_of_products;
                            recommendation.home_page = data.home_page;
                            callback();
                        }
                    })
                },
                set: function(){
                    if(location.href.split('/')[location.href.split('/').length-1] == '' && recommendation.num_of_products !== undefined &&
                        recommendation.num_of_products > 0 && recommendation.products.length >0){
                        $(recommendation.products).each(function(index,product){
                            debugger
                            if(index < recommendation.num_of_products){
                                var container = $($(recommendation.home_page.product_container_selector)[index]);
                                var old_href = container.find(recommendation.home_page.product_url_selector).attr('href');
                                var re = new RegExp(old_href,"g");
                                    container.html(function(index,html){
                                        return html.replace(re, product.page_link);
                                    });
                                container.find(recommendation.home_page.product_name_selector).text(product.title);
                                var img =  container.find(recommendation.home_page.product_picture_selector);
                                if (recommendation.home_page.img_max_width !== null){
                                    img.attr('width',recommendation.home_page.img_max_width);
                                    img.attr('height',recommendation.home_page.img_max_height);
                                }
                                img.attr('src',product.picture_link);
                                var price = container.find(recommendation.home_page.product_price_selector);
                                price.text(price.text().replace(/[0-9/.]+/g, product.price));
                                if (recommendation.home_page.product_old_price_selector !== null){
                                    var old_price = container.find(recommendation.home_page.product_old_price_selector);
                                    old_price.text(old_price.text().replace(/[0-9/.]+/g, product.old_price));
                                }
                            }
                        })
                    }
                },
                manipulate: function(){
                    recommendation.get(recommendation.set);
                }
            };

            /*
             Actual logic
             */
            try {
                if(params.isTrafficSource()){
                    /*manipulate dom*/
                    console.log('manipulate dom HE');
                    recommendation = new Recommandation;
                    recommendation.manipulate();

                    /*create user*/
                    user = new User;
                    if (!user.exist()){
                        console.log('creating user HE');
                        /*save user to local storage and api_server*/
                        user.createAndSave();
                    }
                    /*report on each page visited*/
                    console.log('visiting page HE');
                    page_view = new PageView;
                    page_view.ReportToServer();

                }
            } catch(e) {
                console.log("HomeEnhancer Error "+ e.message);
            }
        })();
    });
}

