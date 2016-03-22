/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.dao;

import java.util.Date;
import java.util.List;

import net.shopxx.entity.Statistic;

/**
 * Dao - 统计
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
public interface StatisticDao extends BaseDao<Statistic, Long> {

	/**
	 * 判断统计是否存在
	 * 
	 * @param year
	 *            年
	 * @param month
	 *            月
	 * @param day
	 *            日
	 * @return 统计是否存在
	 */
	boolean exists(int year, int month, int day);

	/**
	 * 分析
	 * 
	 * @param period
	 *            周期
	 * @param beginDate
	 *            起始日期
	 * @param endDate
	 *            结束日期
	 * @return 统计
	 */
	List<Statistic> analyze(Statistic.Period period, Date beginDate, Date endDate);

}