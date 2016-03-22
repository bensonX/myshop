/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.dao;

import java.util.List;

import net.shopxx.entity.Navigation;

/**
 * Dao - 导航
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
public interface NavigationDao extends BaseDao<Navigation, Long> {

	/**
	 * 查找导航
	 * 
	 * @param position
	 *            位置
	 * @return 导航
	 */
	List<Navigation> findList(Navigation.Position position);

}