[#escape x as x?html]
<!DOCTYPE html>
<html lang="en">
    <head>
		<meta charset = "utf-8" />
		<title>${message("shop.order.checkout")}[#if showPowered]买德好[/#if]</title>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta name="keywords" content="test" />
		<meta name="description" content="买德好专注打造国内首家德国跨境精品聚集地，只将最具品质及品味的德国正品引入国人生活。涵盖生活多方面的产品体系，带来真正一站式的购物便捷体验。独具特色的知识性模块形式，让你无限贴近德式生活" />
		<link href="favicon.ico" rel="icon" type="image/x-icon" />
		<link type="text/css" rel="stylesheet" href="${base}/resources/shop/${theme}/css_mdh/main.css" />
		<script src = "${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
		<script src = "${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
		<script src="${base}/resources/shop/${theme}/js_mdh/main/views/pay.js"></script>
		<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
		
		<script type="text/javascript">
			$(function () {
				/**
				 * 微信提示成功
				 * pay.js    1-80
				 */
				WechatPrompt({
					urlRefreshPost: '${base}/payment/payResultSearch/${out_trade_no}.jhtml'
				});
				
			});
		</script>
	</head>
    <body>
		[#include "/shop/${theme}/include/header_mdh.ftl" /]	
		<!-- 主体部分开始 -->
		<div class="pay">
			<div class="wechat">
				<P>微信支付</P>
				<img src="${base}/${code}" width="190" height="190">
				<span>请使用微信扫一扫<br>扫描二维码支付</span>
				<a href="javascript:;">${out_trade_no}</a>
			</div>	
		</div>
		<div class = "shielding-layer" data-tag="shieldingLayer"></div>
		<div class = "wechat-refresh" data-tag="wechatRefresh" >
			<h3>微信支付</h3>
			<p>微信支付成功，请关闭窗口</p>
			<a href = "javascript:;" data-tag="close">确&nbsp;定</a
		</div>		
		[#include "/shop/${theme}/include/footer_mdh.ftl" /]
    </body>	
</html>
[/#escape]		
		