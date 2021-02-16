package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.bean.EmployeeExample.Criteria;
import com.atguigu.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;

	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void save(Employee emp) {
		employeeMapper.insertSelective(emp);
	}

	/**
	 * A method to check whether an empName already exists.
	 * 
	 * @param empName
	 * @return true if an empName doesn't exist.
	 */
	public boolean checkEmpName(String empName) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * A method to check whether an email already exists.
	 * 
	 * @param email
	 * @return true if an email doesn't exist.
	 */
	public boolean checkEmpEmail(String email) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmailEqualTo(email);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}

	/**
	 * Select employee by id
	 * 
	 * @param id
	 * @return
	 */
	public Employee getEmpById(Integer id) {
		Employee emp = employeeMapper.selectByPrimaryKey(id);
		return emp;
	}

	/**
	 * Update employee by id
	 * 
	 * @param emp
	 */
	public void updateEmp(Employee emp) {
		employeeMapper.updateByPrimaryKeySelective(emp);
	}

}
