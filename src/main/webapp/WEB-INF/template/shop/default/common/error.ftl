[#escape x as x?html]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<link href="${base}/resources/shop/${theme}/images_mdh/icon/favicon.ico" rel="icon"/>
<title>${message("shop.error.title")}[#if showPowered] - Powered By JSHOP[/#if]</title>
<meta name="author" content="JSHOP Team" />
<meta name="copyright" content="JSHOP" />

<link rel="stylesheet" type="text/css" href="${base}/resources/shop/${theme}/css_mdh/main.css">
<script type="text/javascript" src="${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js_mdh/main/views/personal.js"></script>

[#--
<link href="${base}/resources/shop/${theme}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/${theme}/css/error.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
--]
</head>
<body>
	[#include "/shop/${theme}/include/header_mdh.ftl" /]
	<div class="lose clearfix">
    	<img src="${base}/resources/shop/${theme}/images_mdh/icon/lose.png" height="66" width="65">
    		<p>
    			<span>哎呀！你访问的页面不存在...</span>
    			<a href="${base}/">返回首页</a>
    			5秒后自动返回<a href="javascript:;" onclick="history.back(); return false;">上一页</a>
    		</p>
    </div>
    [#include "/shop/${theme}/include/footer_mdh.ftl" /]
[#--
	[#include "/shop/${theme}/include/header.ftl" /]
	<div class="container error">
		<div class="row">
			<div class="span12">
				<div class="main">
					<dl>
						<dt>${message("shop.error.message")}</dt>
						[#if errorMessage?has_content]
							<dd>${errorMessage}</dd>
						[/#if]
						[#if exception?? && exception.message?has_content]
							<dd>${exception.message}</dd>
						[/#if]
						[#if constraintViolations?has_content]
							[#list constraintViolations as constraintViolation]
								<dd>[${constraintViolation.propertyPath}] ${constraintViolation.message}</dd>
							[/#list]
						[/#if]
						<dd>
							<a href="javascript:;" onclick="history.back(); return false;">${message("shop.error.back")}</a>
						</dd>
						<dd>
							<a href="${base}/">&gt;&gt; ${message("shop.error.home")}</a>
						</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
	[#include "/shop/${theme}/include/footer.ftl" /]	
--]
</body>
</html>
[/#escape]