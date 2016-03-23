/**
 * 加载异步js
 * common.load({""})
 */
;(function (exprots, undefined) {

  function Load () {
    this.init.apply(this, arguments);
  }

  Load.prototype = {

      // 版本号，为了清除缓存使用
      version: ((new Date()).getTime()).toString().substr(-4), // 0.0.1

      init: function (options) {
        this.loadFiles(this.filesToLoad(), function () {});
      },

      hostPath: function () {
        var path = document.querySelector('[data-tag="jsPath"]').src;
        var reg = /(.*)(\/js\/).*/;
        var part = path.match(reg);
        return part[1]+'/';
      },

      loadJS: function(file, callback) {
        var script = document.createElement("script");
        script.type = "text/javascript";
        if (script.readyState) {
          script.onreadystatechange = function() {
            if (script.readyState == "loaded" || script.readyState == "complete") {
              script.onreadystatechange = null;
              callback();
            }
          };
        } else {
          script.onload = function() {
            callback();
          };
        }
        if(((typeof file).toLowerCase()) === "object" && file["data-main"] !== undefined) {
          script.setAttribute("data-main", this.host()+file["data-main"]+'?'+this.version);
          script.async = true;
          script.src = this.host()+file.src+'?'+this.version;
        } else {
          script.src = this.host()+file+'?'+this.version;
        }
        document.getElementsByTagName("head")[0].appendChild(script);
      },

      loadFiles: function(obj, callback) {
        var self = this;
        self.loadCSS(obj["dev-css"], function() {
            if(obj["dev-js"])
              self.loadJS(obj["dev-js"], callback);
        });
      },

      // 获取文件相对路径
      filesToLoad: function () {
        return {
          'dev-css': this.files.css.main,
          "dev-js": this.files.main,
          "dev-init": this.host()+this.filesPath()
        }
      },

      files: {
        main: {
          'data-main': "js/main/config/config.js",
          src: "js/lib/require/2.1.22/require.js"
        }
      }

  }

  exprots.lop.load = new Load;

})(window, undefined);