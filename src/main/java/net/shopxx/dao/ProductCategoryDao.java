/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.dao;

import java.util.List;

import net.shopxx.entity.ProductCategory;

/**
 * Dao - 商品分类
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
public interface ProductCategoryDao extends BaseDao<ProductCategory, Long> {
	
	/**
	 * 根据id查找商品分类
	 * 
	 * @param 	id
	 * 			主键
	 */
	ProductCategory  findById(Integer id);
	
	/**
	 * 查找顶级商品分类
	 * 
	 * @param count
	 *            数量
	 * @return 顶级商品分类
	 */
	List<ProductCategory> findRoots(Integer count);

	/**
	 * 查找上级商品分类
	 * 
	 * @param productCategory
	 *            商品分类
	 * @param recursive
	 *            是否递归
	 * @param count
	 *            数量
	 * @return 上级商品分类
	 */
	List<ProductCategory> findParents(ProductCategory productCategory, boolean recursive, Integer count);

	/**
	 * 查找下级商品分类
	 * 
	 * @param productCategory
	 *            商品分类
	 * @param recursive
	 *            是否递归
	 * @param count
	 *            数量
	 * @return 下级商品分类
	 */
	List<ProductCategory> findChildren(ProductCategory productCategory, boolean recursive, Integer count);

}