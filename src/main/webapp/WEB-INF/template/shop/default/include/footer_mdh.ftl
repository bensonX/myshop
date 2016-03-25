[#escape x as x?html]
<div class="footer">
	[#--
	<div class="service clearfix">
		<dl>
			<dt class="icon1">新手指南</dt>
			<dd>
				<a href="#">购物流程</a>
			</dd>
			<dd>
				<a href="#">会员注册</a>
			</dd>
			<dd>
				<a href="#">购买宝贝</a>
			</dd>
			<dd>
				<a href="#">支付货款</a>
			</dd>
			<dd>
				<a href="#">用户协议</a>
			</dd>
		</dl>
		<dl>
			<dt class="icon2">特色服务</dt>
			<dd>
				<a href="#">购物流程</a>
			</dd>
			<dd>
				<a href="#">会员注册</a>
			</dd>
			<dd>
				<a href="#">购买宝贝</a>
			</dd>
			<dd>
				<a href="#">支付货款</a>
			</dd>
			<dd>
				<a href="#">用户协议</a>
			</dd>
		</dl>
		<dl>
			<dt class="icon3">支付方式</dt>
			<dd>
				<a href="#">购物流程</a>
			</dd>
			<dd>
				<a href="#">会员注册</a>
			</dd>
			<dd>
				<a href="#">购买宝贝</a>
			</dd>
			<dd>
				<a href="#">支付货款</a>
			</dd>
			<dd>
				<a href="#">用户协议</a>
			</dd>
		</dl>
		<dl>
			<dt class="icon4">配送方式</dt>
			<dd>
				<a href="#">购物流程</a>
			</dd>
			<dd>
				<a href="#">会员注册</a>
			</dd>
			<dd>
				<a href="#">购买宝贝</a>
			</dd>
			<dd>
				<a href="#">支付货款</a>
			</dd>
			<dd>
				<a href="#">用户协议</a>
			</dd>
		</dl>
		<div class="qrCode">
			<img src="${base}/resources/shop/${theme}/images/qr_code.gif" alt="${message("shop.footer.weixin")}" />
			${message("shop.footer.weixin")}
		</div>
	</div>
	--]
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
			<li>
				<a href="">
					<img src="${base}/resources/shop/${theme}//images_mdh/footer.png" height="56" width="115">
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
	<ul class="fix">
		<li class="one">
			<div class="infix">
				<a href="${base}/login.jhtml">${message("shop.header.login")}</a>
				<a href="${base}/register.jhtml">${message("shop.header.register")}</a>
			</div>
		</li>
		<li class="two"></li>
		<li class="three"></li>
		<li class="fore"></li>
		<li class="five"></li>
	</ul>
</div>
[/#escape]