/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.service;

import java.util.List;

import net.shopxx.entity.ProductCategory;

/**
 * Service - 商品分类
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
public interface ProductCategoryService extends BaseService<ProductCategory, Long> {

	/**
	 * 根据id查找商品分类
	 * 
	 * @param 	id
	 * 			主键
	 */
	ProductCategory  findById(Long id);
	
	/**
	 * 查找顶级商品分类
	 * 
	 * @return 顶级商品分类
	 */
	List<ProductCategory> findRoots();

	/**
	 * 查找顶级商品分类
	 * 
	 * @param count
	 *            数量
	 * @return 顶级商品分类
	 */
	List<ProductCategory> findRoots(Integer count);

	/**
	 * 查找顶级商品分类
	 * 
	 * @param count
	 *            数量
	 * @param useCache
	 *            是否使用缓存
	 * @return 顶级商品分类
	 */
	List<ProductCategory> findRoots(Integer count, boolean useCache);

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
	 * 查找上级商品分类
	 * 
	 * @param productCategoryId
	 *            商品分类ID
	 * @param recursive
	 *            是否递归
	 * @param count
	 *            数量
	 * @param useCache
	 *            是否使用缓存
	 * @return 上级商品分类
	 */
	List<ProductCategory> findParents(Long productCategoryId, boolean recursive, Integer count, boolean useCache);

	/**
	 * 查找商品分类树
	 * 
	 * @return 商品分类树
	 */
	List<ProductCategory> findTree();

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

	/**
	 * 查找下级商品分类
	 * 
	 * @param productCategoryId
	 *            商品分类ID
	 * @param recursive
	 *            是否递归
	 * @param count
	 *            数量
	 * @param useCache
	 *            是否使用缓存
	 * @return 下级商品分类
	 */
	List<ProductCategory> findChildren(Long productCategoryId, boolean recursive, Integer count, boolean useCache);

}