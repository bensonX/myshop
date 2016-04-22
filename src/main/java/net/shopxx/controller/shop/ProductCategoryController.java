/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.controller.shop;

import javax.annotation.Resource;

import net.shopxx.entity.Brand;
import net.shopxx.entity.ProductCategory;
import net.shopxx.service.BrandService;
import net.shopxx.service.ProductCategoryService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Controller - 商品分类
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Controller("shopProductCategoryController")
@RequestMapping("/product_category")
public class ProductCategoryController extends BaseController {

	@Resource(name = "productCategoryServiceImpl")
	private ProductCategoryService productCategoryService;

	@Resource(name = "brandServiceImpl")
	private BrandService brandService;
	/**
	 * 首页
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String index(ModelMap model) {
		model.addAttribute("rootProductCategories", productCategoryService.findRoots());
		return "/shop/${theme}/product_category/index_mdh";
		//return "/shop/${theme}/product_category/index";
	}

	/**
	 * 频道
	 */
	@RequestMapping(value = "channel",method = RequestMethod.GET)
	public String channel(ModelMap model,Long productCategoryId,String productCategoryName) {
		model.addAttribute("rootProductCategories", productCategoryService.find(productCategoryId));
		model.addAttribute("productCategoryId",productCategoryId);
		model.addAttribute("productCategoryName",productCategoryName);
		return "/shop/${theme}/product_category/channel_mdh";

	}

	/**
	 * 频道2
	 */
	@RequestMapping(value = "channeltwo",method = RequestMethod.GET)
	public String channeltwo(ModelMap model,Long productCategoryId) {
		ProductCategory pc=productCategoryService.find(productCategoryId);
		
		while(pc.getParent()!=null){
			pc=productCategoryService.find(pc.getParent().getId());
		}

		model.addAttribute("rootProductCategories", productCategoryService.find(productCategoryId));
		model.addAttribute("rootProductCategory", productCategoryService.find(pc.getId()));
		model.addAttribute("productCategoryId",productCategoryId);
		
		return "/shop/${theme}/product_category/channeltwo_mdh";

	}
	
	/**
	 * 商品分类
	 */
	@RequestMapping(value="/brand/{id}", method = RequestMethod.GET)
	public String brandProductCategory(@PathVariable Long id,Long productCategoryId, ModelMap model){
		
		model.addAttribute("rootProductCategory", productCategoryService.find(productCategoryId));
		model.addAttribute("productCategoryId",productCategoryId);
		
		if(id!=null){
			Brand brand = brandService.find(id);			
			model.addAttribute("brand", brand);
			model.addAttribute("brandId",brand.getId());
		}
		
		return "/shop/${theme}/product_category/brand_mdh";
	}
}