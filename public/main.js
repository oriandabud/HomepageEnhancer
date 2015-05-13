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
         Orbitz.js
         Class for data scraping of Orbitz
         @trafficSources: Array of authorized traffic sources
         @host: the current traffic source
         */

        function PageView() {
        }

            PageView.prototype = {
            constructor: PageView,

            getRating: function(){
                // For single hotel page
            },

            getHotelName: function(){

            },

            getDestination: function() {

            },

            getDates: function () {
                var dates = {};
                dates.checkin = jQuery("input[name='hotel.chkin']").val();
                dates.checkout = jQuery("input[name='hotel.chkout']").val();
                return dates;
            },

            getPrice: function () {
                var price = {};
                price.currency = this.getCurrency();

                try {
                    var pricesArr = jQuery(".leadPrice"); // get the divs containing the price
                    var sum = 0;
                    var minimalPrice = 10000000; // Instead of using this giant price I could took the first price from the list
                    $.each(pricesArr,function () {
                        var pString = $(this).html();
                        var price = parseInt(pString.replace(/[^0-9\.]+/g,"")); // remove non number chars from price string

                        sum +=  price;
                        if (minimalPrice > price)
                        {
                            minimalPrice = price;
                        }

                    });

                    price.minimal = minimalPrice;

                    price.average = parseInt(sum / pricesArr.length);
                } catch(e) {
                    console.log("BestDeal error" + e.message);
                    price.average = null;
                }

                return price;
            },

            getCurrency: function () {
                return jQuery(".leadPrice").first().text().trim().substring(0,1);
            }
        };

			try {
 				if(tsSrvc.isTrafficSource(window.location.host)){
					var data = {};
					data.ts = window.location.host;
					var tsClass = tsSrvc.trafficSourceClass();

					data.destination = tsClass.getDestination();

                    if(data.destination != undefined && data.destination != "")
                    {
                        data.dates = tsClass.getDates();
                        data.price = tsClass.getPrice();
                        data.hotelName =tsClass.getHotelName();
                        data.stars = tsClass.getRating();
                        var viewSrvc = new viewSrvc(null,data);
                        var api = new API(viewSrvc);
                        api.getOffers(data.destination);

                        if(tsSrvc.isTrafficSourcesUseAjax(window.location.host)){

                            // This method is working perfectly for priceLine and for Hotels
                            jQuery( document ).ajaxComplete(function( event,request, settings ) {

                                data.dates = tsClass.getDates();
                                data.price = tsClass.getPrice();
                                data.hotelName =tsClass.getHotelName();
                                api.getOffers(data.destination);
                            });
                        }
                        else if (window.location.host == "www.orbitz.com")
                        {

                            // This is not the best way but at least for now it's not pulling
                            $('form').click(function(e) {
                                setTimeout(function(){
                                    data.dates = tsClass.getDates();
                                    data.price = tsClass.getPrice();
                                    data.hotelName =tsClass.getHotelName();
                                    api.getOffers(data.destination);
                                },4000);
                            });

                        }
                        else if(window.location.host == "www.tripadvisor.com")
                        {

                            (function() {
                                var classes = [Request, Request.HTML, Request.JSON],
                                    // map to a text name
                                    mapper = ["Request", "Request.HTML", "Request.JSON"],
                                    // store reference to original methods
                                    orig = {
                                        onSuccess: Request.prototype.onSuccess
                                    },
                                    // changes to prototypes to implement
                                    changes = {
                                        onSuccess: function(){
                                            Request.Spy && typeof Request.Spy == "function" && Request.Spy.apply(this, arguments);
                                            orig.onSuccess.apply(this, arguments);
                                        }
                                    };

                                classes.invoke('implement', changes);

                                // allow us to tell which Class prototype has called the ajax
                                Request.implement({
                                    getClass: function() {
                                        var ret;
                                        Array.each(classes, function(klass, index) {
                                            if (instanceOf(this, klass)) {
                                                ret = mapper[index];
                                            }
                                        }, this);
                                        return ret;
                                    }
                                });
                            })();

                            // to enable spying, just define Request.Spy as a function:
                            Request.Spy = function() {
                                data.dates = tsClass.getDates();
                                data.price = tsClass.getPrice();
                                data.hotelName =tsClass.getHotelName();
                                api.getOffers(data.destination);
                            };
                        }
                    }

				}
			} catch(e) {
				console.log("BestDeal Error "+ e.message);
			}
		})();
	});
}





