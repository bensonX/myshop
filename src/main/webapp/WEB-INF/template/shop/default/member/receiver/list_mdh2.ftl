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
		<script src="${base}/resources/shop/${theme}/js_mdh/main/views/buy.js"></script>
		<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
		 
   	 <script>
	     // 地址json
	      $(function () {
	        /**
	         * 地址验证和提交
	         */
	        addressValidation({
	          urlAddAddress: '${base}/order/save_receiver.jhtml', // 添加
	          addAddressData: function () {
	            return {
	            	'areaId':$('[data-tag="town"]').attr('town') || $('[data-tag="city"]').attr('city') || $('[data-tag="province"]').attr('province'),
	            	'consignee':$('[data-tag="userName"]').val(),
	            	'address':$('[data-tag="address"]').val(),
	            	'phone':$('[data-tag="mobile"]').val(),
	            	'cardId':$('[data-tag="idCard"]').val(),
	            	'zipCode':'0',
	            	'isDefault': $('[data-tag="isdefault"]').is(':checked')
	            };
	          },
			  urlEditPost: '${base}/member/receiver/info.jhtml',
	          urlEditAddress: '${base}/order/update.jhtml', // 编辑
	          editAddressData: function () {
	            return {
				  id: $('[data-tag="addressForm"]').attr('data-id'),
	              'areaId':$('[data-tag="town"]').attr('town') || $('[data-tag="city"]').attr('city') || $('[data-tag="province"]').attr('province'),
	            	'consignee':$('[data-tag="userName"]').val(),
	            	'address':$('[data-tag="address"]').val(),
	            	'phone':$('[data-tag="mobile"]').val(),
	            	'cardId':$('[data-tag="idCard"]').val(),
	            	'zipCode':'0',
	            	'isDefault': $('[data-tag="isdefault"]').is(':checked')
	            };
	          },
	          urlDeleteAddressPost: '${base}/member/receiver/delete.jhtml',   // 删除地址
	          urlDefaultAddressPost: '${base}/member/receiver/updateDefault.jhtml',  // 修改默认地址
	          urlSubmitPost: '${base}/order/create.jhtml',  // 提交地址
          	  urlPayment: '${base}/order/payment.jhtml'// 跳转地址
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
			[#assign indexLeft=4]
		[#include "/shop/${theme}/member/index_left.ftl" /]
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
			<div class="isdefault">
				<input id="isdefault" type="checkbox" data-tag="isdefault" >
				<label for="isdefault">默认地址</label>
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
	        </div>
		</div>
	</div>
		[#include "/shop/${theme}/include/footer_mdh.ftl" /]
    </body>
</html>
[/#escape]