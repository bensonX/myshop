[#escape x as x?html]
<!DOCTYPE html>
<html lang="en">
   <head>
        <meta charset = "utf-8" />
		<title>买德好</title>
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta name="keywords" content="test" />
		<meta name="description" content="买德好专注打造国内首家德国跨境精品聚集地，只将最具品质及品味的德国正品引入国人生活。涵盖生活多方面的产品体系，带来真正一站式的购物便捷体验。独具特色的知识性模块形式，让你无限贴近德式生活" />
		<link href="favicon.ico" rel="icon" type="image/x-icon" />
		<link type="text/css" rel="stylesheet" href="${base}/resources/shop/${theme}/css_mdh/common.css" />
        <link rel="stylesheet" type="text/css" href="${base}/resources/shop/${theme}/css_mdh/personal.css">
        <script type="text/javascript" src="${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
        <script src = "${base}/resources/shop/${theme}/js_mdh/third/common.js"></script>
        <script type="text/javascript" src="${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
        <script type="text/javascript" src="${base}/resources/shop/${theme}/js_mdh/main/views/personal.js"></script>
    </head>
    <body>
     	[#include "/shop/${theme}/include/header_mdh.ftl" /]
		<!-- 主体内容开始 -->
			<!-- 个人中心左侧导航开始 -->
		<div class="personal clearfix">
			<!-- 左侧 -->
			[#include "/shop/${theme}/member/index_left.ftl" /]
			<!-- end -->
			<!-- 我的订单详情开始 -->
			<div class="personal-item fr">
				<!-- 订单状态开始 -->
				<div class="personal-state">
					<h5 class="personal-state-title">${message("Order.status")}</h5>
					<div class="personal-state-plan">
						<span class="plan one din">
							<strong [#if order.status=="pendingPayment" || order.status=="failed" || order.status=="canceled" || order.status=="denied"]class="current"[/#if]>1</strong>
							<p class="smt">提交订单</p>
							<div class="time">
								<span>${order.createDate?string("yyyy-MM-dd HH:mm:ss")}</span>
							</div>
						</span>
						<p class="next din"></p>
						<span class="plan two din">
							<strong [#if order.status=="pendingReview" || order.status=="pendingShipment"]class="current"[/#if]>2</strong>
							<p class="smt">付款成功</p>
							<div class="time">
								[#if order.completeDate??]
									<span>${order.completeDate?string("yyyy-MM-dd HH:mm:ss")}</span>
								[/#if]
							</div>
						</span>
						<p class="next din"></p>
						<span class="plan threen din">
							<strong [#if order.status=="shipped" || order.status=="received"]class="current"[/#if]>3</strong>
							<p class="smt">订单处理中</p>
							<div class="time">
								[#if order.completeDate??]
									<span>${order.completeDate?string("yyyy-MM-dd HH:mm:ss")}</span>
								[/#if]
							</div>
						</span>
						<p class="next din"></p>
						<span class="plan four din">
							<strong [#if order.status=="completed"]class="current"[/#if]>4</strong>
							<p class="smt">成功</p>
							<div class="time">
								[#if order.completeDate??]
								<span>${order.completeDate?string("yyyy-MM-dd HH:mm:ss")}</span>
								[/#if]
							</div>
						</span>
					</div>
				</div>
				<!-- 订单状态信息 
				<div class="personal-state-message">
					<div class="company">
						<span>物流公司:</span>
						<p>圆通快递</p>
					</div>
					<div class="number">
						<span>运单号:</span>
						<p>652348952</p>
					</div>
					<div class="track">
						<span>物流跟踪:</span>
						<p class="message-one">
							<b>2016-03-28</b>
							<strong>12:09:00</strong>
							<em>顺丰速运</em>
							已收取快件
						</p>
						<p class="message-two">
							<b>2016-03-28</b>
							<strong>12:33:00</strong>
							<em>快件离开</em>
							<span class="for">［济南市中丽景苑营业点］</span>
							<i>正发往</i>
							<span class="to">［济南历城集散中心］</span>
						</p>
					</div>
				</div>
				-->
					<!-- 订单基础信息开始 -->
				<div class="personal-information">
					<h5>${message("shop.order.info")}</h5>
					<div class="place">
						<span>${message("shop.member.receiver.list")}:</span>
						<strong>${order.consignee}</strong>
						<em>${order.phone}</em>
						<p>${order.areaName}${order.address}</p>
					</div>
					<div class="identity">
						<span>身份证号码:</span>
						<p>${order.cardId} </p>
					</div>
					<div class="item">
						<p>
							<span>订单编号:</span>
							<strong>${order.sn}</strong>
							<em>${message("Order.status")}:</em>
							<b>${message("Order.Status." + order.status)}</b>
						</p>
						<p>
							<span>支付流水号:</span>
							<strong>${order.payment.sn}</strong>
							<em>${message("shop.member.deposit.paymentPlugin")}:</em>
							<b>${order.paymentMethodName}</b>
						</p>
					</div>
					[#list order.orderItems as orderItem]
					<div class="order-item [#if orderItem_index == 0]bt[/#if] clearfix">
						<table>
						<tr class="bt">
							<td>
								<img src="${orderItem.thumbnail!setting.defaultThumbnailProductImage}" alt="${orderItem.name}" height="90" width="90">
								</td>
							<td class="goods">
								<h6>${orderItem.name}
								[#if orderItem.product.specifications?has_content]
									<span class="silver">[${orderItem.product.specifications?join(", ")}]</span>
								[/#if]
								[#if orderItem.type != "general"]
									<span class="red">[${message("Goods.Type." + orderItem.type)}]</span>
								[/#if]
								<div class="number din">
									<p>x${orderItem.quantity}</p>
								</div>
								<div class="pirce din">
									<span>单价:${currency(orderItem.price, true)}</span>
									<p>税率:${rate(orderItem.comprehensiveTaxRate)}</p>
								</div>
								<div class="place din">
									<span>上海保税区发货</span>
									<!--
									<p>已送达</p>
									-->
								</div>
						</td>
						<td rowspan="2" class="empty" data-order="list">
							<div class="inempty" data-order="money"></div>
						</td>
						<td rowspan="2" class="money">
								<span>实付</span>
								<strong>￥800.00</strong>
							<p>
								<span>包含税金</span>
								<strong>￥12.00</strong>
								<span>运费</span>
								<strong>￥10.00</strong>
							</p>
							<strong>已共优惠</strong>
							<em>￥10.00</em>
						</td>
					</tr>
					[/#list]
				</table>
				</div>
			</div>
		</div>
	  	[#include "/shop/${theme}/include/footer_mdh.ftl" /]
    </body>
</html>
[/#escape]