(function() {
    "use strict";

    WinJS.Namespace.define('PlatformNS', {
        platform: WinJS.Class.define(function (param) {
            //Constructor
            this.testParam = param;
            if (param) this.testInstance = param;
        }, {
            //Instance
            testInstance: "instance",
            setStatic: function (value) {
                this.constructor.testStatic = value;
                return value;
            }
        }, {
            getStatic: function () {
                return this.testStatic;
            },
            //Static
            testStatic: "staticVar",
        }
        )
    });
})();

