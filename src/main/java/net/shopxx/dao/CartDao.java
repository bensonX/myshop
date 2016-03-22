/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.dao;

import java.util.List;

import net.shopxx.entity.Cart;

/**
 * Dao - 购物车
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
public interface CartDao extends BaseDao<Cart, Long> {

	/**
	 * 根据密钥查找购物车
	 * 
	 * @param key
	 *            密钥
	 * @return 购物车，若不存在则返回null
	 */
	Cart findByKey(String key);

	/**
	 * 查找购物车
	 * 
	 * @param hasExpired
	 *            是否已过期
	 * @param count
	 *            数量
	 * @return 购物车
	 */
	List<Cart> findList(Boolean hasExpired, Integer count);

}