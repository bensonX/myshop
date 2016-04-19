/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.controller.shop.member;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.shopxx.Setting;
import net.shopxx.controller.shop.BaseController;
import net.shopxx.entity.Member;
import net.shopxx.service.MemberService;
import net.shopxx.util.SystemUtils;
import net.shopxx.util.WebUtils;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Controller - 会员中心 - 密码
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Controller("shopMemberPasswordController")
@RequestMapping("/member/password")
public class PasswordController extends BaseController {

	@Resource(name = "memberServiceImpl")
	private MemberService memberService;

	/**
	 * 验证当前密码
	 */
	@RequestMapping(value = "/check_current_password", method = RequestMethod.GET)
	public @ResponseBody
	boolean checkCurrentPassword(String currentPassword) {
		if (StringUtils.isEmpty(currentPassword)) {
			return false;
		}
		Member member = memberService.getCurrent();
		return StringUtils.equals(DigestUtils.md5Hex(currentPassword), member.getPassword());
	}
	
	/**
	 * 安全中心
	 */
	@RequestMapping(value = "/securityCenter", method = RequestMethod.GET)
	public String securityCenter(HttpServletRequest request){
		Member member = memberService.getCurrent();
		request.setAttribute("mobile", member.getMobile());
		
		return "/shop/${theme}/member/password/security_center_mdh";
	}

	/**
	 * 编辑  密码
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit() {
		return "/shop/${theme}/member/password/edit_mdh";
	}
	
	/**
	 * 编辑  手机号
	 */
	@RequestMapping(value = "/validate", method = RequestMethod.GET)
	public String validate(HttpServletRequest request){

		try{
			Member member = memberService.getCurrent();
			request.setAttribute("mobile", member.getMobile());
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "/shop/${theme}/member/password/validate_mdh";
	}
	@RequestMapping(value = "/newMobileMdh", method = RequestMethod.POST)
	public String newMobileMdh(HttpServletRequest request,String mobile){
		try{
			Member member = memberService.getCurrent();
			System.out.println(mobile);
			if(!mobile.equals(member.getMobile())){
				return "redirect:securityCenter.jhtml";
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return "/shop/${theme}/member/password/new_mobile_mdh";
	}
	/**
	 * 添加  手机号
	 */
	@RequestMapping(value= "/addMobileMdh", method = RequestMethod.GET)
	public String addMobileMdh(HttpServletRequest request){
		return "/shop/${theme}/member/password/new_mobile_mdh";
	}
	/**
	 * 更新  密码
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(String currentPassword, String password, RedirectAttributes redirectAttributes) {
		if (StringUtils.isEmpty(password) || StringUtils.isEmpty(currentPassword)) {
			return ERROR_VIEW;
		}
		if (!isValid(Member.class, "password", password)) {
			return ERROR_VIEW;
		}
		Setting setting = SystemUtils.getSetting();
		if (password.length() < setting.getPasswordMinLength() || password.length() > setting.getPasswordMaxLength()) {
			return ERROR_VIEW;
		}
		Member member = memberService.getCurrent();
		if (!StringUtils.equals(DigestUtils.md5Hex(currentPassword), member.getPassword())) {
			return ERROR_VIEW;
		}
		member.setPassword(DigestUtils.md5Hex(password));
		memberService.update(member);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:securityCenter.jhtml";
	}
	
	/**
	 * 更新  手机号
	 */
	@RequestMapping(value = "/update2", method = RequestMethod.POST)
	public String update2( String newMobile, RedirectAttributes redirectAttributes,HttpServletRequest request, HttpServletResponse response) {
		System.out.println("update2");
		boolean flag=memberService.mobileExists(newMobile);
		System.out.println(flag);
		Member member = memberService.getCurrent();
		if (flag) {
			return ERROR_VIEW;
		}
		member.setMobile(newMobile);
		memberService.update(member);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		
		if (StringUtils.isNotEmpty(member.getMobile())) {
			WebUtils.addCookie(request, response, Member.MOBILE_COOKIE_NAME, member.getMobile());
		}
		return "redirect:securityCenter.jhtml";
	}

}