package cn.itsource.crm.test;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.query.CutomerTransferQuery;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.ICutomerTransferService;

public class CutomerTransferServiceTest extends BaseServiceTest {

	@Autowired
	ICutomerTransferService cutomerTransferService;


	@Test
	public void testSave() throws Exception {
		CutomerTransferQuery query = new CutomerTransferQuery();
		PageList findByQuery = cutomerTransferService.findByQuery(query);
		System.out.println(findByQuery.getRows().size());
	}
	
	@Test
	public void testUpdate() throws Exception {
		

	}
	
	@Test
	public void testGet() throws Exception {
		System.out.println(cutomerTransferService.get(1L));
	}
	
	@Test
	public void testGetAll() throws Exception {
		CutomerTransferQuery cutomerTransferQuery = new CutomerTransferQuery();
		System.out.println(cutomerTransferService.findByQuery(cutomerTransferQuery).getRows().size());
	}
	
	@Test
	public void testCutomerTransferQuery() throws Exception {

	}
	
	
	@Test
	public void testFindByCustomerId() throws Exception {
	}
}
