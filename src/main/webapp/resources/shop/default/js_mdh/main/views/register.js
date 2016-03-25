/**
 * 注册验证和提交表单
 * version 0.0.1
 */

;$(function () {

  // 验证
if ($.validator != null) {
    
    $.validator.setDefaults({
      errorClass: "fieldError",
      ignore: ".ignore",
      ignoreTitle: true,
      errorPlacement: function(error, element) {
        var fieldSet = element.closest("span.fieldSet");
        if (fieldSet.size() > 0) {
          error.appendTo(fieldSet);
        } else {
          error.insertAfter(element);
        }
      },
      submitHandler: function(form) {
        $(form).find("input:submit").prop("disabled", true);
        form.submit();
      }
    });

  }

  var $registerForm = $("#registerForm");
  var $phone = $("#phone");
  var $password = $("#password");
  var $code = $("#code");
  var $agreement = $("#agreement");
  var $submit = $("button:submit");
  var $codeButton = $('#codeButton');


  // 验证密码的强弱
  $password.keyup(function(e) {
      var isShow = checkPassword(this);
      if (0 == isShow) {
        $('.one').css('visibility', 'hidden');
        $('.two').css('visibility', 'hidden');
        $('.three').css('visibility', 'hidden');
      } else if (1 == isShow || 2 == isShow) {
        $('.one').css('visibility', 'visible');
      } else if (4 == isShow || 3 == isShow) {
        $('.two').css('visibility', 'visible');
      } else if (5 == isShow ) {
        $('.three').css('visibility', 'visible');
      }
  });

  function checkPassword(pwdinput) {
      var maths, smalls, bigs, corps, cat, num;
      var str = $(pwdinput).val()
      var len = str.length;

      var cat = /.{16}/g
      if (len == 0) return 1;
      if (len > 16) { $(pwdinput).val(str.match(cat)[0]); }
      cat = /.*[\u4e00-\u9fa5]+.*$/
      if (cat.test(str)) {
        return -1;
      }
      cat = /\d/;
      var maths = cat.test(str);
      cat = /[a-z]/;
      var smalls = cat.test(str);
      cat = /[A-Z]/;
      var bigs = cat.test(str);
      var corps = corpses(pwdinput);
      var num = maths + smalls + bigs + corps;

      if (len < 6) { return 1; }

      if (len >= 6 && len <= 8) {
        if (num == 1) return 1;
        if (num == 2 || num == 3) return 2;
        if (num == 4) return 3;
      }

      if (len > 8 && len <= 11) {
        if (num == 1) return 2;
        if (num == 2) return 3;
        if (num == 3) return 4;
        if (num == 4) return 5;
      }

      if (len > 11) {
        if (num == 1) return 3;
        if (num == 2) return 4;
        if (num > 2) return 5;
      }
    }

    function corpses(pwdinput) {
      var cat = /./g
      var str = $(pwdinput).val();
      var sz = str.match(cat)
      for (var i = 0; i < sz.length; i++) {
        cat = /\d/;
        maths_01 = cat.test(sz[i]);
        cat = /[a-z]/;
        smalls_01 = cat.test(sz[i]);
        cat = /[A-Z]/;
        bigs_01 = cat.test(sz[i]);
        if (!maths_01 && !smalls_01 && !bigs_01) { return true; }
      }
      return false;
    }

  // 点击获取手机验证码
  $codeButton.bind('click', function (){
    var phone = $.trim($phone.val());
    var pattern = /1[3|4|5|7|8|9]\d{9}/;
    if (!pattern.test(phone)) {
      alert('请输入正确的手机号码');
      return ;
    }
    $.ajax({
      url: 'http://www.maidehao.com/test/register.json',
      type: "POST",
      data: {
        phone: $phone.val()
      },
      dataType: "json",
      cache: false,
      beforeSend: function() {
        requestPhone();
      },
      success: function(message) {
        if (message.type != "success") {
          clearInterval(setInter);
          aginphoneText('获取验证码');
        }
      }
    });
  });

  // 表单验证
  $registerForm.validate({
    rules: {
      phone: {
        required: true,
        pattern: /1[3|4|5|7|8|9]\d{9}/,
        minlength: 11,
        remote: {
			url: "jshop/register/check_phone.jhtml",
			cache: false
		}
      },
      password: {
        required: true,
        pattern: /.{4}/,
      },
      rePassword: {
        required: true,
        equalTo: "#password"
      },

      code: {
        required: true,
        digits : true
      },

      agreement: {
        required: true,
      }
    },
    messages: {
      phone: {
        required : "请输入手机号码",
        pattern: "输入正确的手机号",
        remote: "手机已被注册"
      },

      password: {
        required : "六位数以上的密码",
        pattern: "六位数以上的密码",
      },

      rePassword: {
        required : "六位数以上的密码",
        equalTo: "密码不相同"
      },

      code: {
        required : "请输入验证码",
        pattern: "只允许输入正确的手机号",
        digits : "验证码应该输入数字"
      },

      agreement: {
        required: "必须接受条款",
      }
    },
    submitHandler: function(form) {
        $.ajax({
          url: $registerForm.attr("action"),
          type: "POST",
          data: {
            phone: $phone.val(),
            enPassword: $password.val(),
            code: $code.val()
          },
          dataType: "json",
          cache: false,
          success: function(message) {
            $.message(message);
            if (message.type == "success") {
              setTimeout(function() {
                $submit.prop("disabled", false);
                location.href = "/jshop/";
              }, 3000);
            } else {
              $submit.prop("disabled", false);
                clearInterval(setInter);
                aginphoneText('获取验证码');
            }
          }
      });
    }

  });
  // 获取手机验证码按钮倒计时
  function requestPhone () {
      var time = 30;
      aginphoneText(time+'秒');
      setInter = setInterval(function () {
          --time;
          if (time >= 0) {
              $codeButton.html(time+'秒');
          }
          else {
             clearInterval(setInter);
             aginphoneText('获取验证码');
          }
      }, 1000);
  }
  // 获取手机验证码按钮禁止点击
  function aginphoneText (options) {
      if (typeof options == 'number')
          $codeButton
              .html(options)
              .attr('disabled', 'disabled')
              .addClass('clickBackground');
      else 
          $codeButton
              .html(options)
              .removeAttr('disabled')
              .removeClass('clickBackground');
  }

});