package cn.itsource.crm.test;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.Department;
import cn.itsource.crm.query.DepartmentQuery;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.IDepartmentService;

public class DepartmentServiceTest extends BaseServiceTest{

	@Autowired
	IDepartmentService departmentService;

	@Test
	public void testSave() throws Exception {
		for (int i = 0; i < 10; i++) {
			Department department = new Department();
			department.setName("dept" + i);
			department.setSn("123" + i);
			department.setDirPath("123" + i);
			departmentService.save(department);
		}
	}

	@Test
	public void testGet() throws Exception {
		System.out.println(departmentService.get(1L));
		
//		List<Department> list2 = departmentService.getEmployeeBySaleJob();
//		for (Object object : list2) {
//			System.out.println(object);
//		}
		
//		System.out.println("3333333");
	}

	@Test
	public void testGetAll() throws Exception {
		DepartmentQuery departmentQuery = new DepartmentQuery();
//		System.out.println(departmentService.findByQuery(departmentQuery));
		PageList list = departmentService.findByQuery(departmentQuery);
		List rows = list.getRows();
		for (Object object : rows) {
			System.out.println(object);
		}
	}
}

