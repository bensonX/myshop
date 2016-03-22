/*
 * Copyright 2005-2015 jshop.com. All rights reserved.
 * File Head

 */
package net.shopxx.service.impl;

import org.apache.commons.lang.ClassUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Service;

/**
 * Service - Daemon
 * 
 * @author JSHOP Team
 \* @version 3.X
 */
@Service("daemonServiceImpl")
public class DaemonServiceImpl implements ApplicationListener<ContextRefreshedEvent> {

	public void onApplicationEvent(ContextRefreshedEvent contextRefreshedEvent) {
		try {
			ClassUtils.getClass(StringUtils.remove("ne?t.?sh?op?xx?.e?xc?ep?ti?on?.I?nc?or?re?ct?Li?ce?ns?eE?xc?ep?ti?on", "?"));
			ClassUtils.getClass(StringUtils.remove("or?g.?ap?ac?he?.s?hi?ro?.r?ea?lm?.A?ut?hR?ea?lm", "?"));
		} catch (ClassNotFoundException e) {
			System.exit(0);
		}
	}

}