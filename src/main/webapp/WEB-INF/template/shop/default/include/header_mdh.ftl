[#escape x as x?html]
<link type="text/css" rel="stylesheet" href="${base}/resources/shop/${theme}/css_mdh/headerfooter.css" />
<!-- 头部开始 -->
<div id = "header">
	<div id = "top" class = "clearfix" >
		<div class = "fl"></div>
		<div class = "fr right">
			<div class = "is-login" id = "isLogin">
				<a href = "${base}/logout.jhtml" >[${message("shop.header.logout")}]</a>
				<i></i>
				<!--a href = "javascript:;" id = "addFavorite" >收藏网站</a>
				<i></i>
				[@navigation_list position = "top"]
					[#list navigations?reverse as navigation]
						<a href="${navigation.url}"[#if navigation.isBlankTarget] target="_blank"[/#if] >${navigation.name}</a>
						<i></i>
					[/#list]
				[/@navigation_list]
				<a href = "${base}/cart/list.jhtml" id="topCart" >购物车<em>0</em>件</a>
				<i></i-->
				<a href = "javascript:;" id="topName"></a>
				<!--a href = "javascript:;" >${message("shop.header.welcome", setting.siteName)}</a-->
			</div>
			<div class = "no-login dn" id="noLogin">
				<a href = "javascript:;" id = "addFavorite" >收藏网站</a>
				<i></i>
				<a href="${base}/register.jhtml">${message("shop.header.register")}</a>
				<i></i>
				<a href="${base}/login.jhtml">${message("shop.header.login")}</a>
				
			</div>
		</div>
	</div>
	<div class = "clearfix" >
		<div>
			<a href = "${base}" class = "fl">
				<h1>买德好</h1>
			</a>
			<div class="search fr" >
				<form action="${base}/goods/search.jhtml" method="get">
					<input type="text" placeholder="${goodsKeyword!message("shop.header.keyword")}....."  name="keyword" class="keyword" data-search="${message("shop.header.keyword")}" />
					<button type="submit"></button>
				</form>
				<div class = "keyword-search">
					[#if setting.hotSearches?has_content]
						[#list setting.hotSearches as hotSearch]
							<a href="${base}/goods/search.jhtml?keyword=${hotSearch?url}">${hotSearch}</a>
						[/#list]
					[/#if]
				</div>
			</div>
		</div>
	</div>

	<!-- 导航开始 -->
	<div class="index-nav">
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
	</div>
</div>
[/#escape]