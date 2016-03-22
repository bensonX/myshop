/**
 *  init.js
 *  0.0.1
 */

;(function (exprots, undefined) {
  var Lop = {};

  Lop.browser = {
      uaredirect: function (f) {
        try {
          if (document.getElementById("bdmark") != null) {
            return;
          }
          var b = false;
          if (arguments[1]) {
            var e = window.location.host;
            var a = window.location.href;
            if (isSubdomain(arguments[1], e) == 1) {
              f = f + "/#m/" + a;
              b = true
            } else {
              if (isSubdomain(arguments[1], e) == 2) {
                f = f + "/#m/" + a;
                b = true
              } else {
                f = a;
                b = false
              }
            }
          } else {
            b = true
          }
          if (b) {
            var c = window.location.hash;
            if (!c.match("fromapp")) {
              //if ((navigator.userAgent.match(/(iPhone|iPod|Android|ios|SymbianOS)/i))) {
              if ((navigator.userAgent.match(/(phone|pad|pod|iPhone|iPod|ios|iPad|Android|Mobile|BlackBerry|IEMobile|MQQBrowser|JUC|Fennec|wOSBrowser|BrowserNG|WebOS|Symbian|Windows Phone)/i))) {
               //location.replace(f)
               return true;
              }
            }
          }
        } catch(d) {}
      },

      isSubdomain: function (c, d) {
        this.getdomain = function(f) {
          var e = f.indexOf("://");
          if (e > 0) {
           var h = f.substr(e + 3)
          } else {
           var h = f
          }
          var g = /^www\./;
          if (g.test(h)) {
            h = h.substr(4)
          }
            return h
          };
          if (c == d) {
            return 1
          } else {
            var c = this.getdomain(c);
            var b = this.getdomain(d);
          if (c == b) {
            return 1
          } else {
            c = c.replace(".", "\\.");
            var a = new RegExp("\\." + c + "$");
            if (b.match(a)) {
              return 2
            } else {
              return 0
            }
          }
        }
      },

  }
  

  exprots.lop = Lop;

})(window, undefined);

