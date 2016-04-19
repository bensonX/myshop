[#escape x as x?html]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>${message("shop.member.password.edit")}[#if showPowered] - Powered By JSHOP[/#if]</title>
<meta name="author" content="JSHOP Team" />
<meta name="copyright" content="JSHOP" />

<link rel="stylesheet" type="text/css" href="${base}/resources/shop/${theme}/css_mdh/personal.css">
<script type="text/javascript"  src = "${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
<script type="text/javascript"  src = "${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $inputMobileForm = $("#inputMobileForm");
	$currentMobile = $("#currentMobile");

	$codeCurrentButton = $("#codeCurrentButton");
	$submit = $("button:submit");

	[@flash_message /]
	
	
	// 表单验证
	$inputMobileForm.validate({
	    rules: {
	      currentCode: {
	        required: true,
	        pattern: /.{4,}/,
	        digits : true,
	        equalTo: "#compareCurrentCode"
	      }
	    },
	    messages: {
	      currentCode: {
	        required : "请输入验证码",
	        pattern: "请输入四位验证码",
	        digits : "验证码应该输入数字",
	        equalTo: "验证码错误"
	      }
	    }
	    /**,
	    submitHandler: function(form) {
	    	$.ajax({
				url: $inputMobileForm.attr("action"),
				type: "POST",
				dataType: "json",
				cache: false,
				beforeSend: function() {
					console.log('ok');
					$submit.prop("disabled", true);
				},
				success: function(data) {
					console.log(data);
					if (data.message.type == 'success') {
						location.href = "./editMobile.html";
					} 
					else {
						$submit.prop("disabled", false);
						layer(data.content);
					}	
				}
			});
		}**/	
	 });

	
	var mobile = ${mobile};
	if(mobile){
		$currentMobile.val(mobile);
	}
	
	// 1.获取手机验证码
  	$codeCurrentButton.bind('click', function (e){
	    var mobile = $.trim($currentMobile.val());
	    var pattern = /^1[3|4|5|7|8|9]\d{9}$/;
	    if (!pattern.test(mobile)) {
	      layer('请输入正确的手机号码');
	      return false;
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
	        requestPhone($(e.target));
	      },
	      success: function(message) {
	        $("#compareCurrentCode").val(message.content);
	        if (message.type != "success") {
	          clearInterval(setInter);
	          aginphoneText('获取验证码');
	          layer(message.content)
	        }
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
	              event.html('已发送'+time+'秒');
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
	              .html('已发送'+options+'秒')
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
						
			<form id="inputMobileForm" action="${base}/member/password/newMobileMdh.jhtml" method="post">	
				<div class="phoneVerification">
					<div class="phone number">
						<label class="din" for="number">手机号</label>
						<input type="text" class="mobileNumber" id="currentMobile"  disabled = "disabled">
						<input type="hidden" name="mobile" value="${mobile}"/>
					</div>
					<div class="phone code clearfix">
						<label class="din fl" for="code">手机验证码</label>
						<input class="mobileCode fl" type="text" id="currentCode" name="currentCode" placeholder="请填写手机验证码">
						<button type="button" class="codeButton fl" id = "codeCurrentButton">获取验证码</button>
					</div>
				</div>
				<button class="confirm sub" type="submit">提交</button>
				<input type="hidden" id="compareCurrentCode" value = "" />
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