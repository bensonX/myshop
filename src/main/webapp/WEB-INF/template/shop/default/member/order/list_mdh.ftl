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
  <script type="text/javascript" src="${base}/resources/shop/${theme}/js_mdh/third/common.js"></script>
  <script type="text/javascript" src="${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
  <script type="text/javascript" src="${base}/resources/shop/${theme}/js_mdh/main/views/personal.js"></script>
  <script>
  	$(function () {
  		// 配送鼠标移上去效果
  		$('[data-logistics="mouse"]').bind({
  			mouseenter: function (event) {
  				var $this = $(this);
  				$this.find('[data-logistics="showHide"]').show();
  			},

  			mouseleave: function (event) {
  				var $this = $(this);
  				$this.find('[data-logistics="showHide"]').hide();
  			}
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

  		$('[data-close="layer"]').click(function() {
				$('[data-tag="popupLayer"]').hide();
    		$('[data-tag="shieldingLayer"]').hide();
			});

			$('[data-order="close"]').bind('click', function (e) {
				// 弹出窗口随窗口改变
		    windowSize();
		    // 弹出窗口随窗口改变而改变
		    $(window).resize(windowSize);
			});
  	});
  	var pageInfo={pageNumber:${page.pageable.pageNumber!1},pageTotal:${page.totalPages!1},url:'${base}/member/order/list.jhtml'};
  	function turnPage(type){
  		debugger;
  		if (type==='down') {
  			if (pageInfo.pageNumber<pageInfo.pageTotal) {
  				var num=pageInfo.pageNumber*1+1;
  				location.href=pageInfo.url+"?pageNumber="+num;
  			}
  		} else if (type==="up") {
  			if (pageInfo.pageNumber>1) {
  				var num=pageInfo.pageNumber*1-1;
  				location.href=pageInfo.url+"?pageNumber="+num;
  			}
  		}
  	}
  </script>
</head>
<body>
		[#include "/shop/${theme}/include/header_mdh.ftl" /]
		<!-- 主体内容开始 -->
		<!-- 个人中心左侧导航开始 -->
		<div class="personal clearfix">
			[#include "/shop/${theme}/member/index_left.ftl" /]
			<!-- 我的订单详情开始 -->
			<div class="personal-item fr">
				[#if page.total<1]
					<p class="order-title">您目前暂无订单，您可以前往：
						<a href="javascript:;">新近单品</a>
						<a href="javascript:;">我的购物车</a>
						<a href="javascript:;">我的收藏</a>
					</p>
				[#else]
				<div class = "personal-top clearfix" >	
					<div class = "fl" >
						<form class="order-search" action = "${base}/member/order/list.jhtml" method = "get">
							<input name="searchContent" type="text" />
							<button type="submit">搜索订单</button>
						</form>
					</div>
				</div>
				<!-- 
					<p class="order-title">没有此订单号，您可以前往：
						<a href="javascript:;">新近单品</a>
						<a href="javascript:;">我的购物车</a>
						<a href="javascript:;">我的收藏</a>
					</p> 
				-->
				<div class="personal-order">
					<table>
						<thead class="order-list-title">
							<tr>
								<th>
									<span class="goods">德国好物</span>
								</th>
								<th>
									<span class="price">单价/元</span>
								</th>
								<th>
									<span class="number">数量</span>
								</th>
								<th>
									<span class="money">实付金额</span>
								</th>
								<th>
									<span class="state">状态</span>
								</th>
								<!--
								<th>
									<span class="state">操作</span>
								</th>
								-->
							</tr>
						</thead>
						[#list page.content as order]
						<tbody class="order-list">
							<tr class="message">
								<td colspan = "6" >
									<span class="date">${order.createDate?string("yyyy-MM-dd HH:mm:ss")}</span>
									<strong>订单号：</strong>
									<span class="no">${order.sn}</span>
								</td>
							</tr>
							[#list order.orderItems as orderItem]
							<tr class="list">
								<td class="list-goods">
									<img class="din" src="${orderItem.thumbnail!setting.defaultThumbnailProductImage}" alt="${orderItem.name}" height="90" width="90">
									<div class="item din">
										<h6>${orderItem.name}</h6>
										[#if orderItem.product.specifications?has_content]
											<span class="silver">[${orderItem.product.specifications?join(", ")}]</span>
										[/#if]
										[#if orderItem.type != "general"]
											<span class="red">[${message("Goods.Type." + orderItem.type)}]</span>
										[/#if]
									</div>
								</td>
								<td class="list-price">
									<span class="dl">${currency(orderItem.price, true)}</span>
								</td>
								<td class="list-number" >
									<span class="dl">x${orderItem.quantity}</span>
								</td>
								[#if orderItem_index == 0]
								<td rowspan="${order.orderItems.size()+1}" class="list-money">
									<p>${currency(order.amountPayable, true, true)}</p>
									<span class="dl">含税金:${currency(order.taxFee, true, true)}</span>
									<!-- <strong class="dl">含运费￥10.00</strong> -->
									<!-- <em class="dl">已共优惠￥10.00</em> -->
								</td>
								<td rowspan="${order.orderItems.size()+1}" class="list-state">
									[#switch order.status]
							          	[#case "pendingPayment"]
								          	<div>
											<span>${message("Order.Status.pendingPayment")}</span>
											<a href="${base}/member/order/view.jhtml?sn=${order.sn}" target="_blank">订单详情</a>
											</div>
											<div class = "" >
												<a href = "javascript:;">付款</a>
												<a href = "javascript:;" data-order="close">取消订单</a>
											</div>
							             	[#break]
										[#case "pendingReview"]
											<div>
												<span>${message("Order.Status.pendingReview")}</span>
												<a href="${base}/member/order/view.jhtml?sn=${order.sn}" target="_blank">订单详情</a>
											</div>
											<div class = "" >
												<a href = "javascript:;" data-order="close">取消订单</a>
											</div>
											[#break]
										[#case "pendingShipment"]
											<div>
												<span>${message("Order.Status.pendingShipment")}</span>
												<a href = "./order-state.html" target="_blank" data-logistics="mouse">配送中
													<!-- 没有物流信息 -->
													<div class = "logistics dn" data-logistics="showHide">
														<ul>
															<li>圆通单号8521619608  2016-3-28 15:32<li>
															<li>已到达浦东新区分拣中心</li>
														</ul>
														<i></i>
													</div>
												</a>
												<a href="${base}/member/order/view.jhtml" target="_blank">订单详情</a>
											</div>
											<div class = "" >
												<a href = "javascript:;" data-order="close">取消订单</a>
											</div>
											[#break]
										[#case "shipped"]
											<div>
											<span>${message("Order.Status.shipped")}</span>
											<a href="${base}/member/order/view.jhtml?sn=${order.sn}" target="_blank">${message("shop.order.view")}</a>
											</div>
											<div class = "" >
												<a href = "javascript:;" data-order="close">取消订单</a>
											</div>
											[#break]
										[#case "received"]
											<div>
											<span>${message("Order.Status.received")}</span>
											<a href="${base}/member/order/view.jhtml?sn=${order.sn}" target="_blank">${message("shop.order.view")}</a>
											</div>
											<div class = "" >
												<a href = "javascript:;" data-order="close">再次购买</a>
											</div>
											[#break]
										[#case "completed"]
											<div>
												<span>${message("Order.Status.completed")}</span>
												<a href="${base}/member/order/view.jhtml?sn=${order.sn}" target="_blank">${message("shop.order.view")}</a>
											</div>
											<div class = "" >
												<a href = "javascript:;" data-order="close">再次购买</a>
											</div>
											[#break]
										[#case "failed"]
											<div>
											<span>${message("Order.Status.failed")}</span>
											<a href="${base}/member/order/view.jhtml?sn=${order.sn}" target="_blank">${message("shop.order.view")}</a>
											</div>
											<div class = "" >
												<a href = "javascript:;" data-order="close">再次购买</a>
											</div>
											[#break]
										[#case "canceled"]
											<div>
											<span>${message("Order.Status.canceled")}</span>
											<a href="${base}/member/order/view.jhtml?sn=${order.sn}" target="_blank">${message("shop.order.view")}</a>
											</div>
											<div class = "" >
												<a href = "javascript:;" data-order="close">再次购买</a>
											</div>
											[#break]
										[#case "denied"]
											<div>
											<span>${message("Order.Status.denied")}</span>
											<a href="${base}/member/order/view.jhtml?sn=${order.sn}" target="_blank">${message("shop.order.view")}</a>
											</div>
											<div class = "" >
												<a href = "javascript:;" data-order="close">再次购买</a>
											</div>
											[#break]
							          	[#default]
							          	<!-- 没有 -->
							        [/#switch]
								</td>
								[/#if]
							</tr>
							[/#list]
						</tbody>
						[/#list]	
					</table>	
					<div class="pagin fr">
						<a href = "javascript:turnPage('up');" class="prev-disabled">上一页<b></b></a>
						<a class="current">${page.pageable.pageNumber}</a>                    
    					<a href = "javascript:turnPage('down');" class="next-disabled">下一页<b></b></a>    
     		 		</div>
				</div>
				[/#if]
				<div class = "shielding-layer" data-tag="shieldingLayer"></div>
				<div class = "popup-layer dn" data-tag="popupLayer" >
					<div class = "title clearfix" >
						<span>买德好</span>
						<strong class = "fr" data-close="layer" >x</strong>
					</div>
					<div class = "context" >确定取消订单?</div>
					<div class = "button" >
						<a href = "javascript:;" >${message("shop.order.codeConfirm")}</a>
					</div>
				</div>
			</div>
		</div>
		[#include "/shop/${theme}/include/footer_mdh.ftl" /]
  </body>
</html>
[/#escape]