;(function(win, lib) {
    // 判断是移动端还是pc端
    if (!lop.browser.uaredirect()) return;

    var doc = win.document;
    var docEl = doc.documentElement;
    var metaEl = doc.querySelector('meta[name="viewport"]');
    var flexibleEl = doc.querySelector('meta[name="flexible"]');
    var dpr = 0;
    var scale = 0;
    var tid;
    var flexible = lib.flexible || (lib.flexible = {});

    if (!win.addEventListener) win.addEventListener = win.attachEvent;
    
    if (metaEl) {
        console.warn('将根据已有的meta标签来设置缩放比例');
        var match = metaEl.getAttribute('content').match(/initial\-scale=([\d\.]+)/);
        if (match) {
            scale = parseFloat(match[1]);
            dpr = parseInt(1 / scale);
        }
    } else if (flexibleEl) {
        var content = flexibleEl.getAttribute('content');
        if (content) {
            var initialDpr = content.match(/initial\-dpr=([\d\.]+)/);
            var maximumDpr = content.match(/maximum\-dpr=([\d\.]+)/);
            if (initialDpr) {
                dpr = parseFloat(initialDpr[1]);
                scale = parseFloat((1 / dpr).toFixed(2));    
            }
            if (maximumDpr) {
                dpr = parseFloat(maximumDpr[1]);
                scale = parseFloat((1 / dpr).toFixed(2));    
            }
        }
    }

    if (!dpr && !scale) {
        var isAndroid = win.navigator.appVersion.match(/android/gi);
        var isIPhone = win.navigator.appVersion.match(/iphone/gi);
        var devicePixelRatio = win.devicePixelRatio;
        if (isIPhone) {
            // iOS下，对于2和3的屏，用2倍的方案，其余的用1倍方案
            if (devicePixelRatio >= 3 && (!dpr || dpr >= 3)) {                
                dpr = 3;
            } else if (devicePixelRatio >= 2 && (!dpr || dpr >= 2)){
                dpr = 2;
            } else {
                dpr = 1;
            }
        } else {
            // 其他设备下，仍旧使用1倍的方案
            dpr = 1;
        }
        scale = 1 / dpr;
    }

    docEl.setAttribute('data-dpr', dpr);
    if (!metaEl) {
        metaEl = doc.createElement('meta');
        metaEl.setAttribute('name', 'viewport');
        metaEl.setAttribute('content', 'initial-scale=' + scale + ', maximum-scale=' + scale + ', minimum-scale=' + scale + ', user-scalable=no');
        if (docEl.firstElementChild) {
            docEl.firstElementChild.appendChild(metaEl);
        } else {
            var wrap = doc.createElement('div');
            wrap.appendChild(metaEl);
            doc.write(wrap.innerHTML);
        }
    }

    function refreshRem(){
        var width = docEl.getBoundingClientRect().width;
        if (width / dpr > 540) {
            width = 540 * dpr;
        }
        var rem = width / 10;
        docEl.style.fontSize = rem + 'px';
        flexible.rem = win.rem = rem;
    }

    win.addEventListener('resize', function() {
        clearTimeout(tid);
        tid = setTimeout(refreshRem, 300);
    }, false);
    win.addEventListener('pageshow', function(e) {
        if (e.persisted) {
            clearTimeout(tid);
            tid = setTimeout(refreshRem, 300);
        }
    }, false);

    if (doc.readyState === 'complete') {
        doc.body.style.fontSize = 12 * dpr + 'px';
    } else {
        doc.addEventListener('DOMContentLoaded', function(e) {
            doc.body.style.fontSize = 12 * dpr + 'px';
        }, false);
    }
    

    refreshRem();

    flexible.dpr = win.dpr = dpr;
    flexible.refreshRem = refreshRem;
    flexible.rem2px = function(d) {
        var val = parseFloat(d) * this.rem;
        if (typeof d === 'string' && d.match(/rem$/)) {
            val += 'px';
        }
        return val;
    }
    flexible.px2rem = function(d) {
        var val = parseFloat(d) / this.rem;
        if (typeof d === 'string' && d.match(/px$/)) {
            val += 'rem';
        }
        return val;
    }

})(window, window['lib'] || (window['lib'] = {}));


;(function (exprots, undefined) {

  function Load () {
    this.init.apply(this, arguments);
  }
  
  Load.prototype = {

      init: function () {
        this.loadFiles(this.filesToLoad(), function () {});
      },
   
      host: function () {
        var path = document.querySelector('[data-spm="src"]').src;
        var reg = /(.*)(\/js\/)\w*/;
        var part = path.match(reg);
        return part[1]+'/';
      },

      version: ((new Date()).getTime()).toString().substr(-4),  // "version=0.0.1"

      loadCSS: function(url, callback) {
        var link = document.createElement("link");
        link.type = "text/css";
        link.rel = "stylesheet";
        link.href = this.host()+url+'?'+this.version;
        document.getElementsByTagName("head")[0].appendChild(link);
        if(callback) {
          callback();
        }
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

      // 获取目录和文件名
      fileFolder: function () {
          var pathname = location.pathname,
              numOne = pathname.lastIndexOf("/"),
              numTwo = pathname.lastIndexOf("/", numOne-1),
              fileName = pathname.substr(numOne+1),
              folder = pathname.substr(numTwo+1, numOne-numTwo-1);
          fileName = fileName.replace(/\..+/, '');
          if (!fileName) {
            return ['layout', 'index'];
          }
          return [folder, fileName];
      },

      // 文件路径
      filesPath: function () {
        var s = this.fileFolder();
        return this.files[s[0]][s[1]];
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

        css: {
          common: 'css/common.css',
          main: 'css/main.css',
          user: 'css/user.css'
        },

        main: {
          'data-main': "js/main/config/config.js", 
          src: "js/lib/require/2.1.22/require.js"
        },

        layout: {
          index: 'js/main/views/layout/IndexView.js'
        }
      }

  }

  exprots.lop.load = new Load;

})(window, undefined);