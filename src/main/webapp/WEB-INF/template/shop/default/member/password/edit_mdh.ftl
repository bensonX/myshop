[#escape x as x?html]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>${message("shop.member.password.edit")}[#if showPowered] - Powered By JSHOP[/#if]</title>
<meta name="author" content="JSHOP Team" />
<meta name="copyright" content="JSHOP" />
<link rel="stylesheet" type="text/css" href="${base}/resources/shop/${theme}/css_mdh/common.css" />
<link rel="stylesheet" type="text/css" href="${base}/resources/shop/${theme}/css_mdh/personal.css">
<script type="text/javascript"  src = "${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
<script type="text/javascript"  src = "${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	var $inputMobileForm = $("#inputMobileForm");
	[@flash_message /]
	
	// 表单验证
	$inputForm.validate({
		rules: {
			currentPassword: {
				required: true,
				pattern: /.{6,}/,
				remote: {
					url: "check_current_password.jhtml",
					cache: false
				}
			},
			password: {
				required: true,
				pattern: /.{6,}/,
				minlength: ${setting.passwordMinLength}
			},
			rePassword: {
				required: true,
				pattern: /.{6,}/,
				equalTo: "#password"
			}
		},
		
		messages: {
	      currentPassword: {
	        required : "六位数以上的密码",
	        pattern: "六位数以上的密码",
	        remote: "旧密码输入错误"
	      },
	      password: {
	        required : "六位数以上的密码",
	        pattern: "请输入六位数以上的密码"
	      },
	      rePassword: {
	        required : "六位数以上的密码",
	        pattern: "请输入六位数以上的密码",
	        equalTo: "与输入的新密码不相同"
	      }
	    }
	});
	
	
	// 表单验证
	$inputMobileForm.validate({
	    rules: {
	      currentMobile: {
	        required: true,
	        pattern: /1[3|4|5|7|8|9]\d{9}/
	      },
	      currentCode: {
	        required: true,
	        equalTo: "#compareCurrentCode",
	        digits : true
	      },
	      newMobile: {
	        required: true,
	        pattern: /1[3|4|5|7|8|9]\d{9}/,
	        remote: {
	        	data:{
                 mobile:function(){return $("#newMobile").val();}
               	},
				url: "${base}/register/check_mobile.jhtml",
				cache: false
			}
	      },
	      newCode: {
	        required: true,
	        equalTo: "#compareNewCode",	
	        digits : true
	      }
	    },
	    messages: {
	      currentMobile: {
	        required : "请输入手机号码",
	        pattern: "请输入正确的手机号"
	      },
	      currentCode: {
	        required : "请输入验证码",
	        pattern: "验证码不对！请重新输",
	        digits : "验证码应该输入数字"
	      },
	      newMobile: {
	        required : "请输入手机号码",
	        pattern: "请输入正确的手机号",
	        remote: "手机号已被注册"
	      },
	      newCode: {
	        required : "请输入验证码",
	        equalTo: "验证码不对！请重新输",
	        digits : "验证码应该输入数字"
	      }
	    }
	 });
	$currentMobile = $("#currentMobile");
	$newMobile = $("#newMobile");
	$codeCurrentButton = $("#codeCurrentButton");
	$codeNewButton = $("#codeNewButton");
	
	var mobile = getCookie("mobile") || '';
	if(mobile){$currentMobile.val(mobile);}
	
	// 1.获取手机验证码
  	$codeCurrentButton.bind('click', function (){
	    var mobile = $.trim($currentMobile.val());
	    var pattern = /1[3|4|5|7|8|9]\d{9}/;
	    if (!pattern.test(mobile)) {
	      alert('请输入正确的手机号码');
	      return ;
	    }
	    alert("mobile="+mobile);
	    $.ajax({
	      url: '${base}/register/mobile_captcha.jhtml',
	      type: "GET",
	      data: {
	        "mobile": mobile
	      },
	      dataType: "json",
	      cache: true,
	      beforeSend: function() {
	        //requestPhone(this);
	      },
	      success: function(message) {
			//$.message(message);
			alert(message);
	      	$("#compareCurrentCode").val(message.content);
	        //if (message.type != "success") {
	        //  clearInterval(setInter);
	        //  aginphoneText('获取验证码');
	        //}
	      }
	    });
	  });
	
	// 2.获取手机验证码
  	$codeNewButton.bind('click', function (){
	    var mobile = $.trim($newMobile.val());
	    var pattern = /1[3|4|5|7|8|9]\d{9}/;
	    if (!pattern.test(mobile)) {
	      alert('请输入正确的新手机号码');
	      return ;
	    }
	    $.ajax({
	      url: '${base}/register/mobile_captcha.jhtml',
	      type: "GET",
	      data: {
	        "mobile": mobile
	      },
	      dataType: "json",
	      cache: true,
	      beforeSend: function() {
	        //requestPhone(this);
	      },
	      success: function(message) {
			//$.message(message);
	      	$("#compareNewCode").val(message.content);
	        //if (message.type != "success") {
	        //  clearInterval(setInter);
	        //  aginphoneText('获取验证码');
	        //}
	      }
	    });
	  });
	
	// 获取手机验证码按钮倒计时
  function requestPhone (event) {
      var time = 30;
      aginphoneText(time,event);
      setInter = setInterval(function () {
          --time;
          if (time >= 0) {
              $codeButton.html(time+'秒');
          }
          else {
             clearInterval(setInter);
             aginphoneText('获取验证码',event);
          }
      }, 1000);
  }
  // 获取手机验证码按钮禁止点击
  function aginphoneText (options,event) {
      if (typeof options == 'number')
          event
              .html(options+'秒')
              .attr('disabled', 'disabled')
              .addClass('clickBackground');
      else 
          event
              .html(options)
              .removeAttr('disabled')
              .removeClass('clickBackground');
  }
});
</script>

