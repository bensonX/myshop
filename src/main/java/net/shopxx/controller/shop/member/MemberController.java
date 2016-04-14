/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.controller.shop.member;

import javax.annotation.Resource;

import net.shopxx.controller.shop.BaseController;
import net.shopxx.entity.Member;
import net.shopxx.entity.Order;
import net.shopxx.service.ConsultationService;
import net.shopxx.service.CouponCodeService;
import net.shopxx.service.GoodsService;
import net.shopxx.service.MemberService;
import net.shopxx.service.MessageService;
import net.shopxx.service.OrderService;
import net.shopxx.service.ProductNotifyService;
import net.shopxx.service.ReviewService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Controller - 会员中心
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Controller("shopMemberController")
@RequestMapping("/member")
public class MemberController extends BaseController {

	/** 最新订单数 */
	private static final int NEW_ORDER_COUNT = 6;

	@Resource(name = "memberServiceImpl")
	private MemberService memberService;
	@Resource(name = "orderServiceImpl")
	private OrderService orderService;
	@Resource(name = "couponCodeServiceImpl")
	private CouponCodeService couponCodeService;
	@Resource(name = "messageServiceImpl")
	private MessageService messageService;
	@Resource(name = "goodsServiceImpl")
	private GoodsService goodsService;
	@Resource(name = "productNotifyServiceImpl")
	private ProductNotifyService productNotifyService;
	@Resource(name = "reviewServiceImpl")
	private ReviewService reviewService;
	@Resource(name = "consultationServiceImpl")
	private ConsultationService consultationService;

	/**
	 * 首页
	 */
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(Integer pageNumber, ModelMap model) {
		System.out.println("===会员中心===");
		Member member = memberService.getCurrent();
		model.addAttribute("pendingPaymentOrderCount", orderService.count(null, Order.Status.pendingPayment, member, null, null, null, null, null, null, false)); // 查询订单数量  false是否已过期
		model.addAttribute("pendingShipmentOrderCount", orderService.count(null, Order.Status.pendingShipment, member, null, null, null, null, null, null, null)); // 
		model.addAttribute("messageCount", messageService.count(member, false)); // 查找消息数量
		model.addAttribute("couponCodeCount", couponCodeService.count(null, member, null, false, false)); // 查找优惠码数量
		model.addAttribute("favoriteCount", goodsService.count(null, member, null, null, null, null, null)); // 查询货品数量
		model.addAttribute("productNotifyCount", productNotifyService.count(member, null, null, null)); // 查找到货通知数量
		model.addAttribute("reviewCount", reviewService.count(member, null, null, null)); // 查找评论数量
		model.addAttribute("consultationCount", consultationService.count(member, null, null)); // 查找咨询数量
		model.addAttribute("newOrders", orderService.findList(null, null, member, null, null, null, null, null, null, null, NEW_ORDER_COUNT, null, null)); // 查找订单
		model.addAttribute("member",member);
		return "/shop/${theme}/member/index_mdh";
	}

}