(function() {
    "use strict";

    WinJS.Namespace.define("vonbismark", {
        oauthclient: WinJS.Class.define(function() {
            // Constructor
        }, {
            // Instance
        }, {
            // Static
            getTest: function(uri) {
                return WinJS.xhr({ url: uri }).then(function(response) {
                    return response.responseText;
                });
            }
        })
    });
})();