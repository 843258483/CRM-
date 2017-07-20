package cn.itsource.crm.test;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.Customer;
import cn.itsource.crm.service.ICustomerService;

public class CustomerServiceTest extends BaseServiceTest {

	@Autowired
	ICustomerService customerService;

	
	@Test
	public void testGetByQuery() throws Exception {
		Customer customer = customerService.get(18);
		System.out.println(customer);
		customerService.giveUp(18L);
	}
	
	@Test
	public void testSave() throws Exception {
		Customer customer = customerService.get(1L);
		customer.setId(null);
		customer.setInputTime(new Date());
		customerService.save(customer);
	}

	@Test
	public void testGet() throws Exception {
		Customer customer = customerService.get(1L);
		System.out.println(customer);
	}
	@Test
	public void testGetAll2() throws Exception {
		System.out.println(customerService.getAllCustomers().size());
	}
	
	@Test
	public void testDelete() throws Exception {
		customerService.delete(3L);
		
	}

	@Test
	public void testGetAll() throws Exception {
		List<Customer> all = customerService.getAll();
		for (Customer customer : all) {
			System.out.println(customer);
		}
	}
}
