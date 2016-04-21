/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.template.method;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Component;

import freemarker.template.SimpleScalar;
import freemarker.template.TemplateMethodModelEx;
import freemarker.template.TemplateModelException;
import net.shopxx.util.FreeMarkerUtils;

/**
 * 比率格式化
 * 
 * @author sunmaolin
 *
 */
@Component("rateMethod")
public class RateMethod implements TemplateMethodModelEx {

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
		if (amount != null) {
			String sign = "%";
			amount = amount.multiply(new BigDecimal(100));
			amount.setScale(2, BigDecimal.ROUND_HALF_UP);
			return new SimpleScalar(amount.toString() + sign);
		}
		return null;
	}
}