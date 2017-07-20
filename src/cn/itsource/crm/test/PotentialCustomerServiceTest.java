package cn.itsource.crm.test;

import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.Employee;
import cn.itsource.crm.domain.PotentialCustomer;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.query.PotentialCustomerQuery;
import cn.itsource.crm.service.IPotentialCustomerService;

public class PotentialCustomerServiceTest extends BaseServiceTest {

	@Autowired
	IPotentialCustomerService potentialCustomerService;

	@Test
	public void testSave() throws Exception {
		Employee employee = new Employee();
		employee.setId(1L);
		PotentialCustomer potentialCustomer = potentialCustomerService.get(1L);
		potentialCustomer.setId(null);
		potentialCustomer.setInputUser(employee);
		potentialCustomerService.save(potentialCustomer);
	}

	@Test
	public void testGet() throws Exception {
		PotentialCustomerQuery query = new PotentialCustomerQuery();
		PageList findByQuery = potentialCustomerService.findByQuery(query);
		System.out.println(findByQuery.getTotal());
		
		List<PotentialCustomer> rows = findByQuery.getRows();
		for (PotentialCustomer potentialCustomer : rows) {
			System.out.println(potentialCustomer);
		}
	}
	
	@Test
	public void testtoCustomer() throws Exception {
		Long customer = potentialCustomerService.toCustomer(3L);
		System.out.println(customer);
	}

	@Test
	public void testGetAll() throws Exception {
		List<PotentialCustomer> all = potentialCustomerService.getAll();
		for (PotentialCustomer potentialCustomer : all) {
			System.out.println(potentialCustomer);
		}
	}
}
