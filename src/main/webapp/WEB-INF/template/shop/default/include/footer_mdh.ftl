[#escape x as x?html]
<!-- 底部开始 -->
<div class="footer">
	<div id = "footer">
		<ul class="clearfix features">
  		  <li>
  		    <a class="one" href="javascript:;" target="blank">德国直采</a>
  		  </li>
  		  <li>
  		    <a class="two" href="javascript:;" target="blank">价格更优</a>
  		  </li>
  		  <li>
  		    <a class="three" href="javascript:;" target="blank">极速体验</a>
  		  </li>
  		  <li>
  		    <a class="fore" href="javascript:;" target="blank">金牌服务</a>
  		  </li>
  		</ul>
		<ol class="clearfix">
			<li>
				<h4>买德好保障</h4>
				<a href="">自营正品</a>
				<a href="">海外直邮</a>
				<a href="">无忧退货</a>
			</li>
			<li>
				<h4>新手指南</h4>
				<a href="">购物流程</a>
				<a href="">支付方式</a>
				<a href="">通关关税</a>
				<a href="">常见问题</a>
			</li>
			<li>
				<h4>售后服务</h4>
				<a href="">退货政策</a>
				<a href="">退货流程</a>
				<a href="">退款说明</a>
				<a href="">联系客服</a>
			</li>
			<li>
				<h4>物流配送</h4>
				<a href="">配送方式</a>
				<a href="">运费标准</a>
				<a href="">通关关税</a>
				<a href="">物流跟踪</a>
			</li>
			<li>
				<h4>关于我们</h4>
				<a href="">网站简介</a>
				<a href="">联系我们</a>
				<a href="">招商合作</a>
				<a href="">销售联盟</a>
			</li>
			<li class="last">
				<a href="javascript:;" target="blank">
					<img src="${base}/resources/shop/${theme}//images_mdh/footer.png" height="42" width="100">
				</a>
			</li>
		</ol>
		<div class="copy">
			<P>增值电信业务经营许可证：沪B2-20160101-3 买德好公司版权所有©2015-2016　　　　　400-666-66666
				<span>
					<a href=""></a>
					<a href="" class = "last"></a>
				</span>
			</P>
		</div>
	</div>
</div>
	
<!-- 侧边栏固定区开始 -->
<div class = "fix" data-side="main">								
	<ul data-side="isShow">
		<li data-side="li">
			<a href="javascript:;" class="one ico" ><i></i></a>
			<div class="infix" data-side="showHide" id="login_out">
				<a href="${base}/login.jhtml">${message("shop.header.login")}</a>
				<a href="${base}/register.jhtml">${message("shop.header.register")}</a>
			</div>
			<div class="logged" data-side="showHide" id="login_in">
				<h6><span id="headerName" class="headerName">&nbsp;</span></h6>
					[@navigation_list position = "top"]
						[#list navigations as navigation]
							<a href="${base}${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if] class="logged-news" >${navigation.name}</a>
						[/#list]
					[/@navigation_list]
					<span><a href="${base}/logout.jhtml">[${message("shop.header.logout")}]</a></span>
			</div>
		</li>
		<li>
			<a href="javascript:;" class="two ico" data-side="cart" data-isshow="1" id="headerCart" >
				<i></i>
				<em ></em>
			</a>	
			<div style = "position: relative">
				<div class="shopping-list tooltip" data-side="noCart">
					<p>来都来了，不买点德国货吗~</p>
					<a href="${base}/cart/list.jhtml" class = "no"><i></i>查看我的购物车</a>
				</div>
				<div class="shopping-list2 tooltip" data-side="isCart">
					<div>
						<div class="warp clearfix" data-product = "123456">
							<img class="fl" src="${base}/resources/shop/${theme}/images_mdh/content3.png" height="60" width="60">
							<span class="fl" data-right="minus">-</span>
							<strong class="fl" data-right="num">1</strong>
							<span class="fl" data-right="plus">+</span>
							<p class="fr" data-right="priceAll">2365.00</p>
							<b data-right="delete">x</b>
						</div>
					</div>
					<a href="${base}/cart/list.jhtml"><i></i>查看我的购物车</a>
				</div>
			</div>
		</li>
		<li data-side="li">
			<a href="javascript:;" class="three ico" ><i></i></a>
			<div class="tell" data-side="showHide">			
				${setting.phone}
			</div>
		</li>
		<li data-side="li">
			<a href="javascript:;" class="fore ico" ><i></i></a>
			<div class="images" data-side="showHide">
				<img src="${base}/resources/shop/${theme}/images_mdh/wechat.png" height="190" width="190">
			</div>
		</li>
		<li>
			<a href="javascript:;" id = "goTop" class="five ico"><i></i></a>
		</li>
	</ul>
</div>
<script  src = "${base}/resources/shop/${theme}/js_mdh/main/views/headerfooter.js"></script>
[/#escape]