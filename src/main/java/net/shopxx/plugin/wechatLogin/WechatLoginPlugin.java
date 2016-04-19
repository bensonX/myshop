/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.plugin.wechatLogin;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import net.shopxx.entity.PluginConfig;
import net.shopxx.plugin.LoginPlugin;
import net.shopxx.util.JsonUtils;
import net.shopxx.util.WebUtils;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.JsonNode;

/**
 * Plugin - QQ登录
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Component("wechatLoginPlugin")
public class WechatLoginPlugin extends LoginPlugin {

	/** "状态"属性名称 */
	private static final String STATE_ATTRIBUTE_NAME = WechatLoginPlugin.class.getName() + ".STATE";

	/** "openId"配比 */
	private static final Pattern OPEN_ID_PATTERN = Pattern.compile("\"openid\"\\s*:\\s*\"(\\S*?)\"");

	@Override
	public String getName() {
		return "Wechat登录";
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
		return "http://wxdev.maidehao.com";
	}

	@Override
	public String getInstallUrl() {
		return "wechat_login/install.jhtml";
	}

	@Override
	public String getUninstallUrl() {
		return "wechat_login/uninstall.jhtml";
	}

	@Override
	public String getSettingUrl() {
		return "wechat_login/setting.jhtml";
	}

	@Override
	public String getRequestUrl() {
		return "https://open.weixin.qq.com/connect/qrconnect";
	}

	@Override
	public LoginPlugin.RequestMethod getRequestMethod() {
		return LoginPlugin.RequestMethod.get;
	}

	@Override
	public String getRequestCharset() {
		return "UTF-8";
	}

	@Override
	public Map<String, Object> getParameterMap(HttpServletRequest request) {
		System.out.println(" lsu .. into getParameterMap: ");
		PluginConfig pluginConfig = getPluginConfig();
		String state = DigestUtils.md5Hex(UUID.randomUUID() + RandomStringUtils.randomAlphabetic(30));
		request.getSession().setAttribute(STATE_ATTRIBUTE_NAME, state);
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		parameterMap.put("appid", pluginConfig.getAttribute("oauthKey"));
		parameterMap.put("redirect_uri", getNotifyUrl());
		parameterMap.put("response_type", "code");
		parameterMap.put("scope", "snsapi_login");		
		parameterMap.put("state", state + "#wechat_redirect");
		return parameterMap;
	}

	@Override
	public boolean verifyNotify(HttpServletRequest request) {
		System.out.println(" lsu .. into verifyNotify: ");
		String state = (String) request.getSession().getAttribute(STATE_ATTRIBUTE_NAME);
		if (StringUtils.isNotEmpty(state) && StringUtils.equals(state, request.getParameter("state")) && StringUtils.isNotEmpty(request.getParameter("code"))) {
			request.getSession().removeAttribute(STATE_ATTRIBUTE_NAME);
			PluginConfig pluginConfig = getPluginConfig();
			Map<String, Object> parameterMap = new HashMap<String, Object>();
			parameterMap.put("appid", pluginConfig.getAttribute("oauthKey"));
			parameterMap.put("secret", pluginConfig.getAttribute("oauthSecret"));
			parameterMap.put("code", request.getParameter("code"));
			parameterMap.put("grant_type", "authorization_code");
			String content = WebUtils.get("https://api.weixin.qq.com/sns/oauth2/access_token", parameterMap);
			System.out.println(" lsu .. content is: " + content);
			JsonNode jsonNode = JsonUtils.toTree(content);
			String accessToken = jsonNode.get("access_token").textValue();
			String openId = jsonNode.get("openid").textValue();
			String unionId = jsonNode.get("unionid").textValue();
			System.out.println(" lsu .. verifyNotify  accessToken is: " + accessToken);
			if (StringUtils.isNotEmpty(accessToken)) {
				System.out.println(" lsu . verifyNotify  set openId");
				request.setAttribute("accessToken", accessToken);
				request.setAttribute("openId", openId);
				request.setAttribute("unionId", unionId);
				return true;
			}
		}
		return false;
	}

	@Override
	public String getOpenId(HttpServletRequest request) {		
		String openId = request.getAttribute("openId").toString();
		return openId;
	}

	@Override
	public String getEmail(HttpServletRequest request) {
		return null;
	}

	@Override
	public String getNickname(HttpServletRequest request) {
		Map<String, Object> parameterMap = new HashMap<String, Object>();
		parameterMap.put("access_token", request.getAttribute("accessToken"));
		String content = WebUtils.get("https://api.weixin.qq.com/sns/userinfo", parameterMap);
		JsonNode jsonNode = JsonUtils.toTree(content);
		return jsonNode.has("nickname") ? jsonNode.get("nickname").textValue() : null;
	}

}