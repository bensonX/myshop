/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.service;

import java.util.List;

import net.shopxx.Theme;

import org.springframework.web.multipart.MultipartFile;

/**
 * Service - 主题
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
public interface ThemeService {

	/**
	 * 获取所有主题
	 * 
	 * @return 所有主题
	 */
	List<Theme> getAll();

	/**
	 * 获取主题
	 * 
	 * @param id
	 *            ID
	 * @return 主题
	 */
	Theme get(String id);

	/**
	 * 上传主题
	 * 
	 * @param multipartFile
	 *            上传文件
	 * @return 是否上传成功
	 */
	boolean upload(MultipartFile multipartFile);

}