
[#--  escape x as x?html]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>${message("shop.login.title")}[#if showPowered] - Powered By JSHOP[/#if]</title>
<meta name="author" content="JSHOP Team" />
<meta name="copyright" content="JSHOP" />
<link href="${base}/resources/shop/${theme}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/${theme}/css/login.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.validate.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jsbn.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/prng4.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/rng.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/rsa.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/base64.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $loginForm = $("#loginForm");
	var $username = $("#username");
	var $password = $("#password");
	var $captcha = $("#captcha");
	var $captchaImage = $("#captchaImage");
	var $isRememberUsername = $("#isRememberUsername");
	var $submit = $("input:submit");
	
	// 记住用户名
	if (getCookie("memberUsername") != null) {
		$isRememberUsername.prop("checked", true);
		$username.val(getCookie("memberUsername"));
		$password.focus();
	} else {
		$isRememberUsername.prop("checked", false);
		$username.focus();
	}
	
	// 更换验证码
	$captchaImage.click(function() {
		$captchaImage.attr("src", "${base}/common/captcha.jhtml?captchaId=${captchaId}&timestamp=" + new Date().getTime());
	});
	
	// 表单验证、记住用户名
	$loginForm.validate({
		rules: {
			username: "required",
			password: "required"
			[#if setting.captchaTypes?? && setting.captchaTypes?seq_contains("memberLogin")]
				,captcha: "required"
			[/#if]
		},
		submitHandler: function(form) {
			$.ajax({
				url: "${base}/common/public_key.jhtml",
				type: "GET",
				dataType: "json",
				cache: false,
				beforeSend: function() {
					$submit.prop("disabled", true);
				},
				success: function(data) {
					var rsaKey = new RSAKey();
					rsaKey.setPublic(b64tohex(data.modulus), b64tohex(data.exponent));
					var enPassword = hex2b64(rsaKey.encrypt($password.val()));
					$.ajax({
						url: $loginForm.attr("action"),
						type: "POST",
						data: {
							username: $username.val(),
							enPassword: enPassword
							[#if setting.captchaTypes?? && setting.captchaTypes?seq_contains("memberLogin")]
								,captchaId: "${captchaId}",
								captcha: $captcha.val()
							[/#if]
						},
						dataType: "json",
						cache: false,
						success: function(message) {
							if ($isRememberUsername.prop("checked")) {
								addCookie("memberUsername", $username.val(), {expires: 7 * 24 * 60 * 60});
							} else {
								removeCookie("memberUsername");
							}
							$submit.prop("disabled", false);
							if (message.type == "success") {
								[#noescape]
									[#if redirectUrl??]
										location.href = "${redirectUrl?js_string}";
									[#else]
										location.href = "${base}/";
									[/#if]
								[/#noescape]
							} else {
								$.message(message);
								[#if setting.captchaTypes?? && setting.captchaTypes?seq_contains("memberLogin")]
									$captcha.val("");
									$captchaImage.attr("src", "${base}/common/captcha.jhtml?captchaId=${captchaId}&timestamp=" + new Date().getTime());
								[/#if]
							}
						}
					});
				}
			});
		}
	});

});
</script>
</head>
<body>
	[#include "/shop/${theme}/include/header.ftl" /]
	<div class="container login">
		<div class="row">
			<div class="span6">
				[@ad_position id = 6 /]
			</div>
			<div class="span6">
				<div class="wrap">
					<div class="main">
						<div class="title">
							<strong>${message("shop.login.title")}</strong>USER LOGIN
						</div>
						<form id="loginForm" action="${base}/login/submit.jhtml" method="post">
							<table>
								<tr>
									<th>
										[#if setting.isEmailLogin]
											${message("shop.login.usernameOrEmail")}:
										[#else]
											${message("shop.login.username")}:
										[/#if]
									</th>
									<td>
										<input type="text" id="username" name="username" class="text" maxlength="200" />
									</td>
								</tr>
								<tr>
									<th>
										${message("shop.login.password")}:
									</th>
									<td>
										<input type="password" id="password" name="password" class="text" maxlength="200" autocomplete="off" />
									</td>
								</tr>
								[#if setting.captchaTypes?? && setting.captchaTypes?seq_contains("memberLogin")]
									<tr>
										<th>
											${message("shop.captcha.name")}:
										</th>
										<td>
											<span class="fieldSet">
												<input type="text" id="captcha" name="captcha" class="text captcha" maxlength="4" autocomplete="off" /><img id="captchaImage" class="captchaImage" src="${base}/common/captcha.jhtml?captchaId=${captchaId}" title="${message("shop.captcha.imageTitle")}" />
											</span>
										</td>
									</tr>
								[/#if]
								<tr>
									<th>
										&nbsp;
									</th>
									<td>
										<label>
											<input type="checkbox" id="isRememberUsername" name="isRememberUsername" value="true" />${message("shop.login.isRememberUsername")}
										</label>
										<label>
											&nbsp;&nbsp;<a href="${base}/password/find.jhtml">${message("shop.login.findPassword")}</a>
										</label>
									</td>
								</tr>
								<tr>
									<th>
										&nbsp;
									</th>
									<td>
										<input type="submit" class="submit" value="${message("shop.login.submit")}" />
									</td>
								</tr>
								[#if loginPlugins?has_content]
									<tr class="loginPlugin">
										<th>
											&nbsp;
										</th>
										<td>
											<ul>
												[#list loginPlugins as loginPlugin]
													<li>
														<a href="${base}/login/plugin_submit.jhtml?pluginId=${loginPlugin.id}"[#if loginPlugin.description??] title="${loginPlugin.description}"[/#if]>
															[#if loginPlugin.logo?has_content]
																<img src="${loginPlugin.logo}" alt="${loginPlugin.loginMethodName}" />
															[#else]
																${loginPlugin.loginMethodName}
															[/#if]
														</a>
													</li>
												[/#list]
											</ul>
										</td>
									</tr>
								[/#if]
								<tr class="register">
									<th>
										&nbsp;
									</th>
									<td>
										<dl>
											<dt>${message("shop.login.noAccount")}</dt>
											<dd>
												${message("shop.login.tips")}
												<a href="${base}/register.jhtml">${message("shop.login.register")}</a>
											</dd>
										</dl>
									</td>
								</tr>
							</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	[#include "/shop/${theme}/include/footer.ftl" /]
</body>
</html>
[/#escape --]

[#escape x as x?html]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
	<head>
		<meta charset = "utf-8" />
		<title>买德好</title>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta name="keywords" content="test" />
		<meta name="description" content="买德好专注打造国内首家德国跨境精品聚集地，只将最具品质及品味的德国正品引入国人生活。涵盖生活多方面的产品体系，带来真正一站式的购物便捷体验。独具特色的知识性模块形式，让你无限贴近德式生活" />
		<link href="favicon.ico" rel="icon" type="image/x-icon" />
		<!-- css -->
		<link rel="stylesheet" type="text/css" href="${base}/resources/shop/${theme}/css_mdh/main.css" />
		<script type="text/javascript"  src = "${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
		<script type="text/javascript"  src = "${base}/resources/shop/${theme}/js_mdh/third/jquery.validate.js"></script>
		<script type="text/javascript"  src = "${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>

		<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.lSelect.js"></script>
		<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jsbn.js"></script>
		<script type="text/javascript" src="${base}/resources/shop/${theme}/js/prng4.js"></script>
		<script type="text/javascript" src="${base}/resources/shop/${theme}/js/rng.js"></script>
		<script type="text/javascript" src="${base}/resources/shop/${theme}/js/rsa.js"></script>
		<script type="text/javascript" src="${base}/resources/shop/${theme}/js/base64.js"></script>
		<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
		<script type="text/javascript">
		$().ready(function() {


			var $loginForm = $("#loginForm");
			var $mobile = $("#mobile");
			var $password = $("#password");
			var $captcha = $("#captcha");
			var $captchaImage = $("#captchaImage");
			var $captchaImage2 = $("#captchaImage2");
			
			var $isRememberUsername = $("#isRememberUsername");
			var $submit = $("input:submit");
			
			// 记住用户名
			  if (getCookie("mobile") != null) {
			    $isRememberUsername.prop("checked", true);
			    $mobile.val(getCookie("mobile"));
			    $password.focus();
			  } else {
			    $isRememberUsername.prop("checked", false);
			    $mobile.focus();
			  }
			  
			// 更换验证码
			$captchaImage.click(function() {
				$captchaImage.attr("src", "${base}/common/captcha.jhtml?captchaId=${captchaId}&timestamp=" + new Date().getTime());
			});
			$captchaImage2.click(function() {
				$captchaImage.attr("src", "${base}/common/captcha.jhtml?captchaId=${captchaId}&timestamp=" + new Date().getTime());
			});
			
			// 表单验证、记住用户名
			$loginForm.validate({
				rules: {
			      mobile: {
			        required: true,
			        pattern: /1[3|4|5|7|8|9]\d{9}$/,
			        minlength: 11,
			        remote: {
			        	type:"GET",
						url: "${base}/login/check_mobile.jhtml",
						data:{
                  			mobile:function(){return $("#mobile").val();}
                		},
						cache: false
					}
			      },
				  password: {
			        required: true,
			        pattern: /.{6,}/,
			      }
					[#if setting.captchaTypes?? && setting.captchaTypes?seq_contains("memberLogin")]
						,captcha:  {
					        required: true,
					        pattern: /.{4}/,
					    }
					[/#if]
				},
				messages: {
			      mobile: {
			        required : "请输入手机号码",
        			pattern: "输入正确的手机号",
        			remote: "手机号码不存在"
			      },

			      password: {
			        required : "请输入密码",
			        pattern  : "请输入正确的密码"
			      },

			      captcha: {
			        required : "请输入验证码",
			        pattern  : "请输入正确的验证码"
			      }
			    },
				submitHandler: function(form) {
					$.ajax({
						url: "${base}/common/public_key.jhtml",
						type: "GET",
						dataType: "json",
						cache: false,
						beforeSend: function() {
							$submit.prop("disabled", true);
						},
						success: function(data) {
							var rsaKey = new RSAKey();
							rsaKey.setPublic(b64tohex(data.modulus), b64tohex(data.exponent));
							var enPassword = hex2b64(rsaKey.encrypt($password.val()));
							
							$.ajax({
								url: $loginForm.attr("action"),
								type: "POST",
								data: {
									mobile: $mobile.val(),
									enPassword: enPassword
									[#if setting.captchaTypes?? && setting.captchaTypes?seq_contains("memberLogin")]
										,captchaId: "${captchaId}",
										captcha: $captcha.val()
									[/#if]
								},
								dataType: "json",
								cache: false,
								success: function(message) {
									
									if ($isRememberUsername.prop("checked")) {
										addCookie("memberUsername", $mobile.val(), {expires: 7 * 24 * 60 * 60});
									} else {
										removeCookie("memberUsername");
									}
									$submit.prop("disabled", false);
									if (message.type == "success") {
										[#noescape]
											[#if redirectUrl??]
												location.href = "${redirectUrl?js_string}";
											[#else]
												location.href = "${base}/";
											[/#if]
										[/#noescape]
									} else {
										alert("密码或验证码错误！");
										$.message(message);
										[#if setting.captchaTypes?? && setting.captchaTypes?seq_contains("memberLogin")]
											$captcha.val("");
											$captchaImage.attr("src", "${base}/common/captcha.jhtml?captchaId=${captchaId}&timestamp=" + new Date().getTime());
										[/#if]
									}
								}
							});
						}
					});
				}
			});
		
		});
		</script>
	</head>
    <body class="body-color">
    	<div id = "header" class="landing"></div>
    	<div class="landing login">
    	<a href = "/" >
				<h1></h1>
			</a>
			<form class="landing" id="loginForm" action="${base}/login/submit.jhtml" method="post">
				
				
				<div class = "username" >
					<input class="tet" type="text" placeholder="请输入手机号" id="mobile" name="mobile" maxlength="20" />
				</div>
				<div class = "password" >
					<input class="tet" type="password" placeholder="请输入密码" id="password" name="password" maxlength="200" autocomplete="off" />
				</div>
				<div class="inlanding clearfix">
					<input class="landing" type="text" placeholder="输入验证码" id="captcha" name="captcha" maxlength="4" autocomplete="off" />
					<img id="captchaImage" class="captchaImage" src="${base}/common/captcha.jhtml?captchaId=${captchaId}" title="${message("shop.captcha.imageTitle")}" />
				</div>
				<button type="button" class="new" id="captchaImage2">换一张</button>
				<button type="submit" class="landings">登　录</button>
				<p class="clearfix pass">
					<input class="names" type="checkbox"  id="isRememberUsername" name="isRememberUsername" value="false" />
					<label>${message("shop.login.isRememberUsername")}</label>
					<a class="last" href="javascript:;">　免费注册</a>
					<a href="javascript:;">忘记密码？|</a>
				</p>
				
				
			</form>
			[#if loginPlugins?has_content]
						<ul class="loginPlugin" >
							[#list loginPlugins as loginPlugin]
								<li>
									<div class="other">
									<a href="${base}/login/plugin_submit.jhtml?pluginId=${loginPlugin.id}"[#if loginPlugin.description??] title="${loginPlugin.description}"[/#if]>
										[#if loginPlugin.logo?has_content]
											<img src="${loginPlugin.logo}" alt="${loginPlugin.loginMethodName}" />
										[#else]
											${loginPlugin.loginMethodName}
										[/#if]
									</a>
									</div>
								</li>
							[/#list]
						</ul>
			[/#if]
			<p>
				<a href = "javascript:;">其它登录方式</a>
			</p>
			
		</div>
    </body>
</html>
[/#escape]
