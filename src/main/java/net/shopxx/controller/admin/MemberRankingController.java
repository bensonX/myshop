/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.controller.admin;

import javax.annotation.Resource;

import net.shopxx.Pageable;
import net.shopxx.entity.Member;
import net.shopxx.service.MemberService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Controller - 会员排名
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Controller("adminMemberRankingController")
@RequestMapping("/admin/member_ranking")
public class MemberRankingController extends BaseController {

	@Resource(name = "memberServiceImpl")
	private MemberService memberService;

	/**
	 * 列表
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Member.RankingType rankingType, Pageable pageable, Model model) {
		if (rankingType == null) {
			rankingType = Member.RankingType.amount;
		}
		model.addAttribute("rankingTypes", Member.RankingType.values());
		model.addAttribute("rankingType", rankingType);
		model.addAttribute("page", memberService.findPage(rankingType, pageable));
		return "/admin/member_ranking/list";
	}

}