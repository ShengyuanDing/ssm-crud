package com.atguigu.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 
 * Handle CRUD request
 *
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
		// Define the start page and the size of the page
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll();
		// Use PageInfo to show results according to size of the page
		PageInfo page = new PageInfo(emps, 5);
		// Use Msg to send response data to a request
		return Msg.success().add("pageInfo", page);
	}

	//Using above method to handle /emps request
//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		// Define the start page and the size of the page
		PageHelper.startPage(pn, 5);
		List<Employee> emps = employeeService.getAll();
		// Use PageInfo to show results according to size of the page
		PageInfo page = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", page);
		return "list";
	}

}
