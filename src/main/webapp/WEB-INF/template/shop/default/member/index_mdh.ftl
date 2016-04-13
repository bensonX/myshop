[#escape x as x?html]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>${message("shop.member.index")}[#if showPowered] - Powered By JSHOP[/#if]</title>
<meta name="author" content="JSHOP Team" />
<meta name="copyright" content="JSHOP" />

<link rel="stylesheet" type="text/css" href="${base}/resources/shop/${theme}/css_mdh/personal.css">
<script type="text/javascript"  src = "${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
<script type="text/javascript"  src = "${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
[#--
<link href="${base}/resources/shop/${theme}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/${theme}/css/member.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
--]

</head>
<body>
	[#include "/shop/${theme}/include/header_mdh.ftl" /]
	<!-- 主体内容开始 -->
			<!-- 个人中心左侧导航开始 -->
		<div class="personal clearfix">
			<ul class="personal-nav fl">
				<li class="current"><a href="javascript:;">我的信息</a></li>
				<li><a href="./personal-item.html">我的订单</a></li>
				<li><a href="javascript:;">我的收藏</a></li>
				<li><a href="./personal-address.html">收件地址</a></li>
				<li><a href="${base}/member/password/edit.jhtml">安全中心</a></li>
			</ul>
			<!-- 个人信息详情开始 -->
			<div class="personal-item fr">
				<div class="title">
					<p>亲爱的【<span>慕冰玉</span>】，欢迎来到买德好。</p>
					<p>您已和买德相识<span>120天</span>，买过<span>68</span>件德国好物，超越了<span>55%</span>的用户。</p>
				</div>
				<div class="personal-integral about din">
					<p>您的积分</p>
					<span>258</span>
				</div>
				<div class="personal-wx about din">
					<p>绑定微信</p>
					<span></span>
				</div>
				<div class="personal-service about din">
					<p>您的专享服务</p>
					<span class="one"></span>
					<span class="two"></span>
					<span class="three"></span>
					<span class="four"></span>
				</div>
				<div class="personal-orde">
					<p class="orde">最近订单</p>
					<ul class="personal-orde-list">
						<li class="first">
							<img class="din" src="../../images_mdh/content8.png" height="95" width="95">
							<div class="content din">
								<h6>ladmirable香氛蜡烛（清新古龙水）</h6>
								<p>您的快件已由日月光集团招聘中心(家乐福店)菜鸟驿站代收。请注意查收</p>
								<span>2016-03-29 <em>12:36:05</em></span>
								<a href="javascript:;">查看物流明细</a>
							</div>
							<button type="button">确认收货</button>
							<strong>x3</strong>
						</li>
						<li>
							<img class="din" src="../../images_mdh/content8.png" height="95" width="95">
							<div class="content din">
								<h6>ladmirable香氛蜡烛（清新古龙水）</h6>
								<p>您的快件已由日月光集团招聘中心(家乐福店)菜鸟驿站代收。请注意查收</p>
								<span>2016-03-29 <em>12:36:05</em></span>
								<a href="javascript:;">查看物流明细</a>
							</div>
							<button type="button">确认收货</button>
							<strong>x3</strong>
						</li>
					</ul>
				</div>
			</div>
		</div>
	[#include "/shop/${theme}/include/footer_mdh.ftl" /]
			
	[#--
	<div class="container member">
		<div class="row">
			[#include "/shop/${theme}/member/include/navigation.ftl" /]
			<div class="span10">
				<div class="index">
					<div class="top clearfix">
						<div>
							<ul>
								<li>
									${message("shop.member.index.memberRank")}: ${member.memberRank.name}
								</li>
								<li>
									${message("shop.member.index.balance")}:
									<strong>${currency(member.balance, true, true)}</strong>
								</li>
								<li>
									${message("shop.member.index.amount")}:
									<strong>${currency(member.amount, true, true)}</strong>
								</li>
								<li>
									${message("shop.member.index.point")}:
									<em>${member.point}</em>
									<a href="coupon_code/exchange.jhtml" class="silver">${message("shop.member.index.exchange")}</a>
								</li>
							</ul>
							<ul>
								<li>
									<a href="order/list.jhtml">${message("shop.member.index.pendingPaymentOrderCount")}(<em>${pendingPaymentOrderCount}</em>)</a>
									<a href="order/list.jhtml">${message("shop.member.index.pendingShipmentOrderCount")}(<em>${pendingShipmentOrderCount}</em>)</a>
								</li>
								<li>
									<a href="message/list.jhtml">${message("shop.member.index.messageCount")}(<em>${messageCount}</em>)</a>
									<a href="coupon_code/list.jhtml">${message("shop.member.index.couponCodeCount")}(<em>${couponCodeCount}</em>)</a>
								</li>
								<li>
									<a href="favorite/list.jhtml">${message("shop.member.index.favoriteCount")}(<em>${favoriteCount}</em>)</a>
									<a href="product_notify/list.jhtml">${message("shop.member.index.productNotifyCount")}(<em>${productNotifyCount}</em>)</a>
								</li>
								<li>
									<a href="review/list.jhtml">${message("shop.member.index.reviewCount")}(<em>${reviewCount}</em>)</a>
									<a href="consultation/list.jhtml">${message("shop.member.index.consultationCount")}(<em>${consultationCount}</em>)</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="list">
						<div class="title">${message("shop.member.index.newOrder")}</div>
						<table class="list">
							<tr>
								<th>
									${message("Order.sn")}
								</th>
								<th>
									${message("OrderItem.product")}
								</th>
								<th>
									${message("Order.consignee")}
								</th>
								<th>
									${message("Order.amount")}
								</th>
								<th>
									${message("Order.status")}
								</th>
								<th>
									${message("shop.common.createDate")}
								</th>
								<th>
									${message("shop.member.action")}
								</th>
							</tr>
							[#list newOrders as order]
								<tr[#if !order_has_next] class="last"[/#if]>
									<td>
										${order.sn}
									</td>
									<td>
										[#list order.orderItems as orderItem]
											<img src="${orderItem.thumbnail!setting.defaultThumbnailProductImage}" class="thumbnail" alt="${orderItem.name}" />
											[#if orderItem_index == 2]
												[#break /]
											[/#if]
										[/#list]
									</td>
									<td>
										${order.consignee!"-"}
									</td>
									<td>
										${currency(order.amount, true)}
									</td>
									<td>
										[#if order.hasExpired()]
											${message("shop.member.order.hasExpired")}
										[#else]
											${message("Order.Status." + order.status)}
										[/#if]
									</td>
									<td>
										<span title="${order.createDate?string("yyyy-MM-dd HH:mm:ss")}">${order.createDate}</span>
									</td>
									<td>
										<a href="order/view.jhtml?sn=${order.sn}">[${message("shop.member.action.view")}]</a>
									</td>
								</tr>
							[/#list]
						</table>
						[#if !newOrders?has_content]
							<p>${message("shop.member.noResult")}</p>
						[/#if]
					</div>
				</div>
			</div>
		</div>
		
		
		[#include "/shop/${theme}/include/footer_mdh.ftl" /]
	</div>
	--]
	
</body>
</html>
[/#escape]