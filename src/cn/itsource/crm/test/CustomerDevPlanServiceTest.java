package cn.itsource.crm.test;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.CustomerDevPlan;
import cn.itsource.crm.domain.Employee;
import cn.itsource.crm.domain.PotentialCustomer;
import cn.itsource.crm.domain.SystemDictionaryItem;
import cn.itsource.crm.query.CustomerDevPlanQuery;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.ICustomerDevPlanService;

public class CustomerDevPlanServiceTest extends BaseServiceTest {

	@Autowired
	ICustomerDevPlanService customerDevPlanService;

	@Test
	public void testSave() throws Exception {
		Employee employee = new Employee();
		SystemDictionaryItem item = new SystemDictionaryItem();
		PotentialCustomer p = new PotentialCustomer();
		p.setId(1L);
		item.setId(4L);
		employee.setId(2L);
		for (int i = 2; i < 10; i++) {
			CustomerDevPlan department = new CustomerDevPlan();
			department.setInputUser(employee);
			department.setPlanType(item);
			department.setPlanSubject("来一发");
			department.setPlanDetails("小树林");
			department.setPotentialCustomer(p);
			customerDevPlanService.save(department);
		}
	}

	@Test
	public void testGet() throws Exception {
		System.out.println(customerDevPlanService.get(1L));
		System.out.println("3333333");
	}

	@Test
	public void testGetAll() throws Exception {
		CustomerDevPlanQuery departmentQuery = new CustomerDevPlanQuery();
		PageList findByQuery = customerDevPlanService.findByQuery(departmentQuery);
		System.out.println(findByQuery.getRows().size());
	}
}

