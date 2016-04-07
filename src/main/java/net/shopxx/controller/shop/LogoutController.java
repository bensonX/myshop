/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.controller.shop;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.shopxx.entity.Member;
import net.shopxx.service.MemberService;
import net.shopxx.util.WebUtils;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Controller - 会员注销
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Controller("shopLogoutController")
public class LogoutController extends BaseController {

	@Resource(name = "memberServiceImpl")
	private MemberService memberService;

	/**
	 * 注销
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String execute(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		WebUtils.removeCookie(request, response, Member.USERNAME_COOKIE_NAME);
		WebUtils.removeCookie(request, response, Member.NICKNAME_COOKIE_NAME);
		WebUtils.removeCookie(request, response, Member.MOBILE_COOKIE_NAME);
		if (memberService.isAuthenticated()) {
			session.removeAttribute(Member.PRINCIPAL_ATTRIBUTE_NAME);
		}
		return "redirect:/";
	}

}