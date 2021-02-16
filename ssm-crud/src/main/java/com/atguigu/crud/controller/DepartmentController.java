package com.atguigu.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.DepartmentService;

/**
 * Handle requests related to department information
 *
 */

@Controller
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;

	/**
	 * Return all department information
	 */

	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		List<Department> list = departmentService.getAll();
		return Msg.success().add("departments", list);
	}
}
