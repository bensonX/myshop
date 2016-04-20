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
		<link rel="stylesheet" type="text/css" href="${base}/resources/shop/${theme}/css_mdh/common.css" />
		<link type="text/css" rel="stylesheet" href="${base}/resources/shop/${theme}/css_mdh/personal.css" />
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
	
		<!-- 主体内容开始 -->
		<div class="personal clearfix">
			<!-- 左侧 -->
			[#assign indexLeft=4]
			[#include "/shop/${theme}/member/index_left.ftl" /]
			<!-- end -->
			<!-- 收件地址开始 -->
			<div class="personal-address fr dn " data-tag="butAddress">
				<div class = "scroll-address">
				<h5>收货地址</h5>
  				<ul class="clearfix" data-address="items">
  					[#if member.receivers?has_content]
	  					[#list member.receivers as receiver]
		  					<li class="fl [#if receiver == defaultReceiver]selected[/#if]" data-id="${receiver.id}">
		  						<p class="information">${receiver.consignee}
		  							<span class="fr" >${receiver.phone}</span>
		  						</p>
		  						<strong>${receiver.cardId}</strong>
		  						<div class="address">
		  							<span>${receiver.areaName}</span>
		  							<p>${receiver.address}</p>
		  						</div>
		  						<p class="about">
		  							<a href="javascript:;" class = "default" data-address="default">默认地址</a>
		  							<a class="editor" href="javascript:;" data-address="edit" >编辑</a>
		  							<a href="javascript:;" data-address="delete">删除</a>
		  						</p>
		  					</li>
  						[/#list]		
	  				[/#if]
	        		<li class="fl">
	        			<button type="button" data-tag="addAddress">新增收货地址</button>
	        		</li>
  				</ul>
       	      </div>
				<div class="add" data-tag="addressForm">
					<h6 data-tag="title">新增地址信息</h6>
					<div>
						<div class="name">
							<label class="din" for="usename">收件人姓名</label>
							<input type="text" id="usename" placeholder="请输入与身份证一致的姓名" data-tag = "userName" />
							<span>5-150个字符，一个汉字为两个字符</span>
						</div>
						<div class="city">
							<label class="din" for="province_id">省/市</label>
							<select id="selProvance" data-tag="province" >
   			 				</select>
    						<select id="selCity" data-tag="city" disabled="disabled">
    						</select>
    						<select id="selArea" data-tag="town" disabled="disabled">
   				 			</select>
							<span>请选择区域</span>
						</div>
						<div class="place">
							<label class=din for="place">详细地址</label>
							<input type="text" id="place" data-tag = "address" placeholder="请输入详细的收货地址" />
						</div>
						<div class="number">
							<label class="din" for="number">身份证号</label>
							<input type="text" id="number" data-tag="idCard" placeholder="海关清关所需，请填入18位身份证号码" />
							<span></span>
						</div>
						<div class="mobile">
							<label class="din" for="mobile">手机号码</label>
							<input id="mobile" type="text" data-tag="mobile" placeholder="请输入您的手机号码" />
							<span></span>
						</div>
						<button type="button" data-tag="addressSubmit">新增</button>
					</div>
				</div>
			</div>
		</div>
	
	[#include "/shop/${theme}/include/footer_mdh.ftl" /]
    </body>
</html>
[/#escape]