[#escape x as x?html]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
[@seo type = "index"]
	<title>[#if seo.title??][@seo.title?interpret /][#else]${message("shop.index.title")}[/#if][#if showPowered] - Powered By JSHOP[/#if]</title>
	<meta name="author" content="JSHOP Team" />
	<meta name="copyright" content="JSHOP" />
	[#if seo.keywords??]
		<meta name="keywords" content="[@seo.keywords?interpret /]" />
	[/#if]
	[#if seo.description??]
		<meta name="description" content="[@seo.description?interpret /]" />
	[/#if]
[/@seo]
[#--
<link href="${base}/favicon.ico" rel="icon" type="image/x-icon" />
<link href="${base}/resources/shop/${theme}/slider/slider.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/${theme}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/${theme}/css/index.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.tools.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/slider/slider.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
--]

<link rel="stylesheet" type="text/css" href="${base}/resources/shop/${theme}/css_mdh/main.css" />
<script type="text/javascript"  src = "${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
<script type="text/javascript"  src = "${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
<script type="text/javascript"  src = "${base}/resources/shop/${theme}/js_mdh/main/views/index.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
<script>
	$(function () {
		// 收藏
		init.enshrine('${base}/member/favorite/add.jhtml');  // 里面收藏地址
	})
</script>
</head>
<body>
	[#include "/shop/${theme}/include/header_mdh.ftl" /]
	
	<!-- 轮播图开始 -->
	<div class="main_visual">
		[@ad_position id = 1 /]
	</div>
	
	[#--
	<div class="container index" >
	

		<div class="row" style="border:3px solid red;">
			<div class="span2">
				[@product_category_root_list count = 6]
					<div id="productCategoryMenu" class="productCategoryMenu">
						<ul>
							[#list productCategories as productCategory]
								<li>
									[@product_category_children_list productCategoryId = productCategory.id recursive = false count = 3]
										<div class="item[#if !productCategory_has_next] last[/#if]">
											<div>
												[#list productCategories as productCategory]
													<a href="${base}${productCategory.path}">
														<strong>${productCategory.name}</strong>
													</a>
												[/#list]
											</div>
											<div>
												[@brand_list productCategoryId = productCategory.id count = 4]
													[#list brands as brand]
														<a href="${base}${brand.path}">${brand.name}</a>
													[/#list]
												[/@brand_list]
											</div>
										</div>
									[/@product_category_children_list]
									[@product_category_children_list productCategoryId = productCategory.id recursive = false count = 8]
										<div class="menu">
											[#list productCategories as productCategory]
												<dl class="clearfix[#if !productCategory_has_next] last[/#if]">
													<dt>
														<a href="${base}${productCategory.path}">哈${productCategory.name} </a>
													</dt>
													[@product_category_children_list productCategoryId = productCategory.id recursive = false]
														[#list productCategories as productCategory]
															<dd>
																<a href="${base}${productCategory.path}">${productCategory.name}</a>[#if productCategory_has_next]|[/#if]
															</dd>
														[/#list]
													[/@product_category_children_list]
												</dl>
											[/#list]
											<div class="auxiliary">
												[@brand_list productCategoryId = productCategory.id count = 8]
													[#if brands?has_content]
														<div>
															<strong>${message("shop.index.recommendBrand")}</strong>
															[#list brands as brand]
																<a href="${base}${brand.path}">${brand.name}</a>
															[/#list]
														</div>
													[/#if]
												[/@brand_list]
												[@promotion_list productCategoryId = productCategory.id hasEnded = false count = 4]
													[#if promotions?has_content]
														<div>
															<strong>${message("shop.index.hotPromotion")}</strong>
															[#list promotions as promotion]
																[#if promotion.image?has_content]
																	<a href="${base}${promotion.path}" title="${promotion.title}">
																		<img src="${promotion.image}" alt="${promotion.title}" />promotion_list${message("shop.index.hotPromotion")}
																	</a>
																[/#if]
															[/#list]
														</div>
													[/#if]
												[/@promotion_list]
											</div>
										</div>
									[/@product_category_children_list]
								</li>
							[/#list]
						</ul>
					</div>
				[/@product_category_root_list]
			</div>
			<br>
			<br>
			<br>
			<br>
			
			<div class="span10" style="border:2px solid blue;">
				[@ad_position id = 1 /]
			</div>
		</div>
		--]
		<!-- 图片一区开始 -->
		<div class="main">
			[@ad_position id = 2 /]
		</div>
		[#--
		<div class="main">
			<ul class="clearfix">
				[@product_category_root_list count = 6]
					[@promotion_list productCategoryId = productCategory.id hasEnded = false count = 2]
						[#if promotions?has_content]
							[#list promotions as promotion]
								[#if promotion.image?has_content]
									<li class="right">
										<a href="${base}${promotion.path}" title="${promotion.title}">
											<img src="${promotion.image}" alt="${promotion.title}" height="200" width="540">
										</a>
									</li>						
								[/#if]
							[/#list]
						[/#if]
					[/@promotion_list]
				[/@product_category_root_list]
			</ul>
		</div> 
		--]
		<!-- 新品上架开始 -->
		<div class="news" data-tag=news>
			<h2 class="mian-h2 clearfix">${message("shop.index.newPromotion")}
				<span>
					<a href="${base}/goods/list.jhtml?tagId = 3" target="blank">${message("shop.index.morePromotion")}></a>
				</span>
			</h2>		
			<ul class="clearfix">
				[#--]@product_category_root_list count = 6]
					[@promotion_list productCategoryId = productCategory.id hasEnded = false count = 4]
						[#if promotions?has_content]
							[#list promotions as promotion]
								[#if promotion.image?has_content]
				                    <li>
										<a href="${base}${promotion.path}" title="${promotion.title}" >
											<img src="${promotion.image}" alt="${promotion.title}" height="265" width="265">
										</a>
										<div class="about">
											<a href="${base}${promotion.path}" title="${promotion.title}">
												<h3>${promotion.title}</h3>
											</a>
											<a href="${base}${promotion.path}" title="${promotion.title}">
												${promotion.name}
											</a>
											<span>${promotion.minimumPrice}</span>
											<p class="last">
												<strike>${promotion.maximumPrice}</strike>
												<a href="javascript:;" data-goods="enshrine" goods="123456">
													<img src="${base}/resources/shop/${theme}/images_mdh/icon/about3.png" >
												</a>
												<a href="javascript:;" >
													<img src="${base}/resources/shop/${theme}/images_mdh/icon/about1.png" >
												</a>
											</p>
										</div>		
									</li>				
								[/#if]
							[/#list]
						[/#if]
					[/@promotion_list]
				[/@product_category_root_list--]
				
				[@goods_list count = 4 OrderType = dateDesc][#--tagId = 3--]
					[#list goodsList as goods]
						[#if goods_index < 4]
							<li>
								<a href="${goods.url}" title="${goods.name}" target="_blank">
									<img src="${goods.image}" height="265" width="265">
								</a>
								<div class="about">
									<a href="${goods.url}" title="${goods.name}" target="_blank">
										<h3>${abbreviate(goods.name, 24)}</h3>
									</a>
									<a href="${goods.url}" title="${goods.name}" target="_blank">
										<p>${abbreviate(goods.caption, 24)}</p>
									</a>
									<span>${goods.price}</span>
									<p class="last">
										<strike>${good.marketPrice}</strike>
										<a href="javascript:;" >
											<img src="${base}/resources/shop/${theme}/images_mdh/icon/about3.png" >
										</a>
										<a href="javascript:;" >
											<img src="${base}/resources/shop/${theme}/images_mdh/icon/index-top.png" data-goods="enshrine"  data-id="${goods.id}" >
										</a>
									</p>
								</div>
							</li>
						[/#if]
					[/#list]
				[/@goods_list]
			</ul>
			[#--
			<ul class="clearfix" >
				[@ad_position id = 4 /]
			</ul>
			--]
		</div>
		<!-- 图片区域2开始 -->
		[@ad_position id = 3 /]
		[#--
		<div class="row" style="border:1px solid red;">
			<div class="span9">
				[@ad_position id = 2 /]
			</div>
			<div class="span3">
				[@article_category_root_list count = 2]
					[#if articleCategories?has_content]
						<div id="newArticle" class="newArticle">
							<ul class="tab">
								[#list articleCategories as articleCategory]
									<li>
										<a href="${base}${articleCategory.path}" target="_blank">${articleCategory.name}</a>
									</li>
								[/#list]
							</ul>
							[#list articleCategories as articleCategory]
								[@article_list articleCategoryId = articleCategory.id count = 6]
									<ul class="tabContent[#if articleCategory_index > 0] hidden[/#if]">
										[#list articles as article]
											<li>
												<a href="${article.url}" title="${article.title}" target="_blank">${abbreviate(article.title, 40)}</a>
											</li>
										[/#list]
									</ul>
								[/@article_list]
							[/#list]
						</div>
					[/#if]
				[/@article_category_root_list]
			</div>
		</div>
		--]
		<!-- 模块商品开始 -->
		<div class="moods">
			<h2 class="mian-h2 clearfix">人气商品
				<span>
					<a href="${base}/goods/list.jhtml" target="blank">${message("shop.index.morePromotion")}></a>
				</span>
			</h2>
			[@product_category_root_list count = 4]
			[#--
				[@ad_position id = 4]
					[#if adPosition??]
						[#assign adIterator = adPosition.ads.iterator() /]
					[/#if]
				[/@ad_position]
				--]
				[#list productCategories as productCategory]
					[@goods_list productCategoryId = productCategory.id tagId = 3 count = 10]
					[#--
					<h2>${productCategory.name}
						<span>
							<a href="${base}${productCategory.path}">${message("shop.index.morePromotion")}></a>
						</span>
					</h2>
					--]
					<ul class="clearfix" >
						[#list goodsList as goods]
							[#if goods_index < 4]
								<!--li>
									<a href="${goods.url}" title="${goods.name}" target="_blank">
											<img src="${goods.image}" height="270" width="265">
										<P>${abbreviate(goods.name, 10)}
											<span>${currency(goods.price, true)}</span>
										</P>
										<div class="top">
											<div class="intop"></div>
											<h3>${abbreviate(goods.name, 24)}</h3>
											<p>${abbreviate(goods.caption, 24)}
											</p>
											<div class="collect">
												<a href=""></a>
												<a class="last" href=""></a>
											</div>
										</div>
									</a>
								</li-->
								<li productId = "123456" >
									<a href="${goods.url}" title="${goods.name}" target="_blank" >
										<img src="${goods.image}" height="270" width="265">
										<p>${abbreviate(goods.name, 10)}
											<span>${currency(goods.price, true)}</span>
										</p>
										<div class="top">
											<div class="intop"></div>
											<h3>${abbreviate(goods.name, 24)}</h3>
											<p>${abbreviate(goods.caption, 24)}</p>
											<div class="collect">
												<button data-goods="enshrine"  data-id="${goods.id}" ></button>
												<button class="last" ></button>
											</div>
										</div>
									</a>
								</li>
							[/#if]
						[/#list]
					</ul>
					[/@goods_list]
				[/#list]
			[/@product_category_root_list]
			<button></button>
		</div>

		[#--
		[@product_category_root_list count = 3]
			[@ad_position id = 4]
				[#if adPosition??]
					[#assign adIterator = adPosition.ads.iterator() /]
				[/#if]
			[/@ad_position]
			[#list productCategories as productCategory]
				[@goods_list productCategoryId = productCategory.id tagId = 3 count = 10]
					<div class="row">
						<div class="span12">
							<div class="hotGoods">
								[@product_category_children_list productCategoryId = productCategory.id recursive = false count = 8]
									<dl class="title${productCategory_index + 1}">
										<dt>
											<a href="${base}${productCategory.path}">${productCategory.name}</a>
										</dt>
										[#list productCategories as productCategory]
											<dd>
											<a href="${base}${productCategory.path}">${productCategory.name}</a>
											</dd>
										[/#list]
									</dl>
								[/@product_category_children_list]
								<div>
									[#if adIterator?? && adIterator.hasNext()]
										[#assign ad = adIterator.next() /]
										[#if ad.url??]
											<a href="${ad.url}">
											<img src="${ad.path}" alt="${ad.title}" title="${ad.title}" />
											</a>
										[#else]
											<img src="${ad.path}" alt="${ad.title}" title="${ad.title}" />
										[/#if]
									[/#if]
								</div>
								<ul>
									[#list goodsList as goods]
										[#if goods_index < 5]
											<li>
												<a href="${goods.url}" title="${goods.name}" target="_blank">
													<div>
														[#if goods.caption?has_content]
															<span title="${goods.name}">${abbreviate(goods.name, 24)}</span>
															<em title="${goods.caption}">${abbreviate(goods.caption, 24)}</em>
														[#else]
															${abbreviate(goods.name, 48)}
														[/#if]
													</div>
													<strong>${currency(goods.price, true)}</strong>
													<img src="${goods.image}">${goods.image}
													<img src="${base}/upload/image/blank.gif" data-original="${goods.image!setting.defaultThumbnailProductImage}" />
												</a>
											</li>
										[#else]
											<li class="low">
												<a href="${goods.url}" title="${goods.name}" target="_blank">
													<img src="${base}/upload/image/blank.gif" data-original="${goods.image!setting.defaultThumbnailProductImage}" />
													<span title="${goods.name}">${abbreviate(goods.name, 24)}</span>
													<strong>${currency(goods.price, true)}</strong>
												</a>
											</li>
										[/#if]
									[/#list]
								</ul>
							</div>
						</div>
					</div>
				[/@goods_list]
			[/#list]
		[/@product_category_root_list]
		--]
		[#--
		<div class="row">
			<div class="span12">
				[@ad_position id = 5 /]
			</div>
		</div>
		<div class="row">
			<div class="span12">
				[@brand_list type = "image" count = 10]
					[#if brands?has_content]
						<div class="hotBrand">
							<ul class="clearfix">
								[#list brands as brand]
									<li>
										<a href="${base}${brand.path}" title="${brand.name}">
											<img src="${brand.logo}" alt="${brand.name}" />
										</a>
									</li>
								[/#list]
							</ul>
						</div>
					[/#if]
				[/@brand_list]
			</div>
		</div>
	</div>
	--]
	[#include "/shop/${theme}/include/footer_mdh.ftl" /]
</body>
</html>
[/#escape]