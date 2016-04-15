/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.controller.shop;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.shopxx.Setting;
import net.shopxx.entity.Member;
import net.shopxx.entity.Order;
import net.shopxx.entity.PaymentLog;
import net.shopxx.entity.PaymentMethod;
import net.shopxx.plugin.PaymentPlugin;
import net.shopxx.plugin.wechatPayment.WechatUnifiedorderReturn;
import net.shopxx.plugin.wechatPayment.XmlUtil;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;
import com.thoughtworks.xstream.io.xml.XmlFriendlyNameCoder;

import net.shopxx.plugin.wechatPayment.HttpUtil;
import net.shopxx.plugin.wechatPayment.WechatPayResult;
import net.shopxx.plugin.wechatPayment.WechatUnifiedorder;

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
		System.out.println(" lsu   plugins notify for payment in paymentcontroller. pluginId is: " + pluginId + "; PaymentPlugin.NotifyMethod is: " + notifyMethod + " ; ");

		if (pluginId.contains("wechat")) {
			//微信支付方式；
			PaymentPlugin paymentPlugin = pluginService.getPaymentPlugin(pluginId);			
			
			//得到请求的xml 参数； get the return xml result.
			String line = null;
			String returnXml = "";
			java.io.BufferedReader bis = null;
			try {
				bis = new java.io.BufferedReader(new java.io.InputStreamReader(request.getInputStream()));
				while ((line = bis.readLine()) != null) {
					returnXml += line;// + "\r\n";
				}
				bis.close();
			} catch (Exception e) {
				System.out.println(" lsu ...into exception!");
				e.printStackTrace();
			} finally {
				System.out.println(" lsu ..into finally");
			}
			System.out.println(" lsu the return result is:      " + returnXml);
			// XML转换为Object
			WechatPayResult payResult = null;
			try {
				XStream xstream = new XStream(new DomDriver("UTF-8", new XmlFriendlyNameCoder("-_", "_")));
				xstream.alias("xml", WechatPayResult.class);
				payResult = (WechatPayResult)xstream.fromXML(returnXml);

				// XML转换为Object
				//payResult = (WechatPayResult) XmlUtil.xml2Object(returnXml, WechatPayResult.class);
			} catch (Exception e) {
				System.out.println(" lsu into exception");
				e.printStackTrace();
				payResult = null;
			}
			
			//检查返回值, 并设置到数据库中。。
			String sn = null;
			if (null == payResult) {
				System.out.println(" lsu  didn't get the result xml object.");
				return "failed."; 
			}
			else {
				//add all result into parameter map;
				//
				if (payResult.getReturn_code().equals("SUCCESS")) {
					//如果我们已经处理结束， 直接返回，
					//TODO
					
					// 第一次收到支付结果反馈， 我们需要处理；
					sn = payResult.getOut_trade_no();
					System.out.println(" lsu after verifyNotify, sn is: " + sn);
					PaymentLog paymentLog = paymentLogService.findBySn(sn);
					if (paymentLog != null) {
						System.out.println(" lsu  begin to handle paymentlog : ");
						paymentLogService.handle(paymentLog);
						model.addAttribute("paymentLog", paymentLog);
						model.addAttribute("notifyMessage", paymentPlugin.getNotifyMessage(notifyMethod, request));
					} else {
						System.out.println(" lsu not exist Out_trade_no,  failed! ");
						//return "failed."; 	
						return "/shop/${theme}/payment/plugin_notify";	
					}					
				}
				else {
					System.out.println(" lsu  payment failed! ");
					//return "failed.";
					return "/shop/${theme}/payment/plugin_notify";	
					
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
			System.out.println(" lsu   has successfully handled the pay result.");
			//return "successful";
			return "/shop/${theme}/payment/plugin_notify";			
		} else {
			//其他支付方式
			PaymentPlugin paymentPlugin = pluginService.getPaymentPlugin(pluginId);			
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
			System.out.println(" lsu   will jump to payment/plugin_notify ");
			return "/shop/${theme}/payment/plugin_notify";	
		}
	}
	
	/**
	 * 检查是否支持成功；
	 */
	@RequestMapping(value = "/payResultSearch/{out_trade_no}", method = RequestMethod.GET)
	public @ResponseBody
	Map<String, Object> payResult(@PathVariable String out_trade_no, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> data = new HashMap<String, Object>();
		System.out.println(" lsu .. into payResult for check whether the pay is successful. out_trade_no is: " + out_trade_no);
		Member member = memberService.getCurrent();
		PaymentLog paymentLog = paymentLogService.findBySn(out_trade_no);
		if (member == null || paymentLog == null) {
			System.out.println(" lsu mumber is null or paymentLog is null;");
			data.put("result", ERROR_MESSAGE);
			return data;
		}
		
		Order order = orderService.findBySn(out_trade_no);
		System.out.println(" lsu .. mobile is: " + member.getMobile() + " order sn is: " + order.getSn() );
		if (order == null || !member.equals(order.getMember()) || orderService.isLocked(order, member, true)) {
			System.out.println(" lsu order is null or member is wrong");
			data.put("result", ERROR_MESSAGE);
			return data;
		}

		if (paymentLog.getStatus() == PaymentLog.Status.success) {
			System.out.println(" lsu we get the successful result");
			data.put("result", SUCCESS_MESSAGE);
			return data;
		}
		System.out.println(" lsu we didn't handle the request  status is: " + paymentLog.getStatus());
		data.put("result", ERROR_MESSAGE);
		return data;
	}
}