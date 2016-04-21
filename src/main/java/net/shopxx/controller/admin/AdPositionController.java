/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.controller.admin;

import javax.annotation.Resource;

import net.shopxx.Message;
import net.shopxx.Pageable;
import net.shopxx.entity.AdPosition;
import net.shopxx.entity.ProductCategory;
import net.shopxx.service.AdPositionService;
import net.shopxx.service.ProductCategoryService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Controller - 广告位
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Controller("adminAdPositionController")
@RequestMapping("/admin/ad_position")
public class AdPositionController extends BaseController {

	@Resource(name = "adPositionServiceImpl")
	private AdPositionService adPositionService;

	@Resource(name = "productCategoryServiceImpl")
	private ProductCategoryService productCategoryService;
	
	/**
	 * 添加
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(ModelMap model) {
		return "/admin/ad_position/add";
	}

	/**
	 * 保存
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(AdPosition adPosition,Long productCategoryId, RedirectAttributes redirectAttributes) {
		if (!isValid(adPosition)) {
			return ERROR_VIEW;
		}
		adPosition.setAds(null);
		adPosition.setProductCategory(null);
		AdPosition adposition=adPositionService.save(adPosition);
		
		System.out.println(adposition.getId());
		if(productCategoryId !=null){
			
			ProductCategory productCategory=productCategoryService.find(productCategoryId);
			productCategory.setAdPosition(adposition);
			productCategoryService.update(productCategory);
		}

		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 编辑
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(Long id, ModelMap model) {
		model.addAttribute("adPosition", adPositionService.find(id));
		return "/admin/ad_position/edit";
	}

	/**
	 * 更新
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(AdPosition adPosition,Long productCategoryId ,RedirectAttributes redirectAttributes) {
		if (!isValid(adPosition)) {
			return ERROR_VIEW;
		}
		
		AdPosition adposition=adPositionService.update(adPosition, "ads");
		System.out.println(adposition.getId());

		if(productCategoryId !=null){
			
			ProductCategory productCategory=productCategoryService.find(productCategoryId);
			productCategory.setAdPosition(adposition);
			productCategoryService.update(productCategory);
		}
		
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 列表
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Pageable pageable, ModelMap model) {
		model.addAttribute("page", adPositionService.findPage(pageable));
		return "/admin/ad_position/list";
	}

	/**
	 * 删除
	 */
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public @ResponseBody
	Message delete(Long[] ids) {
		adPositionService.delete(ids);
		return SUCCESS_MESSAGE;
	}

}