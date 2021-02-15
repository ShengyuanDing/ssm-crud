package com.atguigu.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.atguigu.crud.bean.Employee;
import com.github.pagehelper.PageInfo;

/**
 * Test the Request using Spring test
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath:applicationContext.xml", "file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml" })
public class MVCTest {
	// get Spring IOC
	@Autowired
	WebApplicationContext context;

	MockMvc mockMvc;

	@Before
	public void getMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}

	@Test
	public void testPages() throws Exception {
		MvcResult mvcResult = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5")).andReturn();
		MockHttpServletRequest request = mvcResult.getRequest();
		PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
		System.out.println("Current page: " + pageInfo.getPageNum());
		System.out.println("Total pages: " + pageInfo.getPages());
		System.out.println("Total records: " + pageInfo.getTotal());

		// Get the pages needed to be shown
		System.out.println("====page nubmers to be shown====");
		int[] nums = pageInfo.getNavigatepageNums();
		for (int i = 0; i < nums.length; i++) {
			System.out.print(" " + i);
		}
		
		//Get the information of the employees
		List<Employee> list = pageInfo.getList();
		for(Employee e : list) {
			System.out.println("ID: " + e.getdId() + ", Name: " + e.getEmpName());
		}
	}
}
