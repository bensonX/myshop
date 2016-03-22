/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 商业
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
public @interface Commercial {

	/**
	 * 序列号
	 */
	String sn();

	/**
	 * 密钥
	 */
	String key();

}