[#escape x as x?html]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>${message("shop.member.order.list")}[#if showPowered] - Powered By JSHOP[/#if]</title>
<meta name="author" content="JSHOP Team" />
<meta name="copyright" content="JSHOP" />

        
<link rel="stylesheet" type="text/css" href="${base}/resources/shop/${theme}/css_mdh/personal.css">
<script type="text/javascript"  src = "${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
<script type="text/javascript"  src = "${base}/resources/shop/${theme}/js_mdh/main/views/personal.js"></script>
<script type="text/javascript"  src = "${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
[#--
<link href="${base}/resources/shop/${theme}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/${theme}/css/member.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.js"></script>
--]
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	[@flash_message /]

});
</script>
</head>
<body>
	[#assign current = "orderList" /]
	[#include "/shop/${theme}/include/header_mdh.ftl" /]
	
	<!-- 主体内容开始 -->
			<!-- 个人中心左侧导航开始 -->
		<div class="personal clearfix">
			<ul class="personal-nav fl">
				<li><a href="${base}/member/index.jhtml">我的信息</a></li>
				<li class="current"><a href="javascript:;">我的订单</a></li>
				<li><a href="${base}/member/favorite/list.jhtml">我的收藏</a></li>
				<li><a href="#">收件地址</a></li>
				<li><a href="${base}/member/password/edit.jhtml">安全中心</a></li>
			</ul>
			<!-- 我的订单详情开始 -->
			<div class="personal-item fr">
				<p class="order-title">您目前暂无订单，您可以前往：
					<a href="javascript:;">新近单品</a>
					<a href="javascript:;">我的购物车</a>
					<a href="javascript:;">我的收藏</a>
				</p>
				<form class="order-search">
					<input type="text">
					<button type="submit">搜索订单</button>
				</form>
				<div class="order-list-title">
					<span class="goods">德国好物</span>
					<span class="price">单价/元</span>
					<span class="number">数量</span>
					<span class="place">发货地</span>
					<span class="money">实付金额</span>
					<span class="state">状态</span>
				</div>
				
				[#list page.content as order]
					<div class="order-list">
						<p class="message">
							<span class="date">${order.createDate?string("yyyy-MM-dd")}</span>
							<span class="time">${order.createDate?string("HH:mm:ss")}</span>
							<strong>订单号：</strong>
							<span class="no">${order.sn}</span>
						</p>
						<ul class="List clearfix">
							<li class="list-goods fl">
								[#list order.orderItems as orderItem]
									<img src="${orderItem.thumbnail!setting.defaultThumbnailProductImage}" class="din" alt="${orderItem.name}" height="90" width="90" />
									[#if orderItem_index == 0]
										[#break /]
									[/#if]
								[/#list]
								<div class="item din">
									<h6>小岛老师的蛋糕教师</h6>
									<p><span>小岛留美</span>烹饪美食与酒书籍</p>
									<b>240ml</b>
								</div>
							</li>
							<li class="list-price fl">
								<span class="dl">${currency(order.price, true)}</span>
							</li>
							<li class="list-number fl">
								<span class="dl">${currency(order.quantity, true)}</span>
							</li>
							<li class="list-place fl">
								<p>上海保税区发货</p>
								<span class="dl">配送中</span>
								<a href="javascript:;">详情</a>
							</li>
							<li class="list-money fl">
								<p>${currency(order.amount, true)}</p>
								<span class="dl">含税金${currency(order.tax, true)}</span>
								<strong class="dl">含运费${currency(order.freight, true)}</strong>
								<em class="dl">已共优惠${currency(order.promotionDiscount, true)}</em>
							</li>
							<li class="list-state fl">
									[#if order.hasExpired()]
										<span class="dl">${message("shop.member.order.hasExpired")}</span>
									[#else]
										<span class="dl">${message("Order.Status." + order.status)}</span>
									[/#if]
								<a href="javascript:;">查看进度</a>
							</li>
						</ul>
					</div>
				[/#list]
				
				<!-- 订单状态开始 -->
				<div class="personal-state">
					<h5 class="personal-state-title">订单状态</h5>
					<div class="personal-state-plan">
						<span class="plan one din">
							<strong class="current">1</strong>
							<p class="smt">提交订单</p>
							<div class="time">
								<span>2016-3-28</span>
								<em>15:32</em>
							</div>
						</span>
						<p class="next din"></p>
						<span class="plan two din">
							<strong>2</strong>
							<p class="smt">付款成功</p>
							<div class="time">
								<span>2016-3-28</span>
								<em>15:32</em>
							</div>
						</span>
						<p class="next din"></p>
						<span class="plan threen din">
							<strong>3</strong>
							<p class="smt">订单处理中</p>
							<div class="time">
								<span>2016-11-28</span>
								<em>15:32</em>
							</div>
						</span>
						<p class="next din"></p>
						<span class="plan four din">
							<strong>4</strong>
							<p class="smt">成功</p>
							<div class="time">
								<span>2016-3-28</span>
								<em>15:32</em>
							</div>
						</span>
					</div>
				</div>
				<!-- 订单状态信息 -->
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
				<!-- 退货开始 -->
				<div class="personal-return">
					<h5 class="personal-state-title">退货</h5>
					<div class="personal-state-plan">
						<span class="plan one din">
							<strong class="current">1</strong>
							<p class="smt">提交申请</p>
							<div class="time">
								<span>2016-3-28</span>
								<em>15:32</em>
							</div>
						</span>
						<p class="next din"></p>
						<span class="plan two din">
							<strong>2</strong>
							<p class="smt">申请通过请寄回</p>
							<div class="time">
								<span>2016-3-28</span>
								<em>15:32</em>
							</div>
						</span>
						<p class="next din"></p>
						<span class="plan threen din">
							<strong>3</strong>
							<p class="smt">退货商品已收到</p>
							<div class="time">
								<span>2016-11-28</span>
								<em>15:32</em>
							</div>
						</span>
						<p class="next din"></p>
						<span class="plan four din">
							<strong>4</strong>
							<p class="smt">订单退款中</p>
							<div class="time">
								<span>2016-3-28</span>
								<em>15:32</em>
							</div>
						</span>
						<p class="next din"></p>
						<span class="plan four din">
							<strong>5</strong>
							<p class="smt">已完成</p>
							<div class="time">
								<span>2016-3-28</span>
								<em>15:32</em>
							</div>
						</span>
						<a href="javascript:;">查看钱款去向</a>
					</div>
						<!-- 退货信息开始 -->
					<div class="message">
						<div class="place">
							<span>退换货收件地址:</span>
							<p>上海市，浦东新区，祖冲之路2305号，天之骄子B栋，501室
								<a href="javascrtipt:;">修改</a>
							</p>
						</div>
						<div class="company">
							<span>物流公司:</span>
							<p>圆通快递</p>
						</div>
						<div class="number">
							<span>运单号码:</span>
							<p>652348952</p>
						</div>
					</div>
				</div>
				<!-- 换货/维修开始 -->
				<div class="personal-exchange">
					<h5 class="personal-state-title">换货/维修</h5>
					<div class="personal-state-plan">
						<span class="plan one din">
							<strong class="current">1</strong>
							<p class="smt">提交申请</p>
							<div class="time">
								<span>2016-3-28</span>
								<em>15:32</em>
							</div>
						</span>
						<p class="next din"></p>
						<span class="plan two din">
							<strong>2</strong>
							<p class="smt">申请通过请寄回</p>
							<div class="time">
								<span>2016-3-28</span>
								<em>15:32</em>
							</div>
						</span>
						<p class="next din"></p>
						<span class="plan threen din">
							<strong>3</strong>
							<p class="smt">换货/维修商品已收到</p>
							<div class="time">
								<span>2016-11-28</span>
								<em>15:32</em>
							</div>
						</span>
						<p class="next din"></p>
						<span class="plan four din">
							<strong>4</strong>
							<p class="smt">换货/维修商品处理中</p>
							<div class="time">
								<span>2016-3-28</span>
								<em>15:32</em>
							</div>
						</span>
						<p class="next din"></p>
						<span class="plan four din">
							<strong>5</strong>
							<p class="smt">已完成</p>
							<div class="time">
								<span>2016-3-28</span>
								<em>15:32</em>
							</div>
						</span>
					</div>
						<!-- 换货/维修信息开始 -->
					<div class="message">
						<div class="place">
							<span>退换货收件地址:</span>
							<p>上海市，浦东新区，祖冲之路2305号，天之骄子B栋，501室
								<a href="javascrtipt:;">修改</a>
							</p>
						</div>
						<div class="company">
							<span>物流公司:</span>
							<p>圆通快递</p>
						</div>
						<div class="number">
							<span>运单号码:</span>
							<p>652348952</p>
						</div>
					</div>
				</div>
					<!-- 订单基础信息开始 -->
				<div class="personal-information">
					<h5>订单基础信息</h5>
					<div class="place">
						<span>收货地址:</span>
						<strong>陈xx</strong>
						<em>15292045468</em>
						<p>上海市，浦东新区，祖冲之路2305号，天之骄子B栋501室</p>
					</div>
					<div class="identity">
						<span>身份证号码:</span>
						<p>410185198807015488 </p>
					</div>
					<div class="item">
						<p>
							<span>订单编号:</span>
							<strong>5236987125</strong>
							<em>订单状态:</em>
							<b>已收货</b>
						</p>
						<p>
							<span>支付流水号:</span>
							<strong>25689521</strong>
							<em>支付方式:</em>
							<b>微信支付</b>
						</p>
					</div>
					<ul class="order-item bt clearfix">
						<li>
							<img src="../../images_mdh/content8.png" height="90" width="90">
						</li>
						<li class="goods">
							<h6>小岛老师的蛋糕教师<span>小岛留美</span>烹饪美食与酒书籍</h6>
							<div class="number din">
								<span>240ml</span>
								<p>x10件</p>
							</div>
							<div class="pirce din">
								<span>单价:￥440.00</span>
								<p>税率:11.9%</p>
							</div>
							<div class="place din">
								<span>上海保税区发货</span>
								<p>已送达</p>
							</div>
						</li>
						<li class="money">
							<div class="pay">
								<span>实付</span>
								<strong>￥800.00</strong>
							</div>
							<p>
								<span>包含税金</span>
								<strong>￥12.00</strong>
								<span>运费</span>
								<strong>￥10.00</strong>
							</p>
							<b>已共优惠</b>
							<em>￥10.00</em>
						</li>
					</ul>
					<ul class="order-item clearfix">
						<li>
							<img src="../../images_mdh/content8.png" height="90" width="90">
						</li>
						<li class="goods">
							<h6>小岛老师的蛋糕教师<span>小岛留美</span>烹饪美食与酒书籍</h6>
							<div class="number din">
								<span>240ml</span>
								<p>x10件</p>
							</div>
							<div class="pirce din">
								<span>单价:￥440.00</span>
								<p>税率:11.9%</p>
							</div>
							<div class="place din">
								<span>上海保税区发货</span>
								<p>已送达</p>
							</div>
						</li>
						<li class="money">
							<div class="pay">
								<span>实付</span>
								<strong>￥800.00</strong>
							</div>
							<p>
								<span>包含税金</span>
								<strong>￥12.00</strong>
								<span>运费</span>
								<strong>￥10.00</strong>
							</p>
							<b>已共优惠</b>
							<em>￥10.00</em>
						</li>
					</ul>
				</div>
			</div>

		</div>
	[#--
	<div class="container member">
		<div class="row">
			[#include "/shop/${theme}/member/include/navigation.ftl" /]
			<div class="span10">
				<div class="list">
					<div class="title">${message("shop.member.order.list")}</div>
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
						[#list page.content as order]
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
									<a href="view.jhtml?sn=${order.sn}">[${message("shop.member.action.view")}]</a>
								</td>
							</tr>
						[/#list]
					</table>
					[#if !page.content?has_content]
						<p>${message("shop.member.noResult")}</p>
					[/#if]
				</div>
				[@pagination pageNumber = page.pageNumber totalPages = page.totalPages pattern = "?pageNumber={pageNumber}"]
					[#include "/shop/${theme}/include/pagination.ftl"]
				[/@pagination]
			</div>
		</div>
	</div>
	--]
	[#include "/shop/${theme}/include/footer_mdh.ftl" /]
</body>
</html>
[/#escape]