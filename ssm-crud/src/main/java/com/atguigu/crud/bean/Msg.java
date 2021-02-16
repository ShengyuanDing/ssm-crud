package com.atguigu.crud.bean;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

/**
 * A class has three fields, Integer code, String message and Map extend, which
 * are used to save information of response code, message, and the json data. It
 * also has two static method to generate an instance of Msg with success code
 * and message and with failure code and message.
 */
@Component
public class Msg {

	/**
	 * Status code, 100:success, 200:failure
	 */
	private Integer code;
	private String message;
	private Map<String, Object> extend = new HashMap<String, Object>();

	public static Msg success() {
		Msg msg = new Msg();
		msg.setCode(100);
		msg.setMessage("success");
		return msg;
	}

	public static Msg fail() {
		Msg msg = new Msg();
		msg.setCode(200);
		msg.setMessage("failure");
		return msg;
	}

	public Msg add(String key, Object value) {
		this.getExtend().put(key, value);
		return this;
	}

	public Msg() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Msg(Integer code, String message, Map<String, Object> extend) {
		super();
		this.code = code;
		this.message = message;
		this.extend = extend;
	}

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}

}
