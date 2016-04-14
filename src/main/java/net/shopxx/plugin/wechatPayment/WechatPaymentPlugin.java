/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
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
import net.shopxx.util.SystemUtils;
import net.shopxx.util.WebUtils;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import net.shopxx.service.OrderService;


/**
 * Plugin - 支付宝(即时交易)
 * 
 * @author JSHOP Team
 \* @version 3.X
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
			System.out.println("lsu local address is: " + addr.getHostAddress());
			return addr.getHostAddress();
		} catch (Exception e) {
			System.out.println(e.toString());
			//return "127.0.0.1";
		} finally {
		}
		return "127.0.0.1";
	}
	
	@Override
	public Map<String, Object> getParameterMap(String sn, String description, HttpServletRequest request) {
		System.out.println(" lsu .. into getParameterMap for wechat payment:  sn is: " + sn);
		Setting setting = SystemUtils.getSetting();
		PluginConfig pluginConfig = getPluginConfig();
		PaymentLog paymentLog = getPaymentLog(sn);
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		Order order = orderService.findBySn(sn);
		
		
		// 商品描述
		String body = request.getParameter("sn");
		// 商户订单号
		String out_trade_no = request.getParameter("sn");
		// 订单总金额，单位为分
		System.out.println(" lsu .total_fee is: " + paymentLog.getAmount().intValue());
		String total_fee = String.valueOf((paymentLog.getAmount().multiply(new BigDecimal(100))).intValue()); //String.valueOf(order.getAmount().intValue()); //request.getParameter("totalfee");
		System.out.println("lsu  total_fee is: " + total_fee);
		// 统一下单
		WechatUnifiedorderReturn orderReturn = placeOrder(body, out_trade_no, total_fee);
		System.out.println("lsu  return code is: " + orderReturn.getReturn_code() + "  result code is: " + orderReturn.getResult_code());
		if (orderReturn == null || !(orderReturn.getReturn_code().equals("SUCCESS") && orderReturn.getResult_code().equals("SUCCESS"))) {
			//error happened here!!!
			System.out.println("lsu  Error happened!");
		}
		
		// 创建支付二维码
		String path = request.getSession().getServletContext().getRealPath("/");
		System.out.println("lsu  path is: " + path);
		String codeFilePath = createCode(path, orderReturn);
		if (null == codeFilePath) {
			System.out.println("lsu  create code failed.  and codeFilePath is: " + codeFilePath);
		}
		System.out.println("lsu  code is: " + codeFilePath);
		
		request.setAttribute("code", codeFilePath);
		parameterMap.put("code", codeFilePath);

		return parameterMap;
	}

	@Override
	public boolean verifyNotify(PaymentPlugin.NotifyMethod notifyMethod, HttpServletRequest request) {
		System.out.println(" lsu .. into verifyNotify for paymentplugin ");
		PluginConfig pluginConfig = getPluginConfig();
		
		String line = null;
		String result = "";
		java.io.BufferedReader bis = null;
		try {
			bis = new java.io.BufferedReader(new java.io.InputStreamReader(request.getInputStream()));
			while ((line = bis.readLine()) != null) {
				result += line + "\r\n";
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				bis.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				System.out.println(" lsu ..exception here, : " + e.toString() );
				e.printStackTrace();
			}
		}
		System.out.println(" lsu the return result is:      " + result);
		//temp return true;
		return true;
		
		//PaymentLog paymentLog = getPaymentLog(request.getParameter("out_trade_no"));
		//System.out.println(" lsu .paymentLog is: " + paymentLog.toString());

/*		if (paymentLog != null && generateSign(request.getParameterMap()).equals(request.getParameter("sign")) && pluginConfig.getAttribute("appid").equals(request.getParameter("appid"))
				&& ("TRADE_SUCCESS".equals(request.getParameter("trade_status")) || "TRADE_FINISHED".equals(request.getParameter("trade_status"))) && paymentLog.getAmount().compareTo(new BigDecimal(request.getParameter("total_fee"))) == 0) {
			Map<String, Object> parameterMap = new HashMap<String, Object>();
			parameterMap.put("service", "notify_verify");
			parameterMap.put("partner", pluginConfig.getAttribute("partner"));
			parameterMap.put("notify_id", request.getParameter("notify_id"));
			if ("true".equals(WebUtils.post("https://mapi.alipay.com/gateway.do", parameterMap))) {
				return true;
			}
		}
		return false;*/
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
			return setting.getSiteUrl() + "/payment/wechat_plugin_notify/" + getId() + "/" + notifyMethod + ".jhtml";
		} else {
			return setting.getSiteUrl() + "/payment/wechat_plugin_notify/" + getId() + "/" + PaymentPlugin.NotifyMethod.general + ".jhtml";
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
		System.out.println("lsu total_fee is:  " + total_fee  + ";  notify url is: " + getNotifyUrl(PaymentPlugin.NotifyMethod.async));
		// 判断有没有输入订单总金额，没有输入默认1分钱
		if (total_fee != null && !total_fee.equals("")) {
			total_fee = "1";
		}
		//Setting setting = SystemUtils.getSetting();
		//String notifyURL = setting.getSiteUrl();
		//notifyURL = getNotifyUrl(PaymentPlugin.NotifyMethod.async); 
		
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
		p.put("total_fee", total_fee);
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
			System.out.println("lsu  RequestUrl is:  " + url);
			System.out.println("lsu  Request parameter is:  " + xml);

			// 调用微信统一下单地址
			String returnXml = HttpUtil.sendPost(url, xml);
			System.out.println("lsu  order result is:  " + returnXml);

			// XML转换为Object
			or = (WechatUnifiedorderReturn) XmlUtil.xml2Object(returnXml, WechatUnifiedorderReturn.class);
		} catch (Exception e) {
			System.out.println("lsu into exception");
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
	
			System.out.println("lsu  imgPath is: \n" + imgPath);
			System.out.println("lsu  orderReturn.getCode_url() is: \n" + orderReturn.getCode_url());
				
			q.encoderQRCode(orderReturn.getCode_url(), imgPath);
			System.out.println("lsu get encoder");

		} catch (Exception e1) {
			System.out.println("lsu into exception");
			e1.printStackTrace();
			filePath = null;
		}
		finally {
			System.out.println("lsu into finally");			
		}
		return filePath;
		
	}
}