[#escape x as x?html]
<script type="text/javascript">
$().ready(function() {

	var $headerName = $("#headerName");
	var $headerLogin = $("#headerLogin");
	var $headerRegister = $("#headerRegister");
	var $headerLogout = $("#headerLogout");
	var $goodsSearchForm = $("#goodsSearchForm");
	var $keyword = $("#goodsSearchForm input");
	var defaultKeyword = "${message("shop.header.keyword")}";
	
	var username = getCookie("username");
	var nickname = getCookie("nickname");
	var mobile = getCookie("mobile");
	//alert("初始化。。。");
	//alert(username+"cookie"+nickname+"="+mobile);
	
	if ($.trim(nickname) != "") {
		$headerName.text(nickname).show();
		$headerLogout.show();
	} else if ($.trim(username) != "") {
		$headerName.text(username).show();
		$headerLogout.show();
	} else {
		$headerLogin.show();
		$headerRegister.show();
	}
	
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

});
</script>

<div class="header">
    [#--
	<div class="top">
		<div class="topNav">
			<ul class="left">
				<li>
					<span>${message("shop.header.welcome", setting.siteName)}</span>
					<span id="headerName" class="headerName">&nbsp;</span>
				</li>
				<li id="headerLogin" class="headerLogin">
					<a href="${base}/login.jhtml">${message("shop.header.login")}</a>|
				</li>
				<li id="headerRegister" class="headerRegister">
					<a href="${base}/register.jhtml">${message("shop.header.register")}</a>
				</li>
				<li id="headerLogout" class="headerLogout">
					<a href="${base}/logout.jhtml">[${message("shop.header.logout")}]</a>
				</li>
			</ul>
			<ul class="right">
				[@navigation_list position = "top"]
					[#list navigations as navigation]
						<li>
							<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>|
						</li>
					[/#list]
				[/@navigation_list]
				<li id="headerCart" class="headerCart">
					<a href="${base}/cart/list.jhtml">${message("shop.header.cart")}</a>
					(<em></em>)
				</li>
			</ul>
		</div>
	</div>
	--]
[#--
	<div class="container">
		<div class="row">
			<div class="span3">
				<a href="${base}/">
					<img src="${setting.logo}" alt="${setting.siteName}" />
				</a>
			</div>
			<div class="span6">
				<div class="search">
					<form id="goodsSearchForm" action="${base}/goods/search.jhtml" method="get">
						<input name="keyword" class="keyword" value="${goodsKeyword!message("shop.header.keyword")}" autocomplete="off" x-webkit-speech="x-webkit-speech" x-webkit-grammar="builtin:search" maxlength="30" />
						<button type="submit">&nbsp;</button>
					</form>
				</div>
				<div class="hotSearch">
					[#if setting.hotSearches?has_content]
						${message("shop.header.hotSearch")}:
						[#list setting.hotSearches as hotSearch]
							<a href="${base}/goods/search.jhtml?keyword=${hotSearch?url}">${hotSearch}</a>
						[/#list]
					[/#if]
				</div>
			</div>
			<div class="span3">
				<div class="phone">
					<em>${message("shop.header.phone")}</em>
					${setting.phone}
				</div>
			</div>
		</div>
		<div class="row">
			<div class="span12">
				<dl class="mainNav">
					<dt>
						<a href="${base}/product_category.jhtml">${message("shop.header.allProductCategory")}</a>
					</dt>
					[@navigation_list position = "middle"]
						[#list navigations as navigation]
							<dd[#if navigation.url = url] class="current"[/#if]>
								<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if]>${navigation.name}</a>
							</dd>
						[/#list]
					[/@navigation_list]
				</dl>
			</div>
		</div>
	</div>
--]
	
</div>




		<!-- 头部开始 -->
		<div id = "header">
			<a href = "">
				<h1>买德好</h1>
			</a>
			<div class="search">
				<form action="${base}/goods/search.jhtml" method="get">
					<input type="text" placeholder="${goodsKeyword!message("shop.header.keyword")}....."  name="keyword" class="keyword" />
					<button type="submit">&nbsp;</button>
				</form>
			</div>
			<!-- 导航开始 -->
			<div class="nav">
				<ul class="clearfix">
					<li>
						<a href="${base}">${message("shop.header.allHome")}</a>
					</li>
					<li>
						<a href="${base}/product_category.jhtml">${message("shop.header.allProductCategory")}</a>
						<div class="innav">
							<ol class="clearfix">
							[@product_category_root_list count = 20]
							[#list productCategories as productCategory]
								<li>
									<a href="${base}${productCategory.path}">
										<h2>${productCategory.name}<br></h2>
									</a>
									[@product_category_children_list productCategoryId = productCategory.id recursive = false count = 20]
									[#list productCategories as productCategory]
										<a href="${base}${productCategory.path}">
											${productCategory.name}<br>
										</a>
									[/#list]
									[/@product_category_children_list]
								</li>
							[/#list]
							[/@product_category_root_list]
							</ol>
						</div>
					</li>
				</ul>
			</div>			
		</div id = "header">
[/#escape]