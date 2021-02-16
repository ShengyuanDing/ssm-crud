package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.DepartmentExample;
import com.atguigu.crud.dao.DepartmentMapper;
/**
 * 
 * A class to perform department related crud
 *
 */
@Service
public class DepartmentService {

	@Autowired
	private DepartmentMapper departmentMapper;
	
	public List<Department> getAll() {
		DepartmentExample example = new DepartmentExample();
		example.setDistinct(true);
		List<Department>  deptList = departmentMapper.selectByExample(example);
		return deptList;
	}

}
