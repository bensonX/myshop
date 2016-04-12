

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
		<script src="${base}/resources/shop/${theme}/js_mdh/main/views/buy.js"></script>
		<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
		 
   	 <script>
	     // 地址json
	    
	      var addressJson =  ${receivers![]};
	      var defaultReceiverID=${defaultReceiver.id!0};// 默认地址
	      $(function () {
	        /**
	         * 地址验证和提交
	         */
	        addressValidation({
	          urlAddAddress: '../../test/address.json', // 添加
	          addAddressData: function () {
	            return {
	              userName: $('[data-tag="userName"]').val(),
	              province: $('[data-tag="province"]').find(':selected').html(),
	              city: $('[data-tag="city"]').find(':selected').html(),
	              address: $('[data-tag="address"]').val(),
	              idCard: $('[data-tag="idCard"]').val(),
	              mobile: $('[data-tag="mobile"]').val()
	            };
	          },
	
	          urlEditAddress: '../../test/address.json', // 编辑
	          editAddressData: function () {
	            return {
	              id: $('[data-tag="addressForm"]').attr('data-id'),
	              userName: $('[data-tag="userName"]').val(),
	              province: $('[data-tag="province"]').find(':selected').html(),
	              city: $('[data-tag="city"]').find(':selected').html(),
	              address: $('[data-tag="address"]').val(),
	              idCard: $('[data-tag="idCard"]').val(),
	              mobile: $('[data-tag="mobile"]').val()
	            };
	          },
	
	          urlDeleteAddressPost: '${base}/member/receiver/delete.jhtml',   // 删除地址
	          urlDefaultAddressPost: '${base}' ,  // 默认地址
	          urlSubmitPost: '${base}/order/create.jhtml',  // 提交地址
          	  urlPayment: '${base}/order/payment.jhtml'   // 跳转地址
	
	        });
		  	/**
	         * 城市选择接口
	         */
	        selectCity.init({
	          province: '[data-tag="province"]',
	          city: '[data-tag="city"]',
	          town: '[data-tag="town"]',
	          urlPost: "${base}/common/area.jhtml"   //  获取数据地址
	        });
	      });
    </script>
	</head>
    <body>
		[#include "/shop/${theme}/include/header_mdh.ftl" /]
		<div class="buy">
			<div class="buyForm dn" data-tag="addressForm" >
    		<div class = "title clearfix" >
     			<span class = "fl" data-tag="title">新增地址</span>
      		<strong class = "fr" data-tag="popupClose">x</strong>
    		</div>
				<div class="username">
					<label for="username">收货人姓名</label>
					<input id="username" data-tag = "userName" type="text" placeholder="请输入与身份证一致的姓名">
				</div>
				<div class="city">
					<label for="city">省/市</label>
					<select class="provinciala" data-tag="province" province = "2">
            		<option>所在省</option>
        			</select>
 					<select class="provinciala" data-tag="city" disabled="disabled">
 				   		<option>所在市区</option>
 					</select>
		          <select class="citya" data-tag="town" disabled="disabled">
		              <option>所在城镇</option>
		          </select>
				</div>
				<div class="address">
					<label for="address">详细地址</label>
         			 <textarea id="address" data-tag = "address" placeholder="请输入详细地址"></textarea>
				</div>
				<div class="identity">
					<label for="identity">身份信息</label>
					<input id="identity" type="text" data-tag="idCard" placeholder="海关清关所需，请填入18位身份证号码">
				</div>
				<div class="mobile">
					<label for="mobile">手机号码</label>
					<input id="mobile" type="text" data-tag="mobile" placeholder="请输入收货的手机号码">
				</div>
       			<div class = "error hidden" data-tag="error">
         			 <i></i><span></span>
       			 </div>
				<div class="btn">
					<button type = "button" data-tag="addressSubmit">保存地址</button>
				</div>
			</div>
      <div class = "shielding-layer" data-tag="shieldingLayer"></div>
			<!-- 收货地址开始 -->
			<div class="buy-address dn" data-tag="butAddress" >
				<h5 class = "clearfix">收货地址<a herf = "javascript:;" data-tag="addAddress" class = "fr">添加</a></h5>
        <button class="left" type="button" data-tag="scrollLeft"></button>
        <button class="right" type="button" data-tag="scrollRight"></button>
        [#if order.isDelivery]
        <div class = "scroll-address" data-tag="scroll-address" >
			<ul class="clearfix" data-address="items">
  				[#if member.receivers?has_content]
  					[#list member.receivers as receiver]
	  					<li class="fl [#if receiver == defaultReceiver]selected[/#if]" data-id="${receiver.id}">
	  						<p class="information">${receiver.consignee}
	  							<span class="fr" >${receiver.phone}</span>
	  						</P>
	  						<strong>${receiver.cardId}</strong>
	  						<em>${receiver.areaName}<br>${receiver.address}</em>
	  						<p class="about">
	  							<a href="javascript:;" class = "default" data-address="default">默认地址</a>
	  							<a class="editor" href="javascript:;" data-address="edit" >编辑</a>
	  							<a href="javascript:;" data-address="delete">删除</a>
	  						</p>
	  					</li>
					[/#list]
					
  				[/#if]
			</ul>
			<!--
			[#if member.receivers?size > 5]
									<a href="javascript:;" id="otherReceiverButton" class="button">${message("shop.order.otherReceiver")}</a>
					[/#if]
					-->
        </div>
        [/#if]
			</div>
			<div class="details clearfix">
				<h5>订单详情</h5>
				<!-- <button class="fr"></button> -->
				<ul class="order">
					[#list order.orderItems as orderItem]
					<li class="clearfix first">
						<img class="fl" src="${orderItem.product.thumbnail!setting.defaultThumbnailProductImage}" alt="${orderItem.product.name}" height="95" width="95">
						<div class="goods fl">
							<a href="${orderItem.product.url}" title="${orderItem.product.name}" target="_blank">${abbreviate(orderItem.product.name, 50, "...")}</a>
							[#if orderItem.product.specifications?has_content]
								<span class="silver">[${orderItem.product.specifications?join(", ")}]</span>
							[/#if]
							[#if orderItem.type != "general"]
								<span class="red">[${message("Goods.Type." + orderItem.type)}]</span>
							[/#if]
						</div>
						<p class="fl">
							<strong>${orderItem.quantity}</strong>
							[#if orderItem.type == "general"]
								<strong>${currency(orderItem.price, true)}<strong>
							[#else]
								<strong>-<strong>
							[/#if]
							[#if orderItem.type == "general"]
								<strong>${currency(orderItem.subtotal, true)}<strong>
							[#else]
								<strong>-<strong>
							[/#if]
							<strong>税费￥10.00</strong>
							<strong>小计￥800.00</strong>
						</p>
					</li>
					[/#list]
				</ul>
			</div>
			<div class="note">
				<h5>备注</h5>
				<textarea data-tag="note" placeholder="您可在此写下订单备注，不得超过350字符"></textarea> 
			</div>
			<div class="settlement">
				<!-- <h5>激活代金劵
					<a href="javascript:;">代金劵使用方法</a>
				</h5>
				<ul class="clearfix">
					<li class="fl first">
						<strong>￥10</strong>
						<span>立减10元<br>剩余5天23小时</span>
						<em class="big">
							<em class="small"></em>
						</em>
					</li>
					<li class="fl">
						<strong>￥20</strong>
						<span>满一百减20元<br>剩余5天23小时</span>
						<em class="big">
							<em class="small dn"></em>
						</em>
					</li>
					<li class="fl">
						<strong>￥5</strong>
						<span>立减5元<br>剩余5天23小时</span>
						<em class="big">
							<em class="small dn"></em>
						</em>
					</li>
					<li class="fl grey">
						<strong>￥10</strong>
						<span>立减10元<br>剩余5天23小时</span>
						<em class="big">
							<em class="small dn"></em>
						</em>
					</li>
					<li class="fl grey">
						<strong>￥10</strong>
						<span>立减10元<br>剩余5天23小时</span>
						<em class="big">
							<em class="small dn"></em>
						</em>
					</li>
				</ul> -->
				<p>
				<!-- 	代金券减免：-10.00元<br> -->
					${message("Order.amount")}: <span>${currency(order.amount, true, true)}</span><br>
					<!-- 为您节省：10.00元 -->
				</p>
				<form class="buy-pay" action = "#" method = "post">
					[#if order.isDelivery]
						<input type="hidden" id="receiverId" name="receiverId"[#if defaultReceiver??] value="${defaultReceiver.id}"[/#if] />
						<!-- <input type = "hidden" value = "" name = "addressId" data-tag="inputAddressId" /> -->
					[/#if]
					[#if order.type == "general"]
						<input type="hidden" name="cartToken" value="${cartToken}" />
					[/#if]
          			<input type = "hidden" value = "not" name = "memo" data-tag="inputNote" maxlength="350" />
					<label for="buy">${message("Order.paymentMethod")}</label>
					<input id="buy" type="radio" checked="checked" name="paymentMethodId" value="1" />
					<img src="${base}/resources/shop/${theme}/images_mdh/icon/buy-pay-1.png" height="56" width="55">
					<input type="radio" name="paymentMethodId" value="2">
					<img src="${base}/resources/shop/${theme}/images_mdh/icon/buy-pay-2.png" height="56" width="56"><br />
					
					<input type="hidden" id="shippingMethod_${shippingMethod.id}" name="shippingMethodId" value="1" />
					<input type="hidden" id="code" name="code" maxlength="200" value="0" />
					<input type="hidden" id="invoiceTitle" name="invoiceTitle" class="text" value="${message("shop.order.defaultInvoiceTitle")}" maxlength="200" disabled="disabled" />
					<input type="hidden" id="balance" name="balance" class="balance" value="0" maxlength="16" onpaste="return false;" />
					<button type="button" data-tag="formSubmit">结算</button>
				</form>
			</div>
			<!-- <div class="pop">
				<h5>买德好</h5>
				<p>请选择收货地址</p>
			</div> -->
		</div>
		[#include "/shop/${theme}/include/footer_mdh.ftl" /]
    </body>
</html>
