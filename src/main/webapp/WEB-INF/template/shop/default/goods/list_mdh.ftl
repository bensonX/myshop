[#--

[#escape x as x?html]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
[#if productCategory??]
	[@seo type = "goodsList"]
		<title>[#if productCategory.seoTitle??]${productCategory.seoTitle}[#elseif seo.title??][@seo.title?interpret /][/#if][#if showPowered] - Powered By JSHOP[/#if]</title>
		<meta name="author" content="JSHOP Team" />
		<meta name="copyright" content="JSHOP" />
		[#if productCategory.seoKeywords??]
			<meta name="keywords" content="${productCategory.seoKeywords}" />
		[#elseif seo.keywords??]
			<meta name="keywords" content="[@seo.keywords?interpret /]" />
		[/#if]
		[#if productCategory.seoDescription??]
			<meta name="description" content="${productCategory.seoDescription}" />
		[#elseif seo.description??]
			<meta name="description" content="[@seo.description?interpret /]" />
		[/#if]
	[/@seo]
[#else]
	<title>${message("shop.goods.title")}[#if showPowered] - Powered By JSHOP[/#if]</title>
	<meta name="author" content="JSHOP Team" />
	<meta name="copyright" content="JSHOP" />
[/#if]
<link href="${base}/resources/shop/${theme}/css/common.css" rel="stylesheet" type="text/css" />
<link href="${base}/resources/shop/${theme}/css/goods.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/jquery.lazyload.js"></script>
<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
<script type="text/javascript">
$().ready(function() {

	var $headerCart = $("#headerCart");
	var $compareBar = $("#compareBar");
	var $compareForm = $("#compareBar form");
	var $compareSubmit = $("#compareBar a.submit");
	var $clearCompare = $("#compareBar a.clear");
	var $goodsForm = $("#goodsForm");
	var $brandId = $("#brandId");
	var $promotionId = $("#promotionId");
	var $orderType = $("#orderType");
	var $pageNumber = $("#pageNumber");
	var $pageSize = $("#pageSize");
	var $filter = $("#filter dl");
	var $hiddenFilter = $("#filter dl:hidden");
	var $moreOption = $("#filter dd.moreOption");
	var $brand = $("#filter a.brand");
	var $attribute = $("#filter a.attribute");
	var $moreFilter = $("#moreFilter a");
	var $gridType = $("#gridType");
	var $listType = $("#listType");
	var $size = $("#layout a.size");
	var $previousPage = $("#previousPage");
	var $nextPage = $("#nextPage");
	var $sort = $("#sort a, #sort li");
	var $orderMenu = $("#orderMenu");
	var $startPrice = $("#startPrice");
	var $endPrice = $("#endPrice");
	var $result = $("#result");
	var $productImage = $("#result img");
	var $addCart = $("#result a.addCart");
	var $exchange = $("#result a.exchange");
	var $addFavorite = $("#result a.addFavorite");
	var $addCompare = $("#result a.addCompare");
	
	[#if productCategory??]
		$filter.each(function() {
			var $this = $(this);
			var scrollHeight = this.scrollHeight > 0 ? this.scrollHeight : $.swap(this, {display: "block", position: "absolute", visibility: "hidden"}, function() {
				return this.scrollHeight;
			});
			if (scrollHeight > 30) {
				if ($this.find("a.current").size() > 0) {
					$this.height("auto");
				} else {
					$this.find("dd.moreOption").show();
				}
			}
		});
		
		$moreOption.click(function() {
			var $this = $(this);
			if ($this.hasClass("close")) {
				$this.removeClass("close");
				$this.attr("title", "${message("shop.goods.moreOption")}");
				$this.parent().height(30);
			} else {
				$this.addClass("close");
				$this.attr("title", "${message("shop.goods.closeOption")}");
				$this.parent().height("auto");
			}
		});
		
		$moreFilter.click(function() {
			var $this = $(this);
			if ($this.hasClass("close")) {
				$this.removeClass("close");
				$this.text("${message("shop.goods.moreFilter")}");
				$hiddenFilter.hide();
			} else {
				$this.addClass("close");
				$this.text("${message("shop.goods.closeFilter")}");
				$hiddenFilter.show();
			}
			return false;
		});
		
		$brand.click(function() {
			var $this = $(this);
			if ($this.hasClass("current")) {
				$brandId.val("");
			} else {
				$brandId.val($this.attr("brandId"));
			}
			$pageNumber.val(1);
			$goodsForm.submit();
			return false;
		});
		
		$attribute.click(function() {
			var $this = $(this);
			if ($this.hasClass("current")) {
				$this.closest("dl").find("input").prop("disabled", true);
			} else {
				$this.closest("dl").find("input").prop("disabled", false).val($this.text());
			}
			$pageNumber.val(1);
			$goodsForm.submit();
			return false;
		});
	[/#if]
	
	var layoutType = getCookie("layoutType");
	if (layoutType == "listType") {
		$listType.addClass("currentList");
		$result.removeClass("grid").addClass("list");
	} else {
		$gridType.addClass("currentGrid");
		$result.removeClass("list").addClass("grid");
	}
	
	$gridType.click(function() {
		var $this = $(this);
		if (!$this.hasClass("currentGrid")) {
			$this.addClass("currentGrid");
			$listType.removeClass("currentList");
			$result.removeClass("list").addClass("grid");
			addCookie("layoutType", "gridType");
		}
		return false;
	});
	
	$listType.click(function() {
		var $this = $(this);
		if (!$this.hasClass("currentList")) {
			$this.addClass("currentList");
			$gridType.removeClass("currentGrid");
			$result.removeClass("grid").addClass("list");
			addCookie("layoutType", "listType");
		}
		return false;
	});
	
	$size.click(function() {
		var $this = $(this);
		$pageNumber.val(1);
		$pageSize.val($this.attr("pageSize"));
		$goodsForm.submit();
		return false;
	});
	
	$previousPage.click(function() {
		$pageNumber.val(${page.pageNumber - 1});
		$goodsForm.submit();
		return false;
	});
	
	$nextPage.click(function() {
		$pageNumber.val(${page.pageNumber + 1});
		$goodsForm.submit();
		return false;
	});
	
	$orderMenu.hover(
		function() {
			$(this).children("ul").show();
		}, function() {
			$(this).children("ul").hide();
		}
	);
	
	$sort.click(function() {
		var $this = $(this);
		if ($this.hasClass("current")) {
			$orderType.val("");
		} else {
			$orderType.val($this.attr("orderType"));
		}
		$pageNumber.val(1);
		$goodsForm.submit();
		return false;
	});
	
	$startPrice.add($endPrice).focus(function() {
		$(this).siblings("button").show();
	});
	
	$startPrice.add($endPrice).keypress(function(event) {
		return (event.which >= 48 && event.which <= 57) || (event.which == 46 && $(this).val().indexOf(".") < 0) || event.which == 8 || event.which == 13;
	});
	
	$goodsForm.submit(function() {
		if ($brandId.val() == "") {
			$brandId.prop("disabled", true);
		}
		if ($promotionId.val() == "") {
			$promotionId.prop("disabled", true);
		}
		if ($orderType.val() == "" || $orderType.val() == "topDesc") {
			$orderType.prop("disabled", true);
		}
		if ($pageNumber.val() == "" || $pageNumber.val() == "1") {
			$pageNumber.prop("disabled", true);
		}
		if ($pageSize.val() == "" || $pageSize.val() == "20") {
			$pageSize.prop("disabled", true);
		}
		if ($startPrice.val() == "" || !/^\d+(\.\d+)?$/.test($startPrice.val())) {
			$startPrice.prop("disabled", true);
		}
		if ($endPrice.val() == "" || !/^\d+(\.\d+)?$/.test($endPrice.val())) {
			$endPrice.prop("disabled", true);
		}
		if ($goodsForm.serializeArray().length < 1) {
			location.href = location.pathname;
			return false;
		}
	});

	$.pageSkip = function(pageNumber) {
		$pageNumber.val(pageNumber);
		$goodsForm.submit();
		return false;
	}

});
</script>
</head>
<body>
	[#include "/shop/${theme}/include/header.ftl" /]
	[#include "/shop/${theme}/include/header_mdh.ftl" /]	
	<div class="container goodsList">
		<div id="compareBar" class="compareBar">
			<form action="${base}/goods/compare.jhtml" method="get">
				<dl>
					<dt>${message("shop.goods.compareBar")}</dt>
					<dd class="action">
						<a href="javascript:;" class="submit">${message("shop.goods.compareSubmit")}</a>
						<a href="javascript:;" class="clear">${message("shop.goods.clearCompare")}</a>
					</dd>
				</dl>
			</form>
		</div>
		<div class="row">
			<div class="span2">

				[#include "/shop/${theme}/include/hot_product_category.ftl" /]
				[#include "/shop/${theme}/include/hot_brand.ftl" /]
				[#include "/shop/${theme}/include/hot_goods.ftl" /]
				[#include "/shop/${theme}/include/hot_promotion.ftl" /]

			</div>
			<div class="span10">
				<div class="breadcrumb">
					<ul>
						<li>
							<a href="${base}/">${message("shop.breadcrumb.home")}</a>
						</li>
						[#if productCategory??]
							[@product_category_parent_list productCategoryId = productCategory.id]
								[#list productCategories as productCategory]
									<li>
										<a href="${base}${productCategory.path}">${productCategory.name}</a>
									</li>
								[/#list]
							[/@product_category_parent_list]
							<li>${productCategory.name}</li>
						[#else]
							<li>${message("shop.goods.title")}</li>
						[/#if]
					</ul>
				</div>
				<form id="goodsForm" action="${base}${(productCategory.path)!"/goods/list.jhtml"}" method="get">
					<input type="text" id="brandId" name="brandId" value="${(brand.id)!}" />
					<input type="text" id="promotionId" name="promotionId" value="${(promotion.id)!}" />
					<input type="text" id="orderType" name="orderType" value="${orderType}" />
					<input type="text" id="pageNumber" name="pageNumber" value="${page.pageNumber}" />
					<input type="text" id="pageSize" name="pageSize" value="${page.pageSize}" />
					[#if productCategory??]
						[@product_category_children_list productCategoryId = productCategory.id recursive = false]
							[#assign filterProductCategories = productCategories /]
						[/@product_category_children_list]
						[@brand_list productCategoryId = productCategory.id]
							[#assign filterBrands = brands /]
						[/@brand_list]
						[@attribute_list productCategoryId = productCategory.id]
							[#assign filterAttributes = attributes /]
						[/@attribute_list]
						[#if filterProductCategories?has_content || filterBrands?has_content || filterAttributes?has_content]
							<div id="filter" class="filter">
								<div class="title">${message("shop.goods.filter")}</div>
								<div class="content">
									[#assign rows = 0 /]
									[#if filterProductCategories?has_content]
										[#assign rows = rows + 1 /]
										<dl class="clearfix">${rows}1111
											<dt>${message("shop.goods.productCategory")}:${rows}</dt>
											[#list filterProductCategories as filterProductCategory]
												<dd>
													<a href="${base}${filterProductCategory.path}">${filterProductCategory.name}</a>
												</dd>
											[/#list]
											<dd class="moreOption" title="${message("shop.goods.moreOption")}">&nbsp;</dd>
										</dl>
									[/#if]
									[#if filterBrands?has_content]
										[#assign rows = rows + 1 /]
										<dl class="clearfix">${rows}2222
											<dt>${message("shop.goods.brand")}:${rows}</dt>
											[#list filterBrands as filterBrand]
												<dd>
													<a href="javascript:;"[#if filterBrand == brand] class="brand current" title="${message("shop.goods.cancel")}"[#else] class="brand"[/#if] brandId="${filterBrand.id}">${filterBrand.name}</a>	
												</dd>
											[/#list]
											<dd class="moreOption" title="${message("shop.goods.moreOption")}">&nbsp;</dd>
										</dl>
									[/#if]
									[#assign hasHiddenAttribute = false /]
									[#list filterAttributes as filterAttribute]
										[#assign rows = rows + 1 /]
										<dl class="clearfix[#if rows > 3 && !attributeValueMap?keys?seq_contains(filterAttribute)][#assign hasHiddenAttribute = true /] hidden[/#if]">
											<dt>${rows}3333
												<input type="hidden" name="attribute_${filterAttribute.id}"[#if attributeValueMap?keys?seq_contains(filterAttribute)] value="${attributeValueMap.get(filterAttribute)}"[#else] disabled="disabled"[/#if] />
												<span title="${filterAttribute.name}">${abbreviate(filterAttribute.name, 12)}:</span>
											</dt>
											[#list filterAttribute.options as option]
												<dd>
													<a href="javascript:;"[#if attributeValueMap.get(filterAttribute) == option] class="attribute current" title="${message("shop.goods.cancel")}"[#else] class="attribute"[/#if]>${option}</a>
												</dd>
											[/#list]
											<dd class="moreOption" title="${message("shop.goods.moreOption")}">&nbsp;</dd>
										</dl>
									[/#list]
								</div>
								<div id="moreFilter" class="moreFilter">
									[#if hasHiddenAttribute]
										<a href="javascript:;">${message("shop.goods.moreFilter")}</a>
									[#else]
										&nbsp;
									[/#if]
								</div>
							</div>
						[/#if]
					[/#if]
					<div class="bar">
						<div id="layout" class="layout">
							<label>${message("shop.goods.layout")}:</label>
							<a href="javascript:;" id="gridType" class="gridType">
								<span>&nbsp;</span>
							</a>
							<a href="javascript:;" id="listType" class="listType">
								<span>&nbsp;</span>
							</a>
							<label>${message("shop.goods.pageSize")}:</label>
							<a href="javascript:;" class="size[#if page.pageSize == 20] current[/#if]" pageSize="20">
								<span>20</span>
							</a>
							<a href="javascript:;" class="size[#if page.pageSize == 40] current[/#if]" pageSize="40">
								<span>40</span>
							</a>
							<a href="javascript:;" class="size[#if page.pageSize == 80] current[/#if]" pageSize="80">
								<span>80</span>
							</a>
							<span class="page">
								<label>${message("shop.goods.totalCount", page.total)} ${page.pageNumber}/[#if page.totalPages > 0]${page.totalPages}[#else]1[/#if]</label>
								[#if page.totalPages > 0]
									[#if page.pageNumber != 1]
										<a href="javascript:;" id="previousPage" class="previousPage">
											<span>${message("shop.goods.previousPage")}</span>
										</a>
									[/#if]
									[#if page.pageNumber != page.totalPages]
										<a href="javascript:;" id="nextPage" class="nextPage">
											<span>${message("shop.goods.nextPage")}</span>
										</a>
									[/#if]
								[/#if]
								<a href="#"><span>previous</span></a>
								<a href="#"><span>next</span></a>
							</span>
						</div>
						<div id="sort" class="sort">
							<div id="orderMenu" class="orderMenu">
								[#if orderType??]
									<span>${message("Goods.OrderType." + orderType)}</span>
								[#else]
									<span>${message("Goods.OrderType." + orderTypes[0])}</span>
								[/#if]
								<ul>
									[#list orderTypes as type]
										<li[#if type == orderType] class="current"[/#if] orderType="${type}">${message("Goods.OrderType." + type)}</li>
									[/#list]
								</ul>
							</div>
							<a href="javascript:;"[#if orderType == "priceAsc"] class="currentAsc current" title="${message("shop.goods.cancel")}"[#else] class="asc"[/#if] orderType="priceAsc">${message("shop.goods.priceAsc")}</a>
							<a href="javascript:;"[#if orderType == "salesDesc"] class="currentDesc current" title="${message("shop.goods.cancel")}"[#else] class="desc"[/#if] orderType="salesDesc">${message("shop.goods.salesDesc")}</a>
							<a href="javascript:;"[#if orderType == "scoreDesc"] class="currentDesc current" title="${message("shop.goods.cancel")}"[#else] class="desc"[/#if] orderType="scoreDesc">${message("shop.goods.scoreDesc")}</a>
							<input type="text" id="startPrice" name="startPrice" class="startPrice" value="${startPrice}" maxlength="16" title="${message("shop.goods.startPrice")}" onpaste="return false" />
							<label>-</label>
							<input type="text" id="endPrice" name="endPrice" class="endPrice" value="${endPrice}" maxlength="16" title="${message("shop.goods.endPrice")}" onpaste="return false" />
							<button type="submit">${message("shop.goods.submit")}</button>
						</div>
					</div>
					
					<div id="result" class="result grid clearfix">
						[#if page.content?has_content]
							<ul>
								[#list page.content as goods]
									[#assign defaultProduct = goods.defaultProduct /]
									<li>
										<a href="${goods.url}">
											<img src="${base}/upload/image/blank.gif" data-original="${goods.thumbnail!setting.defaultThumbnailProductImage}" />
											<div>
												[#if goods.caption?has_content]
													<span title="${goods.name}">${abbreviate(goods.name, 24)}</span>
													<em title="${goods.caption}">${abbreviate(goods.caption, 24)}</em>
												[#else]
													${abbreviate(goods.name, 48)}
												[/#if]
											</div>
										</a>
										<strong>
											[#if goods.type == "general"]
												${currency(defaultProduct.price, true)}
												[#if setting.isShowMarketPrice]
													<del>${currency(defaultProduct.marketPrice, true)}</del>
												[/#if]
											[#elseif goods.type == "exchange"]
												<em>${message("Product.exchangePoint")}:</em>
												${defaultProduct.exchangePoint}
											[/#if]
										</strong>
										<div class="action">
											[#if goods.type == "general"]
												<a href="javascript:;" class="addCart" productId="${defaultProduct.id}">${message("shop.goods.addCart")}</a>
											[#elseif goods.type == "exchange"]
												<a href="javascript:;" class="exchange" productId="${defaultProduct.id}">${message("shop.goods.exchange")}</a>
											[/#if]
											<a href="javascript:;" class="addFavorite" title="${message("shop.goods.addFavorite")}" goodsId="${goods.id}">&nbsp;</a>
											<a href="javascript:;" class="addCompare" title="${message("shop.goods.addCompare")}" goodsId="${goods.id}">&nbsp;</a>
										</div>
									</li>
								[/#list]
							</ul>
						[#else]
							[#noescape]
								${message("shop.goods.noListResult")}
							[/#noescape]
						[/#if]
					</div>
					[@pagination pageNumber = page.pageNumber totalPages = page.totalPages pattern = "javascript: $.pageSkip({pageNumber});"]
						哈哈哈[#include "/shop/${theme}/include/pagination.ftl"]
					[/@pagination]
				</form>
			</div>
		</div>
	</div>
	[#include "/shop/${theme}/include/footer_mdh.ftl" /]
	[#include "/shop/${theme}/include/footer.ftl" /]	
</body>
</html>
[/#escape]
--]

[#escape x as x?html]
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
		<meta http-equiv="content-type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge" />
		[#if productCategory??]
			[@seo type = "goodsList"]
				<title>[#if productCategory.seoTitle??]${productCategory.seoTitle}[#elseif seo.title??][@seo.title?interpret /][/#if][#if showPowered] - Powered By JSHOP[/#if]</title>
				<meta name="author" content="JSHOP Team" />
				<meta name="copyright" content="JSHOP" />
				[#if productCategory.seoKeywords??]
					<meta name="keywords" content="${productCategory.seoKeywords}" />
				[#elseif seo.keywords??]
					<meta name="keywords" content="[@seo.keywords?interpret /]" />
				[/#if]
				[#if productCategory.seoDescription??]
					<meta name="description" content="${productCategory.seoDescription}" />
				[#elseif seo.description??]
					<meta name="description" content="[@seo.description?interpret /]" />
				[/#if]
			[/@seo]
		[#else]
			<title>${message("shop.goods.title")}[#if showPowered] - 买德好[/#if]</title>
			<meta name="author" content="JSHOP Team" />
			<meta name="copyright" content="JSHOP" />
		[/#if]
		<meta http-equiv="X-UA-Compatible" content="IE=Edge">
		<meta name="keywords" content="test" />
		<meta name="description" content="买德好专注打造国内首家德国跨境精品聚集地，只将最具品质及品味的德国正品引入国人生活。涵盖生活多方面的产品体系，带来真正一站式的购物便捷体验。独具特色的知识性模块形式，让你无限贴近德式生活" />
		<link href="favicon.ico" rel="icon" type="image/x-icon" />
		<link rel="stylesheet" type="text/css" href="${base}/resources/shop/${theme}/css_mdh/common.css" />
		<link href="${base}/resources/shop/${theme}/css_mdh/main.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${base}/resources/shop/${theme}/js_mdh/third/jquery.js"></script>
		<script type="text/javascript" src="${base}/resources/shop/${theme}/js_mdh/main/views/base.js"></script>
		<script type="text/javascript" src="${base}/resources/shop/${theme}/js/common.js"></script>
		<script type="text/javascript">
			$().ready(function() {
			//	var $headerCart = $("#headerCart");
				var $compareBar = $("#compareBar");
				var $compareForm = $("#compareBar form");
				var $compareSubmit = $("#compareBar a.submit");
				var $clearCompare = $("#compareBar a.clear");
				var $goodsForm = $("#goodsForm");
				var $brandId = $("#brandId");
				var $promotionId = $("#promotionId");
				var $orderType = $("#orderType");
				var $pageNumber = $("#pageNumber");
				var $pageSize = $("#pageSize");
				var $filter = $("#filter dl");
				var $hiddenFilter = $("#filter dl:hidden");
				var $moreOption = $("#filter dd.moreOption");
				var $brand = $("#filter a.brand");
				var $attribute = $("#filter a.attribute");
				var $moreFilter = $("#moreFilter a");
				var $gridType = $("#gridType");
				var $listType = $("#listType");
				var $size = $("#layout a.size");
				var $previousPage = $(".previousPage");
				var $nextPage = $(".nextPage");
				var $sort = $("#sort a, #sort li");
				var $orderMenu = $("#orderMenu");
				var $startPrice = $("#startPrice");
				var $endPrice = $("#endPrice");
				var $result = $("#result");
				var $productImage = $("#result img");
				var $addCart = $("#result a.addCart");
				var $exchange = $("#result a.exchange");
				var $addFavorite = $("#result a.addFavorite");
				var $addCompare = $("#result a.addCompare");
				var $pgn = $(".pgn");
				var $confirmPage = $("#confirmPage");
				var $confirm = $("#confirm");
				
				[#if productCategory??]
				$filter.each(function() {
					var $this = $(this);
					var scrollHeight = this.scrollHeight > 0 ? this.scrollHeight : $.swap(this, {display: "block", position: "absolute", visibility: "hidden"}, function() {
						return this.scrollHeight;
					});
					if (scrollHeight > 30) {
						if ($this.find("a.current").size() > 0) {
							$this.height("auto");
						} else {
							$this.find("dd.moreOption").show();
						}
					}
				});
				
				$moreOption.click(function() {
					var $this = $(this);
					if ($this.hasClass("close")) {
						$this.removeClass("close");
						$this.attr("title", "${message("shop.goods.moreOption")}");
						$this.parent().height(30);
					} else {
						$this.addClass("close");
						$this.attr("title", "${message("shop.goods.closeOption")}");
						$this.parent().height("auto");
					}
				});
				
				$moreFilter.click(function() {
					var $this = $(this);
					if ($this.hasClass("close")) {
						$this.removeClass("close");
						$this.text("${message("shop.goods.moreFilter")}");
						$hiddenFilter.hide();
					} else {
						$this.addClass("close");
						$this.text("${message("shop.goods.closeFilter")}");
						$hiddenFilter.show();
					}
					return false;
				});
				
				$brand.click(function() {
					var $this = $(this);
					if ($this.hasClass("current")) {
						$brandId.val("");
					} else {
						$brandId.val($this.attr("brandId"));
					}
					$pageNumber.val(1);
					$goodsForm.submit();
					return false;
				});
				
				$attribute.click(function() {
					var $this = $(this);
					if ($this.hasClass("current")) {
						$this.closest("dl").find("input").prop("disabled", true);
					} else {
						$this.closest("dl").find("input").prop("disabled", false).val($this.text());
					}
					$pageNumber.val(1);
					$goodsForm.submit();
					return false;
				});
			[/#if]
			
			var layoutType = getCookie("layoutType");
			if (layoutType == "listType") {
				$listType.addClass("currentList");
				$result.removeClass("grid").addClass("list");
			} else {
				$gridType.addClass("currentGrid");
				$result.removeClass("list").addClass("grid");
			}
			
			$gridType.click(function() {
				var $this = $(this);
				if (!$this.hasClass("currentGrid")) {
					$this.addClass("currentGrid");
					$listType.removeClass("currentList");
					$result.removeClass("list").addClass("grid");
					addCookie("layoutType", "gridType");
				}
				return false;
			});
			
			$listType.click(function() {
				var $this = $(this);
				if (!$this.hasClass("currentList")) {
					$this.addClass("currentList");
					$gridType.removeClass("currentGrid");
					$result.removeClass("grid").addClass("list");
					addCookie("layoutType", "listType");
				}
				return false;
			});
			
			$size.click(function() {
				var $this = $(this);
				$pageNumber.val(1);
				$pageSize.val($this.attr("pageSize"));
				$goodsForm.submit();
				return false;
			});
			
			$previousPage.click(function() {
				$pageNumber.val(${page.pageNumber - 1});
				$goodsForm.submit();
				return false;
			});
			
			$nextPage.click(function() {
				$pageNumber.val(${page.pageNumber + 1});
				$goodsForm.submit();
				return false;
			});
			
			$pgn.click(function() {
				//alert($(this).html());
				//alert($(this).attr('data-tag'));
				$pageNumber.val($(this).attr('data-tag'));
				$goodsForm.submit();
				return false;
			});
			
			$confirm.click(function(){
				$pageNumber.val($confirmPage.val());
				$goodsForm.submit();
				return false;
			});
			
			$orderMenu.hover(
				function() {
					$(this).children("ul").show();
				}, function() {
					$(this).children("ul").hide();
				}
			);
			
			$sort.click(function() {
				var $this = $(this);
				if ($this.hasClass("current")) {
					$orderType.val("");
				} else {
					$orderType.val($this.attr("orderType"));
				}
				$pageNumber.val(1);
				$goodsForm.submit();
				return false;
			});
			
			$startPrice.add($endPrice).focus(function() {
				$(this).siblings("button").show();
			});
			
			$startPrice.add($endPrice).keypress(function(event) {
				return (event.which >= 48 && event.which <= 57) || (event.which == 46 && $(this).val().indexOf(".") < 0) || event.which == 8 || event.which == 13;
			});
			
			$goodsForm.submit(function() {
				if ($brandId.val() == "") {
					$brandId.prop("disabled", true);
				}
				if ($promotionId.val() == "") {
					$promotionId.prop("disabled", true);
				}
				if ($orderType.val() == "" || $orderType.val() == "topDesc") {
					$orderType.prop("disabled", true);
				}
				if ($pageNumber.val() == "" || $pageNumber.val() == "1") {
					$pageNumber.prop("disabled", true);
				}
				if ($pageSize.val() == "" || $pageSize.val() == "20") {
					$pageSize.prop("disabled", true);
				}
				if ($startPrice.val() == "" || !/^\d+(\.\d+)?$/.test($startPrice.val())) {
					$startPrice.prop("disabled", true);
				}
				if ($endPrice.val() == "" || !/^\d+(\.\d+)?$/.test($endPrice.val())) {
					$endPrice.prop("disabled", true);
				}
				if ($goodsForm.serializeArray().length < 1) {
					location.href = location.pathname;
					return false;
				}
			});
			
		});
			
		</script>
	</head>
    <body>
    	<!-- 头部开始 -->
		[#include "/shop/${theme}/include/header_mdh.ftl" /]	
		<form id="goodsForm" action="${base}${(productCategory.path)!"/goods/list.jhtml"}" method="get">
			
			
			<input type="hidden" border="1" id="brandId" name="brandId" value="${(brand.id)!}" />
			<input type="hidden" border="1" id="promotionId" name="promotionId" value="${(promotion.id)!}" />
			<input type="hidden" border="1" id="orderType" name="orderType" value="${orderType}" />
			<input type="hidden" border="1" id="pageNumber" name="pageNumber" value="${page.pageNumber}" />
			<input type="hidden" border="1" id="pageSize" name="pageSize" value="${page.pageSize}" />

			[#if productCategory??]
				[@product_category_children_list productCategoryId = productCategory.id recursive = false]
					[#assign filterProductCategories = productCategories /]
				[/@product_category_children_list]
				[@brand_list productCategoryId = productCategory.id]
					[#assign filterBrands = brands /]
				[/@brand_list]
				[@attribute_list productCategoryId = productCategory.id]
					[#assign filterAttributes = attributes /]
				[/@attribute_list]	
			[/#if]
		</form>
			<div class="goods-nav clearfix">
				<div class="goods-left">
					<h2>
						[#if productCategory??]
							[@product_category_parent_list productCategoryId = productCategory.id]
								[#list productCategories as productCategory]
										<a href="${base}${productCategory.path}">${productCategory.name}</a>
								[/#list]
							[/@product_category_parent_list]
							${productCategory.name}
						[#else]
							${message("shop.goods.title")}
						[/#if]
					</h2>
					<a href="javascript:;">默认</a>
					<!--div id="sort" class="sort">
						<div id="orderMenu" class="orderMenu">
							${orderType}orderType${orderTypes[0]}orderTypes[0]
							[#if orderType??]
								<span>${message("Goods.OrderType." + orderType)}</span>
							[#else]
								<span>${message("Goods.OrderType." + orderTypes[0])}</span>
							[/#if]
							<ul>
								[#list orderTypes as type]
									<li[#if type == orderType] class="current"[/#if] orderType="${type}">${message("Goods.OrderType." + type)}</li>
								[/#list]
							</ul>
						</div-->
						<div id="sort" class="sort">
								<a href="javascript:;"[#if orderType == "salesDesc"] class="currentDesc selected current" title="${message("shop.goods.cancel")}"[#else] class="desc"[/#if] orderType="salesDesc">${message("shop.goods.salesDesc")}<i></i></a>
								<a href="javascript:;"[#if orderType == "scoreDesc"] class="currentDesc current" title="${message("shop.goods.cancel")}"[#else] class="desc"[/#if] orderType="scoreDesc">${message("shop.goods.scoreDesc")}<i></i></a>
								<a href="javascript:;"[#if orderType == "priceAsc"] class="currentAsc current" title="${message("shop.goods.cancel")}"[#else] class="asc"[/#if] orderType="priceAsc">${message("shop.goods.priceAsc")}<i></i></a>
						</div>		
						<!--input type="text" id="startPrice" name="startPrice" class="startPrice" value="${startPrice}" maxlength="16" title="${message("shop.goods.startPrice")}" onpaste="return false" />
						<label>-</label>
						<input type="text" id="endPrice" name="endPrice" class="endPrice" value="${endPrice}" maxlength="16" title="${message("shop.goods.endPrice")}" onpaste="return false" />
						<button type="submit">${message("shop.goods.submit")}</button>
					</div-->
				</div>
				<div class="goods-key">
					[#if page.totalPages > 0]
						[#if page.pageNumber != 1]
							<a href="javascript:;" class="previousPage" ></a>
						[#else]
							<a href="javascript:;" class="previousPage" ></a>
						[/#if]
						[#if page.pageNumber != page.totalPages]
							<a href="javascript:;" class="nextPage" ></a>
						[#else]
							<a href="javascript:;" class="nextPage" ></a>
						[/#if]
					[/#if]
				</div>
			</div>
			
			
			<div class="moods">
				[#if page.content?has_content]
				<ul class="clearfix" >
					[#list page.content as goods]
						[#assign defaultProduct = goods.defaultProduct /]
						<li productId = "${goods.id}" data-items="list" >
							<a href="${goods.url}" target="_blank" >
								<!--img src="${goods.thumbnail!setting.defaultThumbnailProductImage}"  height="270" width="265"/-->
								<img src="${goods.image}" height="270" width="265"/>

								<p>	<!--
									goods.caption——》${goods.caption}<br/>
									goods.name——》${goods.name}——》${abbreviate(goods.name, 24)}——》${abbreviate(goods.name, 48)}<br/>
									goods.type——》${goods.type}<br/>
									exchangePoint——》${defaultProduct.exchangePoint}<br/>
									Product.exchangePoint——》${message("Product.exchangePoint")}<br/>
									-->
											${abbreviate(goods.name, 12)}
									<span>
										[#if goods.type == "general"]
											${currency(defaultProduct.price, true)}
										[/#if]
									</span>
								</P>
								<div class="top">
									<div class="intop"></div>
									<h3>
										[#if goods.caption?has_content]
											<span title="${goods.name}">${abbreviate(goods.name, 24)}</span>
										[#else]
											${abbreviate(goods.name, 48)}
										[/#if]
									</h3>
									<p>
											${abbreviate(goods.caption, 48)}
									</p>
									<div class="collect">
										<button title="${message("shop.goods.addCart")}" data-goods="enshrine" data-id="${goods.id}"></button>
										<button href="javascript:;" class="last" title="${message("shop.goods.exchange")}" goodsId="${goods.id}"></button>
									</div>
								</div>
							</a>							
						</li>
					[/#list]
				</ul>
				[#else]
					[#noescape]
						${message("shop.goods.noListResult")}
					[/#noescape]
				[/#if]
			</div>
			
			<!--span class="page">
				<label>${message("shop.goods.totalCount", page.total)} ${page.pageNumber}/[#if page.totalPages > 0]${page.totalPages}[#else]1[/#if]</label>
				[#if page.totalPages > 0]
					[#if page.pageNumber != 1]
						<a href="javascript:;" id="previousPage" class="previousPage">
							<span>${message("shop.goods.previousPage")}</span>
						</a>
					[/#if]
					[#if page.pageNumber != page.totalPages]
						<a href="javascript:;" id="nextPage" class="nextPage">
							<span>${message("shop.goods.nextPage")}</span>
						</a>
					[/#if]
				[/#if]
				<a href="#"><span>previous</span></a>
				<a href="#">page.totalPages+${page.totalPages}</a>
				<a href="#">page.pageNumber+${page.pageNumber}</a>
				<a href="#">page.total+${page.total}</a>
				<a href="#">page.pageSize+${page.pageSize}</a>					
				<a href="#"><span>next</span></a>
			</span-->
			<p class="number">
					<a href="">${message("shop.goods.totalCount", page.total)} ${page.pageNumber}/[#if page.totalPages > 0]${page.totalPages}[#else]1[/#if]</a>
				[#list 1..page.totalPages as pgn]
					<a href="javascript:;" data-tag = "${pgn}" class="pgn">${pgn}</a>
				[/#list]
				[#if page.totalPages > 0]
					[#if page.pageNumber != 1]
						<a href="javascript:;" class="previousPage" class="page">
							${message("shop.goods.previousPage")}
						</a>
					[#else]
						<a href="javascript:;">	${message("shop.goods.previousPage")}</a>
					[/#if]
					[#if page.pageNumber != page.totalPages]
						<a href="javascript:;" class="nextPage" class="next">
							${message("shop.goods.nextPage")}
						</a>
					[#else]
						<a href="javascript:;"> ${message("shop.goods.nextPage")}</a>
					[/#if]
				[/#if]
				<span>跳转到
					<input type="text" id="confirmPage"/>页
				</span>
				<button id="confirm">确&nbsp认</button>
			</p>
		
		<!-- 底部开始 -->
		[#include "/shop/${theme}/include/footer_mdh.ftl" /]
    </body>
</html>
[/#escape]
