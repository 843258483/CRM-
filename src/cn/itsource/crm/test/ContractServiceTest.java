package cn.itsource.crm.test;

import java.math.BigDecimal;
import java.util.List;
import java.util.UUID;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.Contract;
import cn.itsource.crm.domain.Customer;
import cn.itsource.crm.query.ContractQuery;
import cn.itsource.crm.service.IContractService;
import cn.itsource.crm.service.IEmployeeService;

public class ContractServiceTest extends BaseServiceTest {

	@Autowired
	IContractService contractService;
	@Autowired
	IEmployeeService employeeService;

	@Test
	public void testSave() throws Exception {
		
			Contract contract = new Contract();
//			contract.setCustomer(new Customer(3L, "zql"));
			contract.setSn(UUID.randomUUID().toString().substring(0, 6));
			contract.setSeller(employeeService.get(1L));
			contract.setSum(new BigDecimal(14900));
			contract.setIntro("java学费");
			contractService.save(contract);
	}
	
	@Test
	public void testUpdate() throws Exception {
		
			Contract contract = contractService.get(1L);
			Customer customer = new Customer();
			customer.setId(1L);
			customer.setName("dcz");
			contract.setCustomer(customer);
			contract.setSeller(employeeService.get(2L));
//			contract.setSum(new BigDecimal(500));
			contractService.update(contract);
	}
	
	@Test
	public void testGet() throws Exception {
		System.out.println(contractService.get(1L));
	}
	
	@SuppressWarnings("unchecked")
	@Test
	public void testGetAll() throws Exception {
		ContractQuery contractQuery = new ContractQuery();
		
		System.out.println("所有数据："+contractService.getAll().size());
		List<Contract> list = contractService.findByQuery(contractQuery).getRows();
		for (Contract contract : list) {
			System.out.println(contract.getItems().size());
		}
	}
	
	@Test
	public void testContractQuery() throws Exception {
		ContractQuery contractQuery = new ContractQuery();
//		contractQuery.setCustomerId(1L);
//		contractQuery.setSellerId(1L);
//		contractQuery.setKeyword("5");
		Contract contract = (Contract) contractService.findByQuery(contractQuery).getRows().get(0);
		System.out.println(contract.getItems().size());
	}
	
	@Test
	public void testDelete() throws Exception {
		contractService.delete(3L);
	}
}
