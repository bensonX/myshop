/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.controller.shop;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.shopxx.Message;
import net.shopxx.Principal;
import net.shopxx.Setting;
import net.shopxx.entity.BaseEntity;
import net.shopxx.entity.Cart;
import net.shopxx.entity.Member;
import net.shopxx.entity.MemberAttribute;
import net.shopxx.entity.PointLog;
import net.shopxx.service.CaptchaService;
import net.shopxx.service.CartService;
import net.shopxx.service.MemberAttributeService;
import net.shopxx.service.MemberRankService;
import net.shopxx.service.MemberService;
import net.shopxx.service.RSAService;
import net.shopxx.util.SystemUtils;
import net.shopxx.util.WebUtils;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;

/**
 * Controller - 会员注册
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Controller("shopRegisterController")
@RequestMapping("/register")
public class RegisterController extends BaseController {

	@Resource(name = "captchaServiceImpl")
	private CaptchaService captchaService;
	@Resource(name = "rsaServiceImpl")
	private RSAService rsaService;
	@Resource(name = "memberServiceImpl")
	private MemberService memberService;
	@Resource(name = "memberRankServiceImpl")
	private MemberRankService memberRankService;
	@Resource(name = "memberAttributeServiceImpl")
	private MemberAttributeService memberAttributeService;
	@Resource(name = "cartServiceImpl")
	private CartService cartService;

	/**
	 * 检查用户名是否被禁用或已存在
	 */
	@RequestMapping(value = "/check_username", method = RequestMethod.GET)
	public @ResponseBody
	boolean checkUsername(String username) {
		if (StringUtils.isEmpty(username)) {
			return false;
		}
		return !memberService.usernameDisabled(username) && !memberService.usernameExists(username);
	}
	
	/**
	 * 检查手机号是否被禁用或已注册
	 */
	@RequestMapping(value = "/check_phone", method = RequestMethod.GET)
	public @ResponseBody
	boolean checkPhone(String phone){
		System.out.println("check_phone"+phone);
		if(StringUtils.isEmpty(phone)){
			return false;
		}
		return !memberService.phoneExists(phone);
	}
	
	/**
	 * 获取手机号验证码
	 */
	@RequestMapping(value = "/phone_captcha", method = RequestMethod.GET)
	public @ResponseBody
	String sendPhoneCaptcha(String phone,HttpServletRequest request, HttpServletResponse response, HttpSession session){
		System.out.println("phone:"+phone);
		if(StringUtils.isEmpty(phone)){
			return false+"";
		}
		Random random = new Random();
		Double doub = random.nextDouble(); 
		String strcode = doub + ""; 
		strcode=strcode.substring(3,3+4); 
		// 官网的URL
		String url = "http://gw.api.taobao.com/router/rest";
		// 成为开发者，创建应用后系统自动生成
		String appkey = "23331183";
		String secret = "ed45c69efd06e5b91aa8708ba8595a3a";
		//短信模板的内容  
		String json="{\"code\":\""+strcode+"\",\"product\":\"leosu , 电子商务验证\"}"; 
		TaobaoClient client = new DefaultTaobaoClient(url, appkey, secret);
		AlibabaAliqinFcSmsNumSendRequest req = new AlibabaAliqinFcSmsNumSendRequest();
		req.setExtend("123456");
		req.setSmsType("normal");
		req.setSmsFreeSignName("注册验证");
		req.setSmsParamString(json);
		req.setRecNum(phone);
		req.setSmsTemplateCode("SMS_6480466"); 
		try {
			AlibabaAliqinFcSmsNumSendResponse rsp = client.execute(req);
			System.out.println("leo in try");
			System.out.println(rsp.getBody());
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("leo in cache");
			System.out.println(e.toString());
			return "获取验证码失败！";
		}
		System.out.println("发送成功！");
		request.setAttribute("phonecaptcha", strcode);
		return strcode;
	}
	
	/**
	 * 检查E-mail是否存在
	 */
	@RequestMapping(value = "/check_email", method = RequestMethod.GET)
	public @ResponseBody
	boolean checkEmail(String email) {
		if (StringUtils.isEmpty(email)) {
			return false;
		}
		return !memberService.emailExists(email);
	}

	/**
	 * 注册页面
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String index(ModelMap model) {
		System.out.println("跳转到注册页面。。。。。");
		model.addAttribute("genders", Member.Gender.values());
		model.addAttribute("captchaId", UUID.randomUUID().toString());
		return "/shop/${theme}/register/index_mdh";
	}

	/**
	 * 注册提交
	 */
	@RequestMapping(value = "/submit", method = RequestMethod.POST)
	public @ResponseBody
	Message submit(String phone, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//	Message submit(String captchaId, String captcha, String username, String email, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
//		if (!captchaService.isValid(Setting.CaptchaType.memberRegister, captchaId, captcha)) {
//			return Message.error("shop.captcha.invalid");
//		}
//		Setting setting = SystemUtils.getSetting();
//		if (!setting.getIsRegisterEnabled()) {
//			return Message.error("shop.register.disabled");
//		}
//		String password = rsaService.decryptParameter("enPassword", request);
//		rsaService.removePrivateKey(request);
//		if (!isValid(Member.class, "username", username, BaseEntity.Save.class) || !isValid(Member.class, "password", password, BaseEntity.Save.class) || !isValid(Member.class, "email", email, BaseEntity.Save.class)) {
//			return Message.error("shop.common.invalid");
//		}
//		if (username.length() < setting.getUsernameMinLength() || username.length() > setting.getUsernameMaxLength()) {
//			return Message.error("shop.common.invalid");
//		}
//		if (password.length() < setting.getPasswordMinLength() || password.length() > setting.getPasswordMaxLength()) {
//			return Message.error("shop.common.invalid");
//		}
//		if (memberService.usernameDisabled(username) || memberService.usernameExists(username)) {
//			return Message.error("shop.register.disabledExist");
//		}
//		if (!setting.getIsDuplicateEmail() && memberService.emailExists(email)) {
//			return Message.error("shop.register.emailExist");
//		}
		System.out.println("注册提交。。。");
		Setting setting = SystemUtils.getSetting();
		String password = rsaService.decryptParameter("enPassword", request);
		rsaService.removePrivateKey(request);
		Member member = new Member();
		member.removeAttributeValue();
		for (MemberAttribute memberAttribute : memberAttributeService.findList(true, true)) {
			String[] values = request.getParameterValues("memberAttribute_" + memberAttribute.getId());
			if (!memberAttributeService.isValid(memberAttribute, values)) {
				return Message.error("shop.common.invalid");
			}
			Object memberAttributeValue = memberAttributeService.toMemberAttributeValue(memberAttribute, values);
			member.setAttributeValue(memberAttribute, memberAttributeValue);
		}
		member.setPhone(phone);
		member.setUsername("MDH_"+phone);
		member.setPassword(DigestUtils.md5Hex(password));
		member.setEmail(phone+"@maidehao.com");
		member.setNickname(null);
		member.setPoint(0L);
		member.setBalance(BigDecimal.ZERO);
		member.setAmount(BigDecimal.ZERO);
		member.setIsEnabled(true);
		member.setIsLocked(false);
		member.setLoginFailureCount(0);
		member.setLockedDate(null);
		member.setRegisterIp(request.getRemoteAddr());
		member.setLoginIp(request.getRemoteAddr());
		member.setLoginDate(new Date());
		member.setLoginPluginId(null);
		member.setOpenId(null);
		member.setLockKey(null);
		member.setSafeKey(null);
		member.setMemberRank(memberRankService.findDefault());
		member.setCart(null);
		member.setOrders(null);
		member.setPaymentLogs(null);
		member.setDepositLogs(null);
		member.setCouponCodes(null);
		member.setReceivers(null);
		member.setReviews(null);
		member.setConsultations(null);
		member.setFavoriteGoods(null);
		member.setProductNotifies(null);
		member.setInMessages(null);
		member.setOutMessages(null);
		member.setPointLogs(null);
		memberService.save(member);
System.out.println("111111111111");
//		if (setting.getRegisterPoint() > 0) {
//			memberService.addPoint(member, setting.getRegisterPoint(), PointLog.Type.reward, null, null);
//		}
System.out.println("2222222222");
		Cart cart = cartService.getCurrent();
		if (cart != null && cart.getMember() == null) {
			cartService.merge(member, cart);
			WebUtils.removeCookie(request, response, Cart.KEY_COOKIE_NAME);
		}
System.out.println("333333333333333333");
		Map<String, Object> attributes = new HashMap<String, Object>();
		Enumeration<?> keys = session.getAttributeNames();
		while (keys.hasMoreElements()) {
			String key = (String) keys.nextElement();
			attributes.put(key, session.getAttribute(key));
		}
		session.invalidate();
		session = request.getSession();
		for (Map.Entry<String, Object> entry : attributes.entrySet()) {
			session.setAttribute(entry.getKey(), entry.getValue());
		}
		System.out.println("44444444444444444444");
//		session.setAttribute(Member.PRINCIPAL_ATTRIBUTE_NAME, new Principal(member.getId(), member.getPhone()));
//		WebUtils.addCookie(request, response, Member.PHONE_COOKIE_NAME, member.getPhone());
//		if (StringUtils.isNotEmpty(member.getNickname())) {
//			WebUtils.addCookie(request, response, Member.NICKNAME_COOKIE_NAME, member.getNickname());
//		}
//		if (StringUtils.isNotEmpty(member.getUsername())) {
//			WebUtils.addCookie(request, response, Member.USERNAME_COOKIE_NAME, member.getUsername());
//		}
		System.out.println("555555555555555555555");
		return Message.success("shop.register.success");
	}

}