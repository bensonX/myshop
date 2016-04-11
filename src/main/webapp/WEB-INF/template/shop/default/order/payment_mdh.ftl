[#escape x as x?html]
<!DOCTYPE html>
<html lang="en">
     <head>
		<meta charset = "utf-8" />
		<title>${message("shop.order.payment")}[#if showPowered] - 买德好[/#if]</title>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta name="keywords" content="test" />
		<meta name="description" content="买德好专注打造国内首家德国跨境精品聚集地，只将最具品质及品味的德国正品引入国人生活。涵盖生活多方面的产品体系，带来真正一站式的购物便捷体验。独具特色的知识性模块形式，让你无限贴近德式生活" />
		<link href="favicon.ico" rel="icon" type="image/x-icon" />
		<link type="text/css" rel="stylesheet" href="${base}/resources/shop/${theme}/css_mdh/main.css" />
		<script src = "${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
		<script src = "${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
		<script src = "${base}/resources/shop/${theme}/js_mdh/main/views/pay.js"></script>
		<script>
			var order_sn='${order.sn}';
			$(function () {
				/**
				 * 微信过期刷新页面
				 * pay.js    1-80
				 */
				WechatPrompt({
					urlRefreshPost: '../../test/test.json',  // ajax 判断微信支付是否过期， 返回success表示过期
					data: {
						// 对象
						productId: '1234567'
					}
				});

				/**
				 * 支付成功
				 * pay.js    81-165
				 */
				PaySuccess({
					urlPaySuccessPost: '../../test/test.json',  // ajax 支付成功， 返回success表示成功了
					data: {
						// 对象
						productId: '1234567'
					}
				});
			});

		</script>
	</head>
    <body>
    [#include "/shop/${theme}/include/header_mdh.ftl" /]
		<div class="pay">
			<p class="order">
				<!--
				[#noescape]
					${message("shop.order.paymentDialog")}
				[/#noescape]
				-->
				请及时付款，以便尽快给您发货！<br>
				订单号： ${order.sn}&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<a href="javascript:;">订单详情</a> <br>
				<!--
				[#if amount??]
					<strong id="amountPayable">${currency(amount, true, true)}</strong>
				[#else]
					<strong id="amountPayable">${currency(order.amountPayable, true, true)}</strong>
				[/#if]
				[#if fee??]
					<span[#if fee <= 0] class="hidden"[/#if]>(${message("Order.fee")}: <span id="fee">${currency(fee, true)}</span>)</span>
				[#else]
					<span[#if order.fee <= 0] class="hidden"[/#if]>(${message("Order.fee")}: <span id="fee">${currency(order.fee, true)}</span>)</span>
				[/#if]
				-->
				价格：[#if amount??]${currency(amount, true, true)}[#else]${currency(order.amountPayable, true, true)}[/#if]<br>
				请您在提交订单后0小时57分127秒内完成支付，否则订单会自动取消。
				<!--
				[#if order.status == "pendingPayment"]
					${message("shop.order.pendingPayment")}
				[#elseif order.status == "pendingReview"]
					${message("shop.order.pendingReview")}
				[#else]
					${message("shop.order.pending")}
				[/#if]
				-->
			</p>
			<!--
			<p class="message">
				nice泰国椰清4个附赠开椰器和吸管，单果1000-1100g(限江浙沪)上海保税区发货/德国发货<br>
				收货信息：上海市，浦东新区，祖冲之路2305号天之骄子B栋508室，xxx，手机：xxxxxxxxxxx
			</p>
			-->
			<div class="wechat">
				<P>微信支付</P>
				<img src="${base}/resources/shop/${theme}/images_mdh/wechat.png" width="190" height="190">
				<span>请使用微信扫一扫<br>扫描二维码支付</span>
				<a href="javascript:;">选择支付宝进行结算</a>
			</div>
		</div>

		<div class = "wechat-refresh" data-tag="wechatRefresh" >
			<h3>微信支付</h3>
			<p>你的二维码已过期<br/>请刷新页面</p>
			<a href = "javascript:;" data-tag="refreshClick">刷&nbsp;新</a>
		</div>
		
		<div class = "shielding-layer" data-tag="shieldingLayer"></div>
		<div class = "popup-layer" data-tag="popupLayer" >
			<div class = "title clearfix" >
				<span class = "fl">支付成功</span>
				<strong class = "fr" data-tag="popupClose">x</strong>
			</div>
			<div class = "context" >
				<p>你的订单已经支付成功，我们将尽快为你发货</p>
			</div>
			<div class = "button" >
				<a href = "${base}/member/order/view.jhtml?sn=${order.sn}" data-tag="jumpClick">查看我的订单</a>
			</div>
		</div>
		[#include "/shop/${theme}/include/footer_mdh.ftl" /]
    </body>
</html>
[/#escape]