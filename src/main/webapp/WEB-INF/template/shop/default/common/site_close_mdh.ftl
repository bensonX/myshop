[#escape x as x?html]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>${message("shop.error.title")}[#if showPowered] - Powered By JSHOP[/#if]</title>
<meta name="author" content="JSHOP Team" />
<meta name="copyright" content="JSHOP" />
<link href="${base}/resources/shop/${theme}/images_mdh/icon/favicon.ico" rel="icon"/>

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
		<div class="main">${setting.siteCloseMessage}</div>
    </div>
    [#include "/shop/${theme}/include/footer_mdh.ftl" /]
</body>
</html>
[/#escape]