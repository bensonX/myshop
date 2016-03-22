/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.template.method;

import java.math.BigDecimal;
import java.util.List;

import net.shopxx.Setting;
import net.shopxx.util.FreeMarkerUtils;
import net.shopxx.util.SystemUtils;

import org.springframework.stereotype.Component;

import freemarker.template.SimpleScalar;
import freemarker.template.TemplateMethodModelEx;
import freemarker.template.TemplateModelException;

/**
 * 模板方法 - 货币格式化
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Component("currencyMethod")
public class CurrencyMethod implements TemplateMethodModelEx {

	/**
	 * 执行
	 * 
	 * @param arguments
	 *            参数
	 * @return 结果
	 */
	@SuppressWarnings("rawtypes")
	public Object exec(List arguments) throws TemplateModelException {
		BigDecimal amount = FreeMarkerUtils.getArgument(0, BigDecimal.class, arguments);
		Boolean showSign = FreeMarkerUtils.getArgument(1, Boolean.class, arguments);
		Boolean showUnit = FreeMarkerUtils.getArgument(2, Boolean.class, arguments);
		if (amount != null) {
			Setting setting = SystemUtils.getSetting();
			String price = setting.setScale(amount).toString();
			if (showSign != null && showSign) {
				price = setting.getCurrencySign() + price;
			}
			if (showUnit != null && showUnit) {
				price += setting.getCurrencyUnit();
			}
			return new SimpleScalar(price);
		}
		return null;
	}

}