[#--
<link href="${base}/resources/shop/${theme}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/${theme}/css/member.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputForm = $("#inputForm");
	
	[@flash_message /]
	
	// 表单验证
	$inputForm.validate({
		rules: {
			currentPassword: {
				required: true,
				pattern: /.{6,}/,
				remote: {
					url: "check_current_password.jhtml",
					cache: false
				}
			},
			password: {
				required: true,
				minlength: ${setting.passwordMinLength}
			},
			rePassword: {
				required: true,
				equalTo: "#password"
			}
		}
	});

});
</script>
--]
</head>
<body>
	[#include "/shop/${theme}/include/header_mdh.ftl" /]
	
	<!-- 主体内容开始 -->
	<div class="personal clearfix">
		<!-- 个人中心左侧导航开始 -->

		[#assign indexLeft=5]
		[#include "/shop/${theme}/member/index_left.ftl" /]
		<!-- 安全中心开始 -->
		<div class="personal-security fr">
		
			<form id="inputForm" action="update.jhtml" method="post">
				<div class="current password">
					<input type="password" placeholder="${message("shop.member.password.currentPassword")}"  name="currentPassword" class="text" maxlength="200" autocomplete="off" >
				</div>
				<div class="new password">
					<input type="password" placeholder="${message("shop.member.password.newPassword")}" name="password" class="text" maxlength="${setting.passwordMaxLength}" autocomplete="off"  id="password" >
				</div>
				<div class="news password">
					<input type="password" placeholder="${message("shop.member.password.rePassword")}"  name="rePassword" class="text" maxlength="${setting.passwordMaxLength}" autocomplete="off" >
				</div>
				<button class="confirm" type="submit">确认修改</button>
			</form>
			
		</div>
	</div>
	
	[#include "/shop/${theme}/include/footer_mdh.ftl" /]
	
[#--
	[#assign current = "passwordEdit" /]
	[#include "/shop/${theme}/include/header.ftl" /]
	<div class="container member">
		<div class="row">
			[#include "/shop/${theme}/member/include/navigation.ftl" /]
			<div class="span10">
				<div class="input">
					<div class="title">${message("shop.member.password.edit")}</div>
					<form id="inputForm" action="update.jhtml" method="post">
						<table class="input">
							<tr>
								<th>
									${message("shop.member.password.currentPassword")}:
								</th>
								<td>
									<input type="password" name="currentPassword" class="text" maxlength="200" autocomplete="off" />
								</td>
							</tr>
							<tr>
								<th>
									${message("shop.member.password.newPassword")}:
								</th>
								<td>
									<input type="password" id="password" name="password" class="text" maxlength="${setting.passwordMaxLength}" autocomplete="off" />
								</td>
							</tr>
							<tr>
								<th>
									${message("shop.member.password.rePassword")}:
								</th>
								<td>
									<input type="password" name="rePassword" class="text" maxlength="${setting.passwordMaxLength}" autocomplete="off" />
								</td>
							</tr>
							<tr>
								<th>
									&nbsp;
								</th>
								<td>
									<input type="submit" class="button" value="${message("shop.member.submit")}" />
									<input type="button" class="button" value="${message("shop.member.back")}" onclick="history.back(); return false;" />
								</td>
							</tr>
						</table>
					</form>
				</div>
			</div>
		</div>
	</div>
	[#include "/shop/${theme}/include/footer.ftl" /]
--]
</body>
</html>
[/#escape]