/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.listener;

import java.io.File;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

import net.shopxx.service.ConfigService;
import net.shopxx.service.SearchService;
import net.shopxx.service.StaticService;
import net.shopxx.util.LogUtil;

/**
 * Listener - 初始化
 * 
 * @author JSHOP Team \* @version 3.X
 */
@Component("initListener")
public class InitListener implements ServletContextAware, ApplicationListener<ContextRefreshedEvent> {

	/** 安装初始化配置文件 */
	private static final String INSTALL_INIT_CONFIG_FILE_PATH = "/install_init.conf";

	/** ServletContext */
	private ServletContext servletContext;

	@Value("${system.version}")
	private String systemVersion;
	@Resource(name = "configServiceImpl")
	private ConfigService configService;
	@Resource(name = "staticServiceImpl")
	private StaticService staticService;
	@Resource(name = "searchServiceImpl")
	private SearchService searchService;

	/**
	 * 设置ServletContext
	 * 
	 * @param servletContext
	 *            ServletContext
	 */
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	/**
	 * 事件执行
	 * 
	 * @param contextRefreshedEvent
	 *            ContextRefreshedEvent
	 */
	public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
		if (servletContext != null && contextRefreshedEvent.getApplicationContext().getParent() == null) {
			String info = "I|n|i|t|i|a|l|i|z|i|n|g| |S|H|O|P|+|+| |" + systemVersion;
			String infoStr = info.replace("|", "");
			LogUtil.debug(this, infoStr);
			configService.init();
			File installInitConfigFile = new File(servletContext.getRealPath(INSTALL_INIT_CONFIG_FILE_PATH));
			if (installInitConfigFile.exists()) {
				LogUtil.debug(this, "初始化所有静态内容");
				staticService.generateAll();
				searchService.purge();
				searchService.index();
				installInitConfigFile.delete();
			} else {
				LogUtil.debug(this, "初始化首页");
				staticService.generateIndex();
				staticService.generateOther();
			}
		}
	}

}