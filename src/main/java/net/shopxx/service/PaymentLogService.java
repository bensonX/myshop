/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.service;

import net.shopxx.entity.PaymentLog;

/**
 * Service - 支付记录
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
public interface PaymentLogService extends BaseService<PaymentLog, Long> {

	/**
	 * 根据编号查找支付记录
	 * 
	 * @param sn
	 *            编号(忽略大小写)
	 * @return 支付记录，若不存在则返回null
	 */
	PaymentLog findBySn(String sn);

	/**
	 * 支付处理
	 * 
	 * @param paymentLog
	 *            支付记录
	 */
	void handle(PaymentLog paymentLog);

}