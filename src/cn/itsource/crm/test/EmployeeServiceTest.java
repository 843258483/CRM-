package cn.itsource.crm.test;

import java.util.Date;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.Employee;
import cn.itsource.crm.service.IEmployeeService;

public class EmployeeServiceTest extends BaseServiceTest{

	@Autowired
	IEmployeeService employeeService;

	@Test
	public void save() throws Exception {
		for (int i = 1; i < 20; i++) {
			Employee employee = new Employee();
			employee.setUsername("admin"+i);
			employee.setRealName("admin"+i);
			employee.setPassword("admin"+i);
			employee.setTel("123456"+i);
			employee.setState(0);
			employee.setEmail("admin"+i+"Champion@qq.com");
			employee.setInputTime(new Date());
			employeeService.save(employee);
		}
//		BaseQuery baseQuery = new EmployeeQuery();
//		PageList list = employeeService.findByQuery(baseQuery);
//		System.out.println(list);
//		System.out.println(list.getRows().size());
//		Employee user = employeeService.findByLoginUser("007", "admin7");
//		System.out.println(user);
//		HttpSession httpSession = UserContext.getSession();
//		Employee employee = UserContext.getEmployee(httpSession);
//		System.out.println(employee);
		
		
	}
}
