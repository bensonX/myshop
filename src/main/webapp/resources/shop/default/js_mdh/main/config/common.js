/**
 *  common.js
 *  0.0.1
 */
var common = {};

/**
 * 判断pc端还是移动端
 * common.isMobileClient
 * @return {true: 移动端, false: pc端}
 */
;(function (exprots, undefined) {

  function MobilePcClient () {
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
          if ((navigator.userAgent.match(/(phone|pad|pod|iPhone|iPod|ios|iPad|Android|Mobile|BlackBerry|IEMobile|MQQBrowser|JUC|Fennec|wOSBrowser|BrowserNG|WebOS|Symbian|Windows Phone)/i))) {
            return true;
          }
          else
            return false;
        }
      }
    } catch(d) {}
  };

  function isSubdomain (c, d) {
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
  }

  exprots.common.isMobileClient = MobilePcClient();

})(window, undefined);

/**
 * 移动端viewport和字体大小进行设置
 */
;(function(win, lib) {
    // 如果是pc端直接return
    if (!common.isMobileClient) return;

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

/**
 * 处理ie兼容
 */

;(function (exprots, undefined) {

})(window, undefined);


/**
 * 加载异步js
 * common.loading({""})
 */
;(function (exprots, undefined) {

  function Loading () {
    this.init.apply(this, arguments);
  }

  Loading.prototype = {

      // 版本号，为了清除缓存使用
      version: ((new Date()).getTime()).toString().substr(-4), // 0.0.1

      init: function (options) {},

      // 到js文件的路径
      hostPath: function () {
        var path = document.querySelector('[data-tag="jsPath"]').src;
        var reg = /(.*)(\/main\/).*/;
        var part = path.match(reg);
        return part[1]+'/';
      },

      // js显示到页面
      loadingJsFile: function(file) {
        var script = document.createElement("script");
        script.type = "text/javascript";
        script.setAttribute("data-main", this.hostPath()+file["data-main"]+'?'+this.version);
        script.async = true;
        script.src = this.hostPath()+file.src+'?'+this.version;
        document.getElementsByTagName("head")[0].appendChild(script);
      },

      // 页面加载require和获取视图路径
      mainJs: function (options) {
        if (options)
          this.viewsJsPath = options;
        this.loadingJsFile({
          'data-main': "main/config/config.js",
          src: "third/require.js"
        });
      }

  }

  exprots.common.loading = new Loading;

})(window, undefined);