/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.controller.shop;

import java.io.PrintWriter;
import java.math.BigDecimal;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.shopxx.Setting;
import net.shopxx.entity.Member;
import net.shopxx.entity.Order;
import net.shopxx.entity.PaymentLog;
import net.shopxx.entity.PaymentMethod;
import net.shopxx.plugin.PaymentPlugin;
import net.shopxx.service.MemberService;
import net.shopxx.service.OrderService;
import net.shopxx.service.PaymentLogService;
import net.shopxx.service.PluginService;
import net.shopxx.util.SystemUtils;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Controller - 支付
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Controller("shopPaymentController")
@RequestMapping("/payment")
public class PaymentController extends BaseController {

	@Resource(name = "orderServiceImpl")
	private OrderService orderService;
	@Resource(name = "memberServiceImpl")
	private MemberService memberService;
	@Resource(name = "pluginServiceImpl")
	private PluginService pluginService;
	@Resource(name = "paymentLogServiceImpl")
	private PaymentLogService paymentLogService;

	/**
	 * 插件提交
	 */
	@RequestMapping(value = "/plugin_submit", method = RequestMethod.POST)
	public String pluginSubmit(PaymentLog.Type type, String paymentPluginId, String sn, BigDecimal amount, HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		System.out.println(" lsu ..payment plugin submit in paymentcontroller : ");
		System.out.println(" lsu .PaymentLog.Type is: " + type + "; paymentPluginId is: " + paymentPluginId + "; sn is: " + sn + "; amount is: " + amount);
		System.out.println(" lsu  set attribute for sn  " + request.getParameter("sn") + " paymentPluginId is: " + request.getParameter("paymentPluginId"));

		if (type == null) {
			return ERROR_VIEW;
		}
		Member member = memberService.getCurrent();
		if (member == null) {
			return ERROR_VIEW;
		}
		PaymentPlugin paymentPlugin = pluginService.getPaymentPlugin(paymentPluginId);
		if (paymentPlugin == null || !paymentPlugin.getIsEnabled()) {
			return ERROR_VIEW;
		}
		Setting setting = SystemUtils.getSetting();
		switch (type) {
		case recharge: {
			if (amount == null || amount.compareTo(BigDecimal.ZERO) <= 0 || amount.precision() > 15 || amount.scale() > setting.getPriceScale()) {
				return ERROR_VIEW;
			}
			PaymentLog paymentLog = new PaymentLog();
			paymentLog.setSn(null);
			paymentLog.setType(type);
			paymentLog.setStatus(PaymentLog.Status.wait);
			paymentLog.setFee(paymentPlugin.calculateFee(amount));
			paymentLog.setAmount(paymentPlugin.calculateAmount(amount));
			paymentLog.setPaymentPluginId(paymentPluginId);
			paymentLog.setPaymentPluginName(paymentPlugin.getName());
			paymentLog.setMember(member);
			paymentLog.setOrder(null);
			paymentLogService.save(paymentLog);
			model.addAttribute("parameterMap", paymentPlugin.getParameterMap(paymentLog.getSn(), message("shop.payment.rechargeDescription"), request));
			break;
		}
		case payment: {
			Order order = orderService.findBySn(sn);
			if (order == null || !member.equals(order.getMember()) || orderService.isLocked(order, member, true)) {
				return ERROR_VIEW;
			}
			if (order.getPaymentMethod() == null || !PaymentMethod.Method.online.equals(order.getPaymentMethod().getMethod())) {
				return ERROR_VIEW;
			}
			if (order.getAmountPayable().compareTo(BigDecimal.ZERO) <= 0) {
				return ERROR_VIEW;
			}
			PaymentLog paymentLog = new PaymentLog();
			paymentLog.setSn(null);
			paymentLog.setType(type);
			paymentLog.setStatus(PaymentLog.Status.wait);
			paymentLog.setFee(paymentPlugin.calculateFee(order.getAmount()));
			paymentLog.setAmount(paymentPlugin.calculateAmount(order.getAmount()));
			paymentLog.setPaymentPluginId(paymentPluginId);
			paymentLog.setPaymentPluginName(paymentPlugin.getName());
			paymentLog.setOrder(order);
			paymentLog.setMember(null);
			paymentLogService.save(paymentLog);
			model.addAttribute("parameterMap", paymentPlugin.getParameterMap(paymentLog.getSn(), message("shop.payment.paymentDescription", order.getSn()), request));
			break;
		}
		}
		if (paymentPluginId.contains("wechat")) {
			// request.setAttribute("code", code);
			// request.getRequestDispatcher("/WEB-INF/jsp/pay.jsp").forward(request,
			// response);
			System.out.println("lsu  jump to  is: wechat_paying");
			return "/shop/${theme}/payment/wechat_paying";
		} else {

			model.addAttribute("requestUrl", paymentPlugin.getRequestUrl());
			model.addAttribute("requestMethod", paymentPlugin.getRequestMethod());
			model.addAttribute("requestCharset", paymentPlugin.getRequestCharset());
			if (StringUtils.isNotEmpty(paymentPlugin.getRequestCharset())) {
				response.setContentType("text/html; charset=" + paymentPlugin.getRequestCharset());
			}
			return "/shop/${theme}/payment/plugin_submit";
		}
	}

	/**
	 * 插件通知
	 */
	@RequestMapping("/plugin_notify/{pluginId}/{notifyMethod}")
	public String pluginNotify(@PathVariable String pluginId, @PathVariable PaymentPlugin.NotifyMethod notifyMethod, HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		System.out.println(" lsu .. plugins notify for payment in paymentcontroller. : ");
		PaymentPlugin paymentPlugin = pluginService.getPaymentPlugin(pluginId);
		System.out.println(" lsu pluginId is: " + pluginId + "; PaymentPlugin.NotifyMethod is: " + notifyMethod + " ; ");
		if (paymentPlugin != null && paymentPlugin.verifyNotify(notifyMethod, request)) {
			String sn = paymentPlugin.getSn(request);
			System.out.println(" lsu after verifyNotify, sn is: " + sn);
			PaymentLog paymentLog = paymentLogService.findBySn(sn);
			if (paymentLog != null) {
				System.out.println(" lsu  begin to handle paymentlog : ");
				paymentLogService.handle(paymentLog);
				model.addAttribute("paymentLog", paymentLog);
				model.addAttribute("notifyMessage", paymentPlugin.getNotifyMessage(notifyMethod, request));
			}
		}
		// 支付完成后，微信会把相关支付结果和用户信息发送给商户，商户需要接收处理，并返回应答。
		String rs = "<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>";
		PrintWriter pw = null;
		try {
			System.out.println(" lsu  the return is : " + rs);
			pw = response.getWriter();
			pw.write(rs);
			pw.flush();
			pw.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}

		System.out.println(" lsu   will jump to payment/plugin_notify ");
		return "/shop/${theme}/payment/plugin_notify";
	}
	
	/**
	 * 微信插件通知
	 */
	@RequestMapping("/wx_notify/{pluginId}/{notifyMethod}")
	public String wechatPluginNotify(@PathVariable String pluginId, @PathVariable PaymentPlugin.NotifyMethod notifyMethod, HttpServletRequest request, HttpServletResponse response, ModelMap model) {
		System.out.println(" lsu .. plugins notify for payment in paymentcontroller. : ");
		PaymentPlugin paymentPlugin = pluginService.getPaymentPlugin(pluginId);
		System.out.println(" lsu pluginId is: " + pluginId + "; PaymentPlugin.NotifyMethod is: " + notifyMethod + " ; ");
		if (paymentPlugin != null && paymentPlugin.verifyNotify(notifyMethod, request)) {
			String sn = paymentPlugin.getSn(request);
			System.out.println(" lsu after verifyNotify, sn is: " + sn);
			PaymentLog paymentLog = paymentLogService.findBySn(sn);
			if (paymentLog != null) {
				System.out.println(" lsu  begin to handle paymentlog : ");
				paymentLogService.handle(paymentLog);
				model.addAttribute("paymentLog", paymentLog);
				model.addAttribute("notifyMessage", paymentPlugin.getNotifyMessage(notifyMethod, request));
			}
		}
		// 支付完成后，微信会把相关支付结果和用户信息发送给商户，商户需要接收处理，并返回应答。
		String rs = "<xml><return_code><![CDATA[SUCCESS]]></return_code><return_msg><![CDATA[OK]]></return_msg></xml>";
		PrintWriter pw = null;
		try {
			System.out.println(" lsu  the return is : " + rs);
			pw = response.getWriter();
			pw.write(rs);
			pw.flush();
			pw.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

		}

		System.out.println(" lsu   will jump to payment/plugin_notify ");
		return "/shop/${theme}/payment/plugin_notify";
	}

}