package net.shopxx.util;

import org.slf4j.LoggerFactory;

/**
 * 日志工具类
 * 
 * @author sunmaolin(sunmaolin@langbank.cn)
 *
 */
public class LogUtil {

	/**
	 * 使用debug级别打印日志
	 * 
	 * @param source
	 *            打印日志的类
	 * @param message
	 *            日志内容
	 * @param ex
	 *            异常信息
	 */
	public static <T> void debug(Class<T> source, String message, Throwable... ex) {
		if (ex != null && ex.length > 0) {
			LoggerFactory.getLogger(source).debug(message, ex[0]);
		} else {
			LoggerFactory.getLogger(source).debug(message);
		}
	}

	/**
	 * 使用debug级别打印日志
	 * 
	 * @param obj
	 *            打印日志的对象
	 * @param message
	 *            日志内容
	 * @param ex
	 *            错误信息
	 */
	public static void debug(Object obj, String message, Throwable... ex) {
		if (obj == null) return;
		debug(obj.getClass(), message, ex);
	}

	/**
	 * 使用info级别打印日志
	 * 
	 * @param source
	 *            打印日志的类
	 * @param message
	 *            日志内容
	 * @param ex
	 *            异常信息
	 */
	public static <T> void info(Class<T> source, String message, Throwable... ex) {
		if (ex != null && ex.length > 0) {
			LoggerFactory.getLogger(source).info(message, ex[0]);
		} else {
			LoggerFactory.getLogger(source).info(message);
		}
	}

	/**
	 * 使用info级别打印日志
	 * 
	 * @param obj
	 *            打印日志的对象
	 * @param message
	 *            日志内容
	 * @param ex
	 *            异常信息
	 */
	public static void info(Object obj, String message, Throwable... ex) {
		if (obj == null) return;
		info(obj.getClass(), message, ex);
	}

	/**
	 * 使用warn级别打印日志
	 * 
	 * @param source
	 *            打印日志的类
	 * @param message
	 *            日志内容
	 * @param ex
	 *            异常信息
	 */
	public static <T> void warn(Class<T> source, String message, Throwable... ex) {
		if (ex != null && ex.length > 0) {
			LoggerFactory.getLogger(source).warn(message, ex[0]);
		} else {
			LoggerFactory.getLogger(source).warn(message);
		}
	}

	/**
	 * 使用warn级别打印日志
	 * 
	 * @param obj
	 *            打印日志的对象
	 * @param message
	 *            日志内容
	 * @param ex
	 *            异常信息
	 */
	public static void warn(Object obj, String message, Throwable... ex) {
		if (obj == null) return;
		warn(obj.getClass(), message, ex);
	}

	/**
	 * 使用error级别打印日志
	 * 
	 * @param source
	 *            打印日志的类
	 * @param message
	 *            日志内容
	 * @param ex
	 *            异常信息
	 */
	public static <T> void error(Class<T> source, String message, Throwable... ex) {
		if (ex != null && ex.length > 0) {
			LoggerFactory.getLogger(source).error(message, ex[0]);
		} else {
			LoggerFactory.getLogger(source).error(message);
		}
	}

	/**
	 * 使用error级别打印日志
	 * 
	 * @param obj
	 *            打印日志的对象
	 * @param message
	 *            日志内容
	 * @param ex
	 *            异常信息
	 */
	public static void error(Object obj, String message, Throwable... ex) {
		if (obj == null) return;
		error(obj.getClass(), message, ex);
	}

	/**
	 * 使用trace级别打印日志
	 * 
	 * @param source
	 *            打印日志的类
	 * @param message
	 *            日志内容
	 * @param ex
	 *            异常信息
	 */
	public static <T> void trace(Class<T> source, String message, Throwable... ex) {
		if (ex != null && ex.length > 0) {
			LoggerFactory.getLogger(source).trace(message, ex[0]);
		} else {
			LoggerFactory.getLogger(source).trace(message);
		}
	}

	/**
	 * 使用trace级别打印日志
	 * 
	 * @param obj
	 *            打印日志的对象
	 * @param message
	 *            日志内容
	 * @param ex
	 *            异常信息
	 */
	public static void trace(Object obj, String message, Throwable... ex) {
		if (obj == null) return;
		trace(obj.getClass(), message, ex);
	}

}