[#escape x as x?html]
<!-- 底部开始 -->
<div class="footer">
	<div id = "footer">
		<ul class="clearfix features">
  		  <li>
  		    <a class="one" href="javascript:;" target="_blank">德国直采</a>
  		  </li>
  		  <li>
  		    <a class="two" href="javascript:;" target="_blank">价格更优</a>
  		  </li>
  		  <li>
  		    <a class="three" href="javascript:;" target="_blank">极速体验</a>
  		  </li>
  		  <li>
  		    <a class="fore" href="javascript:;" target="_blank">金牌服务</a>
  		  </li>
  		</ul>
		<ol class="clearfix">
			<li>
				<h4>买德好保障</h4>
				<a href="/">自营正品</a>
				<a href="/">海外直邮</a>
				<a href="/">无忧退货</a>
			</li>
			<li>
				<h4>新手指南</h4>
				<a href="/">购物流程</a>
				<a href="/">支付方式</a>
				<a href="/">通关关税</a>
				<a href="/">常见问题</a>
			</li>
			<li>
				<h4>售后服务</h4>
				<a href="/">退货政策</a>
				<a href="/">退货流程</a>
				<a href="/">退款说明</a>
				<a href="/">联系客服</a>
			</li>
			<li>
				<h4>物流配送</h4>
				<a href="/">配送方式</a>
				<a href="/">运费标准</a>
				<a href="/">通关关税</a>
				<a href="/">物流跟踪</a>
			</li>
			<li>
				<h4>关于我们</h4>
				<a href="/">网站简介</a>
				<a href="/">联系我们</a>
				<a href="/">招商合作</a>
				<a href="/">销售联盟</a>
			</li>
			<li class="last">
				<a href="javascript:;" target="blank">
					<img src="${base}/resources/shop/${theme}/images_mdh/footer.png" height="42" width="100">
				</a>
			</li>
		</ol>
		<div class="copy">
			<P>增值电信业务经营许可证：沪B2-20160101-3 买德好公司版权所有©2015-2016　　　　　400-666-66666
				<span>
					<a href="/"></a>
					<a href="/" class = "last"></a>
				</span>
			</P>			
			<div class="scan dn">
        		<img src="${base}/resources/shop/${theme}/images_mdh/wechat.png" height="95" width="100">
        	</div>
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
				<i class = "right"></i>
        <div class = "op"></div>
			</div>
			<div class="logged" data-side="showHide" id="login_in">
				<h6><span id="headerName" class="headerName">&nbsp;</span></h6>
					[@navigation_list position = "top"]
						[#list navigations as navigation]
							<a href="${base}${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if] class="logged-news" >${navigation.name}</a>
						[/#list]
					[/@navigation_list]
					<span><a href="${base}/logout.jhtml">[${message("shop.header.logout")}]</a></span>
					<i class = "right"></i>
        	<div class = "op"></div>
			</div>
		</li>
		<li data-side="li" data-sideGet="true" >
      <a href="${base}/cart/list.jhtml" class="two ico" data-side="cart" data-isshow="1" id="headerCart">
        <i></i>
        <em></em>
      </a>
      <div class="shopping-list tooltip" data-side="showHide" data-side="isCart" data-footer="cart">
      	<form action = "${base}/order/checkout.jhtml" method = "post" data-data="form" >
        <table class="caption">
          <thead>
             <tr>
                <th class = "first" >
                  <input type="checkbox" data-tag="selectAll" disabled="true" checked />
                </th>
                <th class = "img" ><span>全选</span></th>
                <th class = "text" ><a href = "javascript:;" >查看全部</a></th>
                <th class = "last" ></th>
              </tr>
          </thead>
          <tbody data-cart="tbody">
            <tr class = "noCart">
              <td colspan="4">
                <p>您的购物车暂时没有商品</p>
                <p>快去买德国的好东西吧～</p>
              </td>
            </tr>
          </tbody>
        </table>
        <div class = "button clearfix">
          <div class = "unit fl">
            <span>已选</span>
            <span data-tag="totalNumber">0</span>
            <span>件</span>
          </div>
          <div class = "total-prive fl">
            <span data-tag="totalPrice">￥0.00</span>
          </div>
          <div class = "submit fl">
            <button type = "button" data-tag="submit" >去&nbsp;结&nbsp;算</button>
          </div>
        </div>
        </form>
        <i class = "right"></i>
        <div class = "op"></div>
      </div>
    </li>
		<li data-side="li">
			<a href="javascript:;" class="three ico" ><i></i></a>
			<div class="tell" data-side="showHide">			
				${setting.phone}
				<i class = "right"></i>
        <div class = "op"></div>
			</div>
		</li>
		<li data-side="li">
			<a href="javascript:;" class="fore ico" ><i></i></a>
			<div class="images" data-side="showHide">
				<img src="${base}/resources/shop/${theme}/images_mdh/wechat.png" height="190" width="190">
				<i class = "right"></i>
        <div class = "op"></div>
			</div>
		</li>
		<li>
			<a href="javascript:;" id = "goTop" class="five ico"><i></i></a>
		</li>
	</ul>
</div>
<script  src = "${base}/resources/shop/${theme}/js_mdh/main/views/headerfooter.js"></script>
<script src = "${base}/resources/shop/${theme}/js_mdh/main/views/cart.js"></script>
<script>
;$(document).ready(function(){
    // 用户信息
    var $headerName = $("#headerName");
    var $topName = $("#topName");

    var $goodsSearchForm = $("#goodsSearchForm");
    var $keyword = $("#goodsSearchForm input");
    var defaultKeyword = $keyword.attr('data-search');

    if ($.getUserName()) {
      $headerName.text($.getUserName());
      $topName.text($.getUserName());
      $("#login_in").show();
      $("#login_out").remove();
      $("#noLogin").remove();
      $("#isLogin").show();
    } else {
      $("#login_in").remove();
      $("#login_out").show();
      $("#isLogin").remove();
      $("#noLogin").show();
    }

    // 搜索
    $keyword.focus(function() {
      if ($.trim($keyword.val()) == defaultKeyword) {
        $keyword.val("");
      }
    }); 
    $keyword.blur(function() {
      if ($.trim($keyword.val()) == "") {
        $keyword.val(defaultKeyword);
      }
    });
    $goodsSearchForm.submit(function() {
      if ($.trim($keyword.val()) == "" || $keyword.val() == defaultKeyword) {
        return false;
      }
    });

    Side();
    
    /**
	 * 选，加，减，删，提交等功能
	 * cart
	 */
	SideCart({
		el: '[data-footer="cart"]',
		urlMinusPlusPost: '${base}/cart/edit.jhtml',
		minusPlusData: {},
	
		urlDeletePost: '${base}/cart/delete.jhtml',
		deleteData: {},
	
		disabled: 1   // 1选中禁止，0, 不选择不禁止
	});
});
</script>
[/#escape]