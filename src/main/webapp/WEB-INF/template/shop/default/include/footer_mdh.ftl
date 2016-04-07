[#escape x as x?html]
<div class="footer">
	<script type="text/javascript">
	$().ready(function() {
	
		var $headerName = $("#headerName");
		
		var username = getCookie("username");
		var nickname = getCookie("nickname") || '';
		var mobile = getCookie("mobile") || '';
		$headerName.text(mobile).show();
		if ($.trim(nickname) || $.trim(mobile)) {
			var userName = nickname || mobile;
			$headerName.text(userName);
			$("#login_out").removeClass().addClass('dn');
		} else {
			$("#login_in").removeClass().addClass('dn');
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

	<div class="fix">
		<ul class = "quick_links_panel">
			<li>
				<a href="javascript:;" class="one ico"><i></i></a>
				<div class="infix mp_tooltip" id="login_out">
					<a href="${base}/login.jhtml">${message("shop.header.login")}</a>
					<a href="${base}/register.jhtml">${message("shop.header.register")}</a>
				</div>
				<div class="logged mp_tooltip" id="login_in">
					<h6><span id="headerName" class="headerName">&nbsp;</span></h6>
					<a href="javascript:;">个人中心</a>
					<a href="javascript:;">账号安全</a>
					<a href="javascript:;">我的订单</a>
					<span><a href="${base}/logout.jhtml">[${message("shop.header.logout")}]</a></span>
				</div>
			</li>
			<li data-cart="shoppingcart">
				<a href="./shoppingcart.html" class="two ico"><i></i></a>
				<div class="shopping-list tooltip dn">
					<p>来都来了，不买点德国货吗~</p>
					<a href="javascript:;" class = "no"><i></i>查看我的购物车</a>
				</div>
				<div class="shopping-list2 tooltip">
					<div class="warp clearfix" data-product = "123456">
						<img class="fl" src="../../images_mdh/content3.png" height="60" width="60">
						<span class="fl" data-right="minus">-</span>
						<strong class="fl" data-right="num">1</strong>
						<span class="fl" data-right="plus">+</span>
						<p class="fr" data-right="priceAll">2365.00</p>
						<b data-right="delete">x</b>
					</div>
					<a href="./shoppingcart.html"><i></i>查看我的购物车</a>
				</div>
			</li>
			<li>
				<a href="javascript:;" class="three ico"><i></i></a>
				<div class="tell mp_tooltip" >
					846546848465
				</div>
			</li>
			<li>
				<a href="javascript:;" class="fore ico"><i></i></a>
				<div class="images wx_tooltip">
					<img src="${base}/resources/shop/${theme}/images_mdh/wechat.png" height="190" width="190">
				</div>
			</li>
			<li>
				<a href="javascript:;" class="five ico"><i></i></a>
			</li>
		</ul>
	</div>
	
	
	<script>
		$(function () {
			// 购物车加减产品事件
		  function minusPlusShopping(data) {

		    console.log("post: ");
		    console.log(data);

		    $.ajax({
		      url: '../../test/minusplus.json',
		      type: "POST",
		      data: data,
		      dataType: "json",
		      cache: false,
		      success: function(message) {
		      	console.log(message)
		      }
		    });
		  };

    // 加
    $('[data-right="plus"]').bind('click', function (e) {
      var times = 100;
      var $number = $(this).siblings('[data-right="num"]');
      var $priceAll = $(this).siblings('[data-right="priceAll"]');
      var num = parseInt($number.html());
      var priceAll = parseInt($priceAll.html())*times;
      var price = priceAll/num;
      if (num > 0 ) {
        $number.html(++num);
        $priceAll.html(((priceAll+price)/times).toFixed(2));
        // ajax 收集数据
        data = {
        	productId: $(this).parents('.warp').attr('data-product'),
        	num: num
        }
        minusPlusShopping(data);  // ajax
      }
    });

    // 减
    $('[data-right="minus"]').bind('click', function () {
      var times = 100;
      var $number = $(this).siblings('[data-right="num"]');
      var $priceAll = $(this).siblings('[data-right="priceAll"]');
      var num = parseInt($number.html());
      var priceAll = parseInt($priceAll.html())*times;
      var price = priceAll/num;
      if (num >= 2 ) {
        $number.html(--num);
        $priceAll.html(((priceAll-price)/times).toFixed(2));

         // ajax 收集数据
        data = {
        	productId: $(this).parents('.warp').attr('data-product'),
        	num: num
        }
        minusPlusShopping(data);  // ajax
      }
    });

    $('[data-right="delete"]').bind('click', function () {
    	var target = $(this).parents('.warp');
		    var productId = target.attr('data-product');
		    var checked = target.find('[data-tag="select"]').is(':checked');
		    var self = this;
		    var data = {
		    	productId: productId
		    };

			    console.log("post: ");
			    console.log(data);

			    $.ajax({
			      url: "../../test/test.json",
			      type: "POST",
			      data: data,
			      dataType: "json",
			      cache: false,
			      success: function(message) {

			        console.log("message: ");
			        console.log(message);

			        if (message.type == "success") {
			          target.remove();
			        }
			      }
			    });
        });


			});
		</script>
[/#escape]