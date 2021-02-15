package com.atguigu.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;

	@Autowired
	EmployeeMapper employeeMapper;

	@Autowired
	SqlSession sqlSession;

	@Test
	public void testCRUD() {

		// Insert records to table dept
		departmentMapper.insertSelective(new Department(null, "Developement Department"));
		departmentMapper.insertSelective(new Department(null, "Test Department"));

		System.out.println(departmentMapper);
	}

	@Test
	public void testCRUD1() {
		// Insert records to table emp
		employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "jerry@hotmail.com", 1));
		employeeMapper.insertSelective(new Employee(null, "Tom", "M", "tom@hotmail.com", 2));
	}

	@Test
	public void testCRUDBatch() {
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 50; i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5) + i;
			mapper.insertSelective(new Employee(null, uid, "M", uid + "@hotmail.com", 1));
		}
		System.out.println("Success");
	}

}
