/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx;

/**
 * 公共参数
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
public final class CommonAttributes {

	/** 日期格式配比 */
	public static final String[] DATE_PATTERNS = new String[] { "yyyy", "yyyy-MM", "yyyyMM", "yyyy/MM", "yyyy-MM-dd", "yyyyMMdd", "yyyy/MM/dd", "yyyy-MM-dd HH:mm:ss", "yyyyMMddHHmmss", "yyyy/MM/dd HH:mm:ss" };

	/** jshop.xml文件路径 */
	public static final String JSHOP_XML_PATH = "/jshop.xml";

	/** jshop.properties文件路径 */
	public static final String SHOPXX_PROPERTIES_PATH = "/jshop.properties";

	/**
	 * 不可实例化
	 */
	private CommonAttributes() {
	}

}