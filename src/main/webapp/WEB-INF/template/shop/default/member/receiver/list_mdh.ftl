[#escape x as x?html]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>${message("shop.member.receiver.list")}[#if showPowered] - Powered By JSHOP[/#if]</title>
<meta name="author" content="JSHOP Team" />
<meta name="copyright" content="JSHOP" />

	<link href="favicon.ico" rel="icon" type="image/x-icon" />
	<link type="text/css" rel="stylesheet" href="${base}/resources/shop/${theme}/css_mdh/main.css" />
	<link type="text/css" rel="stylesheet" href="${base}/resources/shop/${theme}/css_mdh/personal.css" />
	<script src = "${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
	<script src = "${base}/resources/shop/${theme}/js_mdh/third/jquery.province.js"></script>
	<script src = "${base}/resources/shop/${theme}/js_mdh/third/provincesdata.js"></script>
	
	<script src = "${base}/resources/shop/${theme}/js_mdh/main/views/personal.js"></script>
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
	[#assign current = "receiverList" /]
	[#include "/shop/${theme}/include/header_mdh.ftl" /]
	
	<!-- 主体内容开始 -->
	<div class="personal clearfix">
		<!-- 个人中心左侧导航开始 -->
		<ul class="personal-nav fl">
			<li><a href="./personal.html">我的信息</a></li>
			<li class="nav"><a href="javascript:;">我的订单</a>
				<div class="innav dn">
					<a href="./personal-item.html">现有订单</a>
					<a href="javascript:;">退货</a>
					<a href="javascript:;">换货维修</a>
				</div>
			</li>
			<li><a href="./personal-collect.html">我的收藏</a></li>
			<li><a class="current" href="javascript:;">收件地址</a></li>
			<li><a href="./personal-security.html">安全中心</a></li>
		</ul>
			
			<!-- 收件地址开始 -->
		<div class="personal-address fr">
			
			<div class="buy">
			
				<div class="buy-address" data-tag="butAddress" >
					<div class = "scroll-address">
						<h5>收货地址</h5>
		  				<ul class="clearfix">
			  				[#list page.content as receiver]
			  					<li class="fl selected">
			  						<p class="information">
										<input type="hidden" name="id" value="${receiver.id}" />
										${receiver.consignee}
			  							<span class="fr" >${receiver.phone}</span>
			  						</P>
			  						<strong>${receiver.cardId}</strong>
			  						<div class="address">
			  							<span><b>${receiver.areaName}</b></span>
			  							<p>${receiver.address}</p>
			  						</div>
			  						<p class="about">
			  							<a href="javascript:;" class = "default fl" data-address="default">默认地址:${receiver.isDefault?string(message("shop.member.true"), message("shop.member.false"))}</a>
			  							<a class="editor fl" href="javascript:;" data-address="edit" >编辑</a>
			  							<a class="last fr" href="javascript:;" data-address="delete">删除</a>
			  							
			  							<a class="editor fl" href="edit.jhtml?id=${receiver.id}" data-address="edit" >[${message("shop.member.action.edit")}]</a>
										<a href="javascript:;" class="delete">[${message("shop.member.action.delete")}]</a>
			  						</p>
			  					</li>
							[/#list]
						  	[#if !page.content?has_content]
								<p>${message("shop.member.noResult")}</p>
							[/#if]
							<li class="fl">
								<button type="button" data-tag="title">
								新增收货地址</button>
							</li>
		  				</ul>
	       			</div>
	       		</div>
       		
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
			</div>
			
		</div>
		
	</div>
	[#include "/shop/${theme}/include/footer_mdh.ftl" /]
</body>
</html>
[/#escape]