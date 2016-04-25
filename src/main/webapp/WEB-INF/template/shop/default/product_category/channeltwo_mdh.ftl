[#escape x as x?html]
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>${message("shop.productCategory.title")}[#if showPowered] - Powered By JSHOP[/#if]</title>
<meta name="author" content="JSHOP Team" />
<meta name="copyright" content="JSHOP" />
<link href="${base}/resources/shop/${theme}/images_mdh/icon/favicon.ico" rel="icon"/>
<link rel="stylesheet" type="text/css" href="${base}/resources/shop/${theme}/css_mdh/common.css" />
<link type="text/css" rel="stylesheet" href="${base}/resources/shop/${theme}/css_mdh/main.css"/>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
</head>
<body>
	[#include "/shop/${theme}/include/header_mdh.ftl" /]
		<!-- 内容区域开始 -->
		<div class="list-content clearfix">
			[#list rootProductCategory as rootProductCategory]
			<div class="nav fl">
				<h2>${rootProductCategory.name}</h2>
				<ul class="list-nav">
					[#list rootProductCategory.children as productCategory]
					<li  [#if productCategoryId==productcategory.id] style="border:1px solid black" [/#if]><a href="${base}/product_category/channeltwo.jhtml?productCategoryId=${productCategory.id}">${productCategory.name}</a>
						<ol>
						[#list productCategory.children as productcategory]
							<li [#if productCategoryId==productcategory.id] style="background-color:red;" [/#if]><a href="${base}/product_category/channeltwo.jhtml?productCategoryId=${productcategory.id}">${productcategory.name}</a></li>	
						[/#list]
						</ol>
					</li>
					[/#list]
				</ul>
				<div class="brand">
					<h3>热销品牌</h3>
						[@brand_list productCategoryId = rootProductCategory.id count = 8]
							[#if brands?has_content]
								[#list brands as brand]
										[#--<a href="${base}${brand.path}">${brand.name}</a>--]
										<a  href="${base}/product_category/brand/${brand.id}.jhtml?id=${brand.id}&productCategoryId=${rootProductCategory.id}">${brand.name}</a>
								[/#list]
							[/#if]
						[/@brand_list]
						
						
				</div>
			</div>
			[/#list]		
				
		
				<div class="content fr clearfix">
					<ol class="list-images clearfix">
						[#list rootProductCategories as rootProductCategory]
						[@ad_position id = rootProductCategory.adPosition.id /]
						[/#list]
					</ol>
					<div class="moods">
						[#--
						<h3 class="mian-h2">${message("shop.goods.hotGoods")}
							<span>
								<a href="javascript:;" target="blank">更多></a>
							</span>
						</h3>
						--]
						<ul class="clearfix" >
							[@goods_list productCategoryId = productCategoryId count = 15 orderBy = "monthSales desc"]
							[#if goodsList?has_content]
								[#list goodsList as goods]
								<li productId = "${productCategoryId.id}" data-items="list">
									<a href="${goods.url}" target="_blank">
										<img src="${goods.thumbnail!setting.defaultThumbnailProductImage}" alt="${goods.name}" height="270" width="265"/>
										<p>${abbreviate(goods.name, 10)}
											<span>${currency(goods.price, true)}</span>
										</p>
										<div class="top">
											<div class="intop"></div>
											<h3>${abbreviate(goods.name, 52)}</h3>
											<p>${abbreviate(goods.caption, 100)}</p>
											<div class="collect">
												<button data-goods="enshrine"  data-id="${goods.id}"></button>
												<button class="last" ></button>
											</div>
										</div>
									</a>
								</li>			
								[/#list]
							[/#if]
							[/@goods_list]
						</ul>
				</div>
			</div>
		</div>
		
	[#include "/shop/${theme}/include/footer_mdh.ftl"/]
</body>
</html>
[/#escape]