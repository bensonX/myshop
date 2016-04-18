/*
 * Copyright 2005-2016 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.plugin.wechatPayment;

import java.math.BigDecimal;
import java.net.InetAddress;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

import java.io.File;
import java.io.IOException;
import java.util.SortedMap;


import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import net.shopxx.Setting;
import net.shopxx.entity.Order;
import net.shopxx.entity.PaymentLog;
import net.shopxx.entity.PluginConfig;
import net.shopxx.plugin.PaymentPlugin;
import net.shopxx.util.LogUtil;
import net.shopxx.util.SystemUtils;
import net.shopxx.util.WebUtils;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import net.shopxx.service.OrderService;


/**
 * Plugin - 微信支付
 * 
 * @author JSHOP Team
 \* @version 4.X
 */
@Component("wechatPaymentPlugin")
public class WechatPaymentPlugin extends PaymentPlugin {

	@Resource(name = "orderServiceImpl")
	private OrderService orderService;
	
	@Override
	public String getName() {
		return "微信支付";
	}

	@Override
	public String getVersion() {
		return "1.0";
	}

	@Override
	public String getAuthor() {
		return "JSHOP";
	}

	@Override
	public String getSiteUrl() {
		return "http://www.maidehao.com";
	}

	@Override
	public String getInstallUrl() {
		return "wechat_payment/install.jhtml";
	}

	@Override
	public String getUninstallUrl() {
		return "wechat_payment/uninstall.jhtml";
	}

	@Override
	public String getSettingUrl() {
		return "wechat_payment/setting.jhtml";
	}

	@Override
	public String getRequestUrl() {
		return "https://api.mch.weixin.qq.com/pay/unifiedorder";
	}

	@Override
	public PaymentPlugin.RequestMethod getRequestMethod() {
		return PaymentPlugin.RequestMethod.get;
	}

	@Override
	public String getRequestCharset() {
		return "UTF-8";
	}
	
	private String getTradeType() {
		return "NATIVE";
	}

	private String getLocalIp() {
		try {
			InetAddress addr = InetAddress.getLocalHost();			
			LogUtil.info(this, "wechat: local address is: " + addr.getHostAddress());
			return addr.getHostAddress();
		} catch (Exception e) {
			System.out.println(e.toString());
			LogUtil.warn(this, "wechat: " + toString());
		} finally {
		}
		return "127.0.0.1";
	}
	
	@Override
	public Map<String, Object> getParameterMap(String sn, String description, HttpServletRequest request) {
		LogUtil.info(this, "wechat:.. into getParameterMap for wechat payment: paymentLog sn is: " + sn);
		String orderSn = request.getParameter("sn");
		PaymentLog paymentLog = getPaymentLog(sn);
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		//Order order = orderService.findBySn(orderSn);	
		if (paymentLog==null || (paymentLog != null && paymentLog.getAmount() == null)) {
			LogUtil.info(this, "wechat:  Amount is wrong!");
			request.setAttribute("return_code", "failed");
			return parameterMap;
		}
		
		// 商品描述
		String body = orderSn;
		// 商户订单号
		String out_trade_no = orderSn;
		// 订单总金额，单位为分
		String total_fee = String.valueOf((paymentLog.getAmount().multiply(new BigDecimal(100))).intValue()); //String.valueOf(order.getAmount().intValue()); //request.getParameter("totalfee");
		LogUtil.info(this, "wechat:   paymentLog.getAmount().intValue() is: " +  paymentLog.getAmount().intValue() + " total_fee is: " + total_fee);
		// 统一下单
		WechatUnifiedorderReturn orderReturn = placeOrder(body, out_trade_no, total_fee);
		if (orderReturn == null || !(orderReturn.getReturn_code().equals("SUCCESS") && orderReturn.getResult_code().equals("SUCCESS"))) {
			//error happened here!!!
			LogUtil.info(this, "wechat:  Error happened!");
			request.setAttribute("return_code", "failed");
			return parameterMap;
		}
		LogUtil.info(this, "wechat:  return code is: " + orderReturn.getReturn_code() + "  result code is: " + orderReturn.getResult_code());
		
		// 创建支付二维码
		String path = request.getSession().getServletContext().getRealPath("/");
		LogUtil.info(this, "wechat:  path is: " + path);
		String codeFilePath = createCode(path, orderReturn);
		if (null == codeFilePath) {
			LogUtil.info(this, "wechat:  create code failed.  and codeFilePath is: " + codeFilePath);
			request.setAttribute("return_code", "failed");
		}
		LogUtil.info(this, "wechat:  code is: " + codeFilePath);
		
		request.setAttribute("code", codeFilePath);		
		request.setAttribute("out_trade_no", out_trade_no);
		request.setAttribute("return_code", "success");		
		return parameterMap;
	}

	@Override
	public boolean verifyNotify(PaymentPlugin.NotifyMethod notifyMethod, HttpServletRequest request) {
		LogUtil.info(this, "wechat:.. into verifyNotify for paymentplugin ");
		return true;		
	}

	@Override
	public String getSn(HttpServletRequest request) {
		return request.getParameter("out_trade_no");
	}

	@Override
	public String getNotifyMessage(PaymentPlugin.NotifyMethod notifyMethod, HttpServletRequest request) {
		if (PaymentPlugin.NotifyMethod.async.equals(notifyMethod)) {
			return "success";
		}
		return null;
	}
	
	/**
	 * 获取通知URL
	 * 
	 * @param notifyMethod
	 *            通知方法
	 * @return 通知URL
	 */
	@Override
	protected String getNotifyUrl(PaymentPlugin.NotifyMethod notifyMethod) {
		Setting setting = SystemUtils.getSetting();
		if (notifyMethod != null) {
			return setting.getSiteUrl() + "/payment/plugin_notify/" + getId() + "/" + notifyMethod + ".jhtml";
		} else {
			return setting.getSiteUrl() + "/payment/plugin_notify/" + getId() + "/" + PaymentPlugin.NotifyMethod.general + ".jhtml";
		}
	}

	/**
	 * 生成签名
	 * 
	 * @param parameterMap
	 *            参数
	 * @return 签名
	 */
	private String generateSign(Map<String, ?> parameterMap) {
		PluginConfig pluginConfig = getPluginConfig();
		return DigestUtils.md5Hex(joinKeyValue(new TreeMap<String, Object>(parameterMap), null, pluginConfig.getAttribute("key"), "&", true, "sign_type", "sign"));
	}

	/**
	 * 
	 * @Title: placeOrder
	 * @Description: 统一下单
	 * @param body
	 *            商品描述
	 * @param out_trade_no
	 *            商户订单号
	 * @param total_fee
	 *            订单总金额，单位为分
	 * @return
	 * @throws Exception
	 * @return: OrderReturn
	 */
	private WechatUnifiedorderReturn placeOrder(String body, String out_trade_no, String total_fee) {
		PluginConfig pluginConfig = getPluginConfig();
		LogUtil.info(this, "wechat: total_fee is:  " + total_fee  + ";  notify url is: " + getNotifyUrl(PaymentPlugin.NotifyMethod.async));
		// 判断有没有输入订单总金额，没有输入 则返回null
		if (total_fee != null && total_fee.equals("")) {
			LogUtil.info(this, "wechat: didn't init total fee");
			return null;
		}
		
		// 生成订单对象
		WechatUnifiedorder o = new WechatUnifiedorder();
		// 随机字符串
		String nonce_str = UUID.randomUUID().toString().trim().replaceAll("-", "");
		o.setAppid(pluginConfig.getAttribute("appid"));
		o.setBody(body);
		o.setMch_id(pluginConfig.getAttribute("mch_id"));
		o.setNotify_url(getNotifyUrl(PaymentPlugin.NotifyMethod.async));
		o.setOut_trade_no(out_trade_no);
		o.setTotal_fee(Integer.parseInt(total_fee));
		o.setNonce_str(nonce_str);
		o.setTrade_type(getTradeType());
		o.setSpbill_create_ip(getLocalIp());
		
		SortedMap<Object, Object> p = new TreeMap<Object, Object>();
		p.put("appid", pluginConfig.getAttribute("appid"));
		p.put("mch_id", pluginConfig.getAttribute("mch_id"));
		p.put("body", body);
		p.put("nonce_str", nonce_str);
		p.put("out_trade_no", out_trade_no);
		p.put("total_fee", Integer.parseInt(total_fee));
		p.put("spbill_create_ip", getLocalIp());
		p.put("notify_url", getNotifyUrl(PaymentPlugin.NotifyMethod.async));
		p.put("trade_type", getTradeType());
		// 得到签名
		String sign = Sign.createSign("utf-8", p, pluginConfig.getAttribute("key"));
		o.setSign(sign);
		
		WechatUnifiedorderReturn or = null;
		try {
			// Object转换为XML
			String xml = XmlUtil.object2Xml(o, WechatUnifiedorder.class);
			// 统一下单地址
			String url = getRequestUrl();
			LogUtil.info(this, "wechat:  RequestUrl is:  " + url);
			LogUtil.info(this, "wechat:  Request parameter is:  " + xml);

			// 调用微信统一下单地址
			String returnXml = HttpUtil.sendPost(url, xml);
			LogUtil.info(this, "wechat:  order result is:  " + returnXml);

			// XML转换为Object
			or = (WechatUnifiedorderReturn) XmlUtil.xml2Object(returnXml, WechatUnifiedorderReturn.class);
		} catch (Exception e) {
			LogUtil.warn(this, "wechat: into exception when we get the place order");
			e.printStackTrace();
			or = null;
		}
		return or;
	}

	
	/**
	 * 
	 * @Title: createCode
	 * @Description: 生成支付二维码
	 * @param path
	 *            项目绝对路径
	 * @return
	 * @throws Exception
	 * @return: String
	 */
	private String createCode(String path, WechatUnifiedorderReturn orderReturn) {
		String partPath = "upload/QRCode";
		File file = new File(path + partPath);
		if (!file.exists()) {
			file.mkdirs();
		}
		String filePath = null;
		try {
			QRCode q = new QRCode();
			String fileName = UUID.randomUUID().toString();
			filePath = partPath + "/" + fileName + ".png";
			String imgPath = path + filePath;
	
			LogUtil.info(this, "wechat:  imgPath is: \n" + imgPath);
			LogUtil.info(this, "wechat:  orderReturn.getCode_url() is: \n" + orderReturn.getCode_url());
				
			q.encoderQRCode(orderReturn.getCode_url(), imgPath);
		} catch (Exception e1) {
			LogUtil.warn(this, "wechat: into exception");
			e1.printStackTrace();
			filePath = null;
		}
		finally {
			LogUtil.info(this, "wechat: into finally");			
		}
		return filePath;
		
	}
}