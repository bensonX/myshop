[#escape x as x?html]
<!DOCTYPE html>
<html lang="en">
     <head>
		<meta charset = "utf-8" />
		<title>${message("shop.order.payment")}[#if showPowered] - 买德好[/#if]</title>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<title>${message("shop.order.payment")}[#if showPowered] - Powered By JSHOP[/#if]</title>
		<meta name="keywords" content="test" />
		<meta name="description" content="买德好专注打造国内首家德国跨境精品聚集地，只将最具品质及品味的德国正品引入国人生活。涵盖生活多方面的产品体系，带来真正一站式的购物便捷体验。独具特色的知识性模块形式，让你无限贴近德式生活" />
		<link href="favicon.ico" rel="icon" type="image/x-icon" />
		<link type="text/css" rel="stylesheet" href="${base}/resources/shop/${theme}/css_mdh/main.css" />
		<link href="${base}/resources/shop/${theme}/css/common.css" rel="stylesheet" type="text/css" />
        <link href="${base}/resources/shop/${theme}/css/order.css" rel="stylesheet" type="text/css" />
		<script src = "${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
		<script src = "${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
		<script src = "${base}/resources/shop/${theme}/js_mdh/main/views/pay.js"></script>
		<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
		<script type="text/javascript">
		$().ready(function() {
		
			var $dialogOverlay = $("#dialogOverlay");
			var $dialog = $("#dialog");
			var $other = $("#other");
			var $amountPayable = $("#amountPayable");
			var $fee = $("#fee");
			var $paymentForm = $("#paymentForm");
			var $paymentPluginId = $("#paymentPlugin input:radio");
			var $paymentButton = $("#paymentButton");
			
			[#if order.paymentMethod.method == "online"]
				// 订单锁定
				setInterval(function() {
					$.ajax({
						url: "lock.jhtml",
						type: "POST",
						data: {sn: "${order.sn}"},
						dataType: "json",
						cache: false
					});
				}, 50000);
				
				// 检查等待付款
				setInterval(function() {
					$.ajax({
						url: "check_pending_payment.jhtml",
						type: "GET",
						data: {sn: "${order.sn}"},
						dataType: "json",
						cache: false,
						success: function(data) {
							if (!data) {
								location.href = "${base}/member/order/view.jhtml?sn=${order.sn}";
							}
						}
					});
				}, 10000);
			[/#if]
			
			// 选择其它支付方式
			$other.click(function() {
				$dialogOverlay.hide();
				$dialog.hide();
			});
			
			// 支付插件
			$paymentPluginId.click(function() {
				$.ajax({
					url: "calculate_amount.jhtml",
					type: "GET",
					data: {paymentPluginId: $(this).val(), sn: "${order.sn}"},
					dataType: "json",
					cache: false,
					success: function(data) {
						if (data.message.type == "success") {
							$amountPayable.text(currency(data.amount, true, true));
							if (data.fee > 0) {
								$fee.text(currency(data.fee, true)).parent().show();
							} else {
								$fee.parent().hide();
							}
						} else {
							$.message(data.message);
							setTimeout(function() {
								location.reload(true);
							}, 3000);
						}
					}
				});
			});
			
			// 支付
			$paymentForm.submit(function() {
				$dialogOverlay.show();
				$dialog.show();
			});
		
		});
		</script>
		
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
			
	<div id="dialogOverlay" class="dialogOverlay"></div>
	<div class="container payment">
		<div class="row">
			<div class="span12">
				<div id="dialog" class="dialog">
					[#noescape]
						${message("shop.order.paymentDialog")}
					[/#noescape]
					<div>
						<a href="${base}/member/order/view.jhtml?sn=${order.sn}">${message("shop.order.paid")}</a>
						<a href="${base}/">${message("shop.order.trouble")}</a>
					</div>
					<a href="javascript:;" id="other">${message("shop.order.otherPaymentMethod")}</a>
				</div>
				<div class="result">
					[#if order.status == "pendingPayment"]
						<div class="title">${message("shop.order.pendingPayment")}</div>
					[#elseif order.status == "pendingReview"]
						<div class="title">${message("shop.order.pendingReview")}</div>
					[#else]
						<div class="title">${message("shop.order.pending")}</div>
					[/#if]
					<table>
						<tr>
							<th colspan="4">${message("shop.order.info")}:</th>
						</tr>
						<tr>
							<td width="100">${message("Order.sn")}:</td>
							<td width="340">
								<strong>${order.sn}</strong>
								<a href="${base}/member/order/view.jhtml?sn=${order.sn}">[${message("shop.order.view")}]</a>
							</td>
							<td width="100">${message("Order.amountPayable")}:</td>
							<td>
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
							</td>
						</tr>
						<tr>
							<td>${message("Order.shippingMethod")}:</td>
							<td>${order.shippingMethodName!"-"}</td>
							<td>${message("Order.paymentMethod")}:</td>
							<td>${order.paymentMethodName!"-"}</td>
						</tr>
						[#if order.expire??]
							<tr>
								<td colspan="4">${message("shop.order.expireTips", order.expire?string("yyyy-MM-dd HH:mm"))}</td>
							</tr>
						[/#if]
					</table>
					[#if order.paymentMethod.method == "online"]
						[#if paymentPlugins?has_content]
							<form id="paymentForm" action="${base}/payment/plugin_submit.jhtml" method="post" target="_blank">
								<input type="hidden" name="type" value="payment" />
								<input type="hidden" name="sn" value="${order.sn}" />
								<table id="paymentPlugin" class="paymentPlugin">
									<tr>
										<th colspan="4">${message("Order.paymentMethod")}:</th>
									</tr>
									[#list paymentPlugins?chunk(4, "") as row]
										<tr>
											[#list row as paymentPlugin]
												[#if paymentPlugin?has_content]
													<td>
														<input type="radio" id="${paymentPlugin.id}" name="paymentPluginId" value="${paymentPlugin.id}"[#if paymentPlugin == defaultPaymentPlugin] checked="checked"[/#if] />
														<label for="${paymentPlugin.id}">
															[#if paymentPlugin.logo?has_content]
																<em title="${paymentPlugin.paymentName}" style="background-image: url(${paymentPlugin.logo});">&nbsp;</em>
															[#else]
																<em>${paymentPlugin.paymentName}</em>
															[/#if]
														</label>
													</td>
												[#else]
													<td>
														&nbsp;
													</td>
												[/#if]
											[/#list]
										</tr>
									[/#list]
								</table>
								<input type="submit" id="paymentButton" class="paymentButton" value="${message("shop.order.payNow")}" />
							</form>
						[/#if]
					[#else]
						[#noescape]
							${order.paymentMethod.content}
						[/#noescape]
					[/#if]
				</div>
			</div>
		</div>
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