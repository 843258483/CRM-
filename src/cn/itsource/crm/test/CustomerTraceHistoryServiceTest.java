package cn.itsource.crm.test;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.query.CustomerTraceHistoryQuery;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.ICustomerTraceHistoryService;

public class CustomerTraceHistoryServiceTest extends BaseServiceTest {

	@Autowired
	ICustomerTraceHistoryService customerTraceHistoryService;


	@Test
	public void testSave() throws Exception {
		CustomerTraceHistoryQuery query = new CustomerTraceHistoryQuery();
		PageList findByQuery = customerTraceHistoryService.findByQuery(query);
		System.out.println(findByQuery.getRows().size());
	}
	
	@Test
	public void testUpdate() throws Exception {
		customerTraceHistoryService.getSellerView();

	}
	
	@Test
	public void testGet() throws Exception {
		System.out.println(customerTraceHistoryService.get(1L));
	}
	
	@Test
	public void testGetAll() throws Exception {
		CustomerTraceHistoryQuery customerTraceHistoryQuery = new CustomerTraceHistoryQuery();
		System.out.println(customerTraceHistoryService.findByQuery(customerTraceHistoryQuery).getRows().size());
	}
	
	@Test
	public void testCustomerTraceHistoryQuery() throws Exception {

	}
	
	
	@Test
	public void testFindByCustomerId() throws Exception {
	}
}
