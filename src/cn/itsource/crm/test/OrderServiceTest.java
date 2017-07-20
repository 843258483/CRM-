package cn.itsource.crm.test;

import java.math.BigDecimal;
import java.util.UUID;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.Order;
import cn.itsource.crm.query.OrderQuery;
import cn.itsource.crm.service.IEmployeeService;
import cn.itsource.crm.service.IOrderService;

public class OrderServiceTest extends BaseServiceTest {

	@Autowired
	IOrderService orderService;
	@Autowired
	IEmployeeService employeeService;

	@Test
	public void testSave() throws Exception {
		
			Order order = new Order();
//			order.setCustomer(new Customer(1L, "dcz"));
			order.setSn(UUID.randomUUID().toString().substring(0, 6));
			order.setSeller(employeeService.get(1L));
			orderService.save(order);
	}
	
	@Test
	public void testUpdate() throws Exception {
		
			Order order = orderService.get(1L);
//			order.setCustomer(new Customer(1L, "dcz"));
			order.setSeller(employeeService.get(1L));
			order.setSum(new BigDecimal(500));
			orderService.update(order);
	}
	
	@Test
	public void testGet() throws Exception {
		System.out.println(orderService.get(1L));
	}
	
	@Test
	public void testGetAll() throws Exception {
		OrderQuery orderQuery = new OrderQuery();
		System.out.println(orderService.findByQuery(orderQuery).getRows().size());
	}
	
	@Test
	public void testOrderQuery() throws Exception {
		OrderQuery orderQuery = new OrderQuery();
//		orderQuery.setCustomerId(1L);
//		orderQuery.setSellerId(1L);
//		orderQuery.setKeyword("5");
		System.out.println(orderService.findByQuery(orderQuery).getRows().size());
	}
	
}
