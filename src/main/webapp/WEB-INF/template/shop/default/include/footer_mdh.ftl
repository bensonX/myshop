[#escape x as x?html]
<div class="footer">
	<script type="text/javascript">
	$().ready(function() {
	
		var $headerName = $("#headerName");
		
		var username = getCookie("username");
		var nickname = getCookie("nickname");
		var mobile = getCookie("mobile");
		//alert("初始化。。。");
		//alert(username+"=cookie="+nickname+"="+mobile);

		if ($.trim(nickname) != "") {
			$headerName.text(nickname).show();

			$("#login_in").removeClass().addClass("infix");
			$("#login_out").removeClass().addClass("infix dn");
		} else if ($.trim(mobile) != "") {
			$headerName.text(mobile).show();

			$("#login_in").removeClass().addClass("infix");
			$("#login_out").removeClass().addClass("infix dn");
		} else {
			$headerLogin.show();
			
			$headerRegister.show();
		}
	});
	</script>
	<!-- 底部开始 -->
	<div id = "footer">
		<ul class="clearfix">
			<li>
				<a class="one" href="">德国直采</a>
			</li>
			<li>
				<a class="two" href="">价格更优</a>
			</li>
			<li>
				<a class="three" href="">极速体验</a>
			</li>
			<li>
				<a class="fore" href="">金牌服务</a>
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
					<a href=""></a>
				</span>
			</P>
		</div>
		[#--
			<div class="bottom">
			<div class="bottomNav">
				<ul>
					[@navigation_list position = "bottom"]
						[#list navigations as navigation]
							<li>
								<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
								[#if navigation_has_next]|[/#if]
							</li>
						[/#list]
					[/@navigation_list]
				</ul>
			</div>
			<div class="info">
				<p>${setting.certtext}</p>
				<p>${message("shop.footer.copyright", setting.siteName)}</p>
				[@friend_link_list type="image" count = 8]
					<ul>
						[#list friendLinks as friendLink]
							<li>
								<a href="${friendLink.url}" target="_blank">
									<img src="${friendLink.logo}" alt="${friendLink.name}" />
								</a>
							</li>
						[/#list]
					</ul>
				[/@friend_link_list]
			</div>
		</div>
		[#include "/shop/${theme}/include/statistics.ftl" /]
		--]
	</div>
	
	<!-- 窗口固定区开始 -->
	<div class="fix">
		<div id="login_out" class="infix">
					<a href="${base}/login.jhtml">${message("shop.header.login")}</a>
					<a href="${base}/register.jhtml">${message("shop.header.register")}</a>
		</div>
		
		<div id="login_in" class="infix dn">
			<h6><span id="headerName" class="headerName">&nbsp;</span></h6>
			<a href="javascript:;">个人中心</a>
			<a href="javascript:;">账号安全</a>
			<a href="javascript:;">我的订单</a>
			<span><a href="${base}/logout.jhtml">[${message("shop.header.logout")}]</a></span>
		</div>
		
		<div class="tell">
			846546848465
		</div>
		<div class="images">
			<img src="${base}/resources/shop/${theme}/images_mdh/wechat.png" height="190" width="190">
		</div>
		<a href="javascript:;" class="one"></a>
		<a href="./shoppingcart.html" class="two"></a>
		<a href="javascript:;" class="three"></a>
		<a href="javascript:;" class="fore"></a>
		<a href="javascript:;" class="five"></a>
	</div>
	<div class="shopping-list ">
		<p>您的购物车暂时没有商品，快去买德国的好东西吧~</p>
		<a href="./shoppingcart.html">查看我的购物车</a>
	</div>
	<div class="shopping-list2 dn">
		<div class="warp clearfix">
			<img class="fl" src="../../images_mdh/content3.png" height="60" width="60">
			<span class="fl">-</span>
			<strong class="fl">1</strong>
			<span class="fl">+</span>
			<p class="fr">2365.00</p>
			<b>x</b>
		</div>
		<div class="warp clearfix">
			<img class="fl" src="../../images_mdh/content3.png" height="60" width="60">
			<span class="fl">-</span>
			<strong class="fl">1</strong>
			<span class="fl">+</span>
			<p class="fr">2365.00</p>
			<b>x</b>
		</div>
		<div class="warp clearfix">
			<img class="fl" src="../../images_mdh/content3.png" height="60" width="60">
			<span class="fl">-</span>
			<strong class="fl">1</strong>
			<span class="fl">+</span>
			<p class="fr">2365.00</p>
			<b>x</b>
		</div>
		<a href="./shoppingcart.html">查看我的购物车</a>
	</div>
</div>
[/#escape]