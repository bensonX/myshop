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
		<link rel="stylesheet" type="text/css" href="${base}/resources/shop/${theme}/css_mdh/common.css" />
		<link type="text/css" rel="stylesheet" href="${base}/resources/shop/${theme}/css_mdh/main.css" />
		<script src = "${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
		<script src = "${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
		<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
		<script type="text/javascript">
		$().ready(function() {
		
			//var $amountPayable = $("#amountPayable");
			//var $fee = $("#fee");
			var $other = $("#other");
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
				$('[data-tag="popupLayer"]').hide();
    			$('[data-tag="shieldingLayer"]').hide();
			});
			
			// 支付插件
			/**
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
							layer(data.message);
							setTimeout(function() {
								location.reload(true);
							}, 3000);
						}
					}
				});
			});
			**/
			
			// 支付
			$paymentForm.submit(function() {
				// 弹出窗口随窗口改变
			    windowSize();
			    // 弹出窗口随窗口改变而改变
			    $(window).resize(windowSize);
			});
			
			function windowSize () {
			    var $popupLayer = $('[data-tag="popupLayer"]');
			    var width = $popupLayer.outerWidth();
			    var height = $popupLayer.outerHeight();
			
			    var windowWdith = $(window).width();
			    var windowHeight = $(window).height();
			    $popupLayer.css({
			      top: (windowHeight-height)/2,
			      left: (windowWdith-width)/2,
			      display: 'block'
			    });
			
			    $('[data-tag="shieldingLayer"]').css({
			      width: windowWdith,
			      height: windowHeight
			    }).show();
			 }
		
		});
		</script>
	</head>
    <body>
    	[#include "/shop/${theme}/include/header_mdh.ftl" /]
		<!-- 主体部分开始 -->
		<div class="pay">
			<div class="pay-order">
				<p>请及时付款，以便尽快给您发货</p>
				<strong>${message("shop.order.info")}: </strong>
				<span class="order">${order.sn}</span>
				<a href="${base}/member/order/view.jhtml?sn=${order.sn}">${message("shop.order.view")}</a>
				<p>
					<strong>价格：</strong>
					<span class="price">[#if amount??]${currency(amount, true, true)}[#else]${currency(order.amountPayable, true, true)}[/#if]</span>
				</p>
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
				<p>
					[#if order.expire??] 
						${message("shop.order.expireTips", order.expire?string("yyyy-MM-dd HH:mm"))}
					[/#if]
				</p>
				<p>
				[#if order.status == "pendingPayment"]
					${message("shop.order.pendingPayment")}
				[#elseif order.status == "pendingReview"]
					${message("shop.order.pendingReview")}
				[#else]
					${message("shop.order.pending")}
				[/#if]
			</div>
			<div class="settlement">
					[#if order.paymentMethod.method == "online"]
						[#if paymentPlugins?has_content]
							<form class="buy-pay" id="paymentForm" action="${base}/payment/plugin_submit.jhtml" method="post" target="_blank">
								<input type="hidden" name="type" value="payment" />
								<input type="hidden" name="sn" value="${order.sn}" />
								<div id="paymentPlugin" >
									<label for="buy">${message("Order.paymentMethod")}</label>
									[#list paymentPlugins?chunk(4, "") as row]
										[#list row as paymentPlugin]
												[#if paymentPlugin?has_content]
													<input type="radio" id="${paymentPlugin.id}" name="paymentPluginId" value="${paymentPlugin.id}"[#if paymentPlugin == defaultPaymentPlugin] checked="checked"[/#if] />
													<label for="${paymentPlugin.id}" >
														[#if paymentPlugin.logo?has_content]
															<img title="${paymentPlugin.paymentName}" src="${paymentPlugin.logo}" height="56" width="55">
														[#else]
															<em>${paymentPlugin.paymentName}</em>
														[/#if]		
													</label>
												[/#if]
										[/#list]
									[/#list]
								</div> 
								<button type="submit" id="paymentButton" >${message("shop.order.payNow")}</button>
							</form>
						[/#if]
					[#else]
						[#noescape]
							${order.paymentMethod.content}
						[/#noescape]
					[/#if]
			</div>	
		</div>

		
		<div class = "shielding-layer" data-tag="shieldingLayer"></div>
		<div class = "popup-layer" data-tag="popupLayer" >
			<div class = "title clearfix" >
				<span>买德好</span>
				<strong class = "fr" id="other" title = "${message("shop.order.otherPaymentMethod")}" >x</strong>
			</div>
			<div class = "context" >
				[#noescape]
					${message("shop.order.paymentDialog")}
				[/#noescape]
			</div>
			<div class = "button" >
				<a href = "${base}/member/order/view.jhtml?sn=${order.sn}" >${message("shop.order.paid")}</a>
				<a href = "${base}/" >${message("shop.order.trouble")}</a>
			</div>
		</div>
	[#include "/shop/${theme}/include/footer_mdh.ftl" /]	
    </body>
</html>
[/#escape]