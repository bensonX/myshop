[#escape x as x?html]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>${message("shop.register.title")}[#if showPowered] - Powered By JSHOP[/#if]</title>
<meta name="author" content="JSHOP Team" />
<meta name="copyright" content="JSHOP" />
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.validate.js"></script>
<link rel="stylesheet" type="text/css" href="${base}/resources/shop/${theme}/css_mdh/main.css" />
<script type="text/javascript">
$().ready(function() {
	alert("123");
	var $registerForm_mdh = $("#registerForm_mdh");
	var $phone = $("#phone");

	var $getPhoneCaptcha=$("#getPhoneCaptcha");
	var $submit = $("input:submit");
	$getPhoneCaptcha.click(function() {
		alert($phone.val());
		
		if($phone.val()!=""){
			$.ajax({
				url: "${base}/register/phone_captcha.jhtml",
				data:{"phone":$phone.val()},
				type: "GET",
				dataType: "text",
				cache: true,
				success: function(data) {
					alert(data);
					$("#compareCode").val(data);
				},
				error: function(data) {
    				alert("error");
    			}
			});
		}
	});

	// 表单验证
	$registerForm_mdh.validate({
		rules: {
			phone: {
				required: true,
				pattern: /^[1][358][0-9]{9}$/,
				remote: {
					url: "${base}/register/check_phone.jhtml",
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
			},
			captcha: {
				required: true,
				minlength: ${setting.passwordMinLength},
				pattern: /^[0-9][0-9][0-9][0-9]$/,
				remote: {
					url: "${base}/register/phone_captcha.jhtml",
					cache: false
				}
			}
		},
		messages: {
			phone: {
				pattern: "${message("shop.register.phoneIllegal")}",
				remote: "${message("shop.register.phoneExist")}"
			},
			captcha: {
				pattern: "${message("shop.captcha.invalid")}",
				remote: "${message("shop.captcha.invalid")}"
			},
		}//,submitHandler: function(form) {}
	});
});
</script>

</head>
<body>
	<input type="text" id="compareCode" value="关于验证码"/>
	    <header class="landing"></header>
    	<div class="landing">
			<h1></h1>
			<span>欢迎注册</span>
			<form id="registerForm_mdh" action="${base}/register/submit.jhtml" method="post">
				<input class="tet" type="text"     id="phone" name="phone"    maxlength="200" autocomplete="off" placeholder="请输入手机号" />
				<input class="tet" type="password" name="password" maxlength="${setting.passwordMaxLength}" autocomplete="off" placeholder="请输入密码"/>
				<input class="tet" type="password" name="rePassword" maxlength="${setting.passwordMaxLength}" autocomplete="off" placeholder="请重新输入密码"/>
				<input class="tet" type="password" name="captcha" maxlength="4" autocomplete="off" placeholder="短信验证码"/>
				<button class="register" type="button" name="getPhoneCaptcha" id="getPhoneCaptcha">获取验证码</button>
				<p class="clearfix register">
					<input class="names" type="radio" value="我已阅读并接受服务条款" name="nex" />
					<a>我已阅读并接受服务条款</a>
				</p>
				<button class="registered">立即注册</button>
				<p class="last clearfix">已注册可　<a href="">直接登陆</a>
					<a class="email" href="">通过邮箱注册》</a>
				</p>
				<div class="register-fix">
					<div class="register-infix  clearfix">
						<span class="one"></span>
						<span class="two"></span>
						<span class="three"></span>
					</div>
					<p>弱中强</p>
				</div>
			</form>
		</div>
</body>
</html>
[/#escape]