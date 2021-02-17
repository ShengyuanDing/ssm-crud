package com.atguigu.crud.controller;

import java.util.ArrayList;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import jakarta.validation.Valid;

/**
 * 
 * Handle CRUD request
 *
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	/**
	 * delete an employee by Id
	 */
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("id") String ids) {
		if (ids.contains("-")) {
			String[] del_ids = ids.split("-");
			List<Integer> delIds = new ArrayList<Integer>();
			for (String s : del_ids) {
				delIds.add(Integer.parseInt(s));
			}
			employeeService.batchDelete(delIds);
		} else {
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmpById(id);
		}
		return Msg.success();
	}

	/**
	 * update an employee by Id
	 */
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee emp) {
		employeeService.updateEmp(emp);
		return Msg.success();
	}

	/**
	 * query an employee by Id and return query result
	 */
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable Integer id) {
		Employee emp = employeeService.getEmpById(id);
		return Msg.success().add("employee", emp);
	}

	/**
	 * check if a employee name already exists.
	 */
	@RequestMapping("/checkname")
	@ResponseBody
	public Msg checkname(@RequestParam("empName") String empName) {
		String regex = "^[a-zA-Z0-9_-]{3,16}$";
		if (!empName.matches(regex)) {
			return Msg.fail().add("va_msg", "Invalid name");
		}
		boolean b = employeeService.checkEmpName(empName);
		if (b) {
			return Msg.success();
		} else {
			return Msg.fail().add("va_msg", "Invalid name");
		}
	}

	/**
	 * check if a employee name already exists.
	 */
	@RequestMapping("/checkemail")
	@ResponseBody
	public Msg checkemail(@RequestParam("email") String email) {
		String regex = "^([a-zA-Z0-9_\\.-]+)@([a-zA-Z0-9-]+)\\.([a-z\\.]{2,6})$";
		if (!email.matches(regex)) {
			return Msg.fail().add("va_msg", "Invalid email address");
		}
		boolean b = employeeService.checkEmpEmail(email);
		if (b) {
			return Msg.success();
		} else {
			return Msg.fail().add("va_msg", "Invalid email address");
		}
	}

	/**
	 * Save a new emp
	 * 
	 */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg empSave(@Valid Employee emp, BindingResult result) {
		if (result.hasErrors()) {
			// failed to pass validation, return error message
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> fieldErrors = result.getFieldErrors();
			for (FieldError fr : fieldErrors) {
				map.put(fr.getField(), fr.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		} else {
			employeeService.save(emp);
			return Msg.success();
		}
	}

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

	// Using above method to handle /emps request
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
