[#escape x as x?html]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>${message("shop.productCategory.title")}[#if showPowered] - Powered By JSHOP[/#if]</title>
<meta name="author" content="JSHOP Team" />
<meta name="copyright" content="JSHOP" />

<link type="text/css" rel="stylesheet" href="${base}/resources/shop/${theme}/css_mdh/main.css"/>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
</head>
<body>
	[#include "/shop/${theme}/include/header_mdh.ftl" /]
		<!-- 内容区域开始 -->
		<div class="list-content clearfix">
			<ul class="list-nav">
				<li class="category">类目</li>
				[#list rootProductCategories as rootProductCategory]
				<li><a href="${base}${rootProductCategory.path}">${rootProductCategory.name}</a>
					<div class="list-twoCategory">
						<ul class="clearfix">
							[#list rootProductCategories as rootProductCategory]
							<li class="current"><a href="${base}${rootProductCategory.path}">${rootProductCategory.name}</a></li>
							[/#list]
						</ul>
						<p>
							[#list rootProductCategory.children as productCategory]
								<a href="${base}${productCategory.path}">${productCategory.name}</a>
							[/#list]
						</p>
						[@promotion_list productCategoryId = rootProductCategory.id hasEnded = false count = 3]
							[#if promotions?has_content]
									[#list promotions as promotion]
										[#if promotion.image?has_content]
											<a href="${base}${promotion.path}" title="${promotion.title}">
												<img src="${promotion.image}" alt="${promotion.title}" />
											</a>
										[/#if]
									[/#list]
							[/#if]
						[/@promotion_list]
					</div>
				</li>
				[/#list]
				<ol class="brand">
					<li class="category">${message("shop.index.recommendBrand")}</li>
					[@brand_list productCategoryId = productCategory.id count = 8]
						[#if brands?has_content]
							[#list brands as brand]
								<li>
									<a href="${base}${brand.path}">${brand.name}</a>
								</li>
							[/#list]
						[/#if]
					[/@brand_list]
				</ol>
			</ul>
			<ol class="list-images">
				[@ad_position id = 7 /]
				<li>
					<div class="moods">
						<h2 class="mian-h2">${message("shop.goods.hotGoods")}
							<span>
								<a href="javascript:;" target="blank">更多></a>
							</span>
						</h2>
						<ul class="clearfix" >
							[@goods_list productCategoryId = productCategory.id count = 15 orderBy = "monthSales desc"]
							[#if goodsList?has_content]
								[#list goodsList as goods]
								<li productId = "${productCategoryId.id}" data-items="list">
									<a href="${goods.url}" target="blank">
										<img src="${goods.thumbnail!setting.defaultThumbnailProductImage}" alt="${goods.name}" height="270" width="265"/>
										<p>${abbreviate(goods.name, 10)}
											<span>${currency(goods.price, true)}</span>
										</p>
										<div class="top">
											<div class="intop"></div>
											<h3>${abbreviate(goods.name, 52)}</h3>
											<p>${abbreviate(goods.caption, 100)}</p>
											<div class="collect">
												<button data-tag="addCart" ></button>
												<button class="last" ></button>
											</div>
										</div>
									</a>
								</li>			
								[/#list]
							[/#if]
							[/@goods_list]
						</ul>
						<button type="button"></button>
					</div>
				</li>
			</ol>
		</div>
	[#include "/shop/${theme}/include/footer_mdh.ftl"/]
</body>
</html>
[/#escape]