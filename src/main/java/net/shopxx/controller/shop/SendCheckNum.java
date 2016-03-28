package net.shopxx.controller.shop;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.apache.commons.lang.StringUtils;

import com.taobao.api.DefaultTaobaoClient;
import com.taobao.api.TaobaoClient;
import com.taobao.api.request.AlibabaAliqinFcSmsNumSendRequest;
import com.taobao.api.response.AlibabaAliqinFcSmsNumSendResponse;

@Path("register")
public class SendCheckNum {

	@Path("checkNumber")
	@GET
    @Produces(MediaType.TEXT_PLAIN)
    //@Produces({ MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML })
	public String sendCheckNum(){
		System.out.println("phone:");		
		return "test";
	}
}
