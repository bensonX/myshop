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
		<link type="text/css" rel="stylesheet" href="${base}/resources/shop/${theme}/css_mdh/main.css" />
		<script src = "${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
		<script src = "${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
		<script src = "${base}/resources/shop/${theme}/js_mdh/main/views/cart.js"></script>
		<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
		<script>
			$(function () {
				/**
				 * 选，加，减，删，提交等功能
				 * cart
				 */
				ShoppingCart({
					urlMinusPlusPost: '${base}/cart/edit.jhtml',
					minusPlusData: {},

					urlDeletePost: '${base}/cart/delete.jhtml',
					deleteData: {}
				});

			});
		</script>
	</head>
    <body>
    	[#include "/shop/${theme}/include/header_mdh.ftl" /]	
		<!-- 购物车详情开始 -->
		<div class="shoppingcart-list">
			<a class="nav" href="javascript:;">购物车</a>
			<a class="last nav" href="javascript:;">付款</a>
			[#if cart?? && cart.cartItems?has_content]
				<form action = "${base}/order/checkout.jhtml" method = "post" data-data="form" >
					<table class="caption">
						<tr>
							<th class="first">
								<input type="checkbox" data-tag="selectAll">
							</th>
							<th>全选</th>
							<th>名称</th>
							<th>数量</th>
							<th>单价</th>
							<th>税率</th>
							<th>税费</th>
							<th>小计</th>
							<th>发货方式</th>
							<th class="last">操作</th>
						</tr>
						[#list cart.cartItems as cartItem]
							<tr class="details" data-list="${cartItem.id}">
								<td class="bl">
									<input class="a" type="checkbox" data-tag="select" name="cartItemIds" value="${cartItem.id}">
								</td>
								<td>
									<a href="${cartItem.product.url}" title="${cartItem.product.name}" target="_blank">
										<img src="${cartItem.product.thumbnail!setting.defaultThumbnailProductImage}" height="93" width="93" alt="${cartItem.product.name}">
									</a>
								</td>
								<td class="text">
									<a href="${cartItem.product.url}" title="${cartItem.product.name}" target="_blank">
										<h6>${abbreviate(cartItem.product.name, 50, "...")}</h6>
									</a>
									[#if cartItem.product.specifications?has_content]
										<strong>[${cartItem.product.specifications?join(", ")}]</strong>
									[/#if]
									[#if !cartItem.isMarketable]
										<strong>[${message("shop.cart.notMarketable")}]</strong>
									[/#if]
									[#if cartItem.isLowStock]
										<strong>[${message("shop.cart.lowStock")}]</strong>
									[/#if]
								</td>
								<td class="nbr">
									<a href = "javascript:;" data-tag="minus">-</a>
										<span data-tag="count">${cartItem.quantity}</span>
									<a href = "javascript:;" data-tag="plus">+</a>
								</td>
								<td>
									<span>${currency(cartItem.price, true)}</span>
								</td>
								<td>
									<span>0%</span>
								</td>
								<td>
									<span>￥0</span>
								</td>
								<td>
									<span data-tag="priceAll">${currency(cartItem.subtotal, true)}</span>
								</td>
								<td>保税区发货</td>
								<td class="br">
									<a herf = "javascript:;" data-tag="del">${message("shop.cart.delete")}</a>
								</td>
							</tr>
						[/#list]
					</table>
					<P class="total">
						总价/<span>￥</span><span data-tag="totalPrice">0.00</span>
					</P>
					<button class="settlement" type  = "button" data-tag="submit" >立即结算</button>
				</form>
			[#else]
				<!-- <div class="pop">
					<h5>买德好</h5>
					<p>加入购物车成功！</p>
				</div> -->
				
				<div class="null-cart"><img src="${base}/resources/shop/${theme}/images_mdh/shop-cart.png" height="100" width="100">
					<P>您的购物车什么都没有，<br>
					<a href="${base}">赶快去商城采购吧！</a>
					</P>
				</div>
			[/#if]
		</div>
		[#include "/shop/${theme}/include/footer_mdh.ftl" /]
    </body>
</html>
[/#escape]