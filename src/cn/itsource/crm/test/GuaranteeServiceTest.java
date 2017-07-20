package cn.itsource.crm.test;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.Contract;
import cn.itsource.crm.domain.Customer;
import cn.itsource.crm.domain.Guarantee;
import cn.itsource.crm.query.GuaranteeQuery;
import cn.itsource.crm.service.IGuaranteeService;

public class GuaranteeServiceTest extends BaseServiceTest {

	@Autowired
	IGuaranteeService guaranteeService;

	@Test
	public void testSave() throws Exception {
			Guarantee guarantee = new Guarantee();
			Contract contract = new Contract();
			contract.setId(1L);
			Customer customer = new Customer();
			customer.setId(1L);
			guarantee.setEndTime(new Date());
			guarantee.setContract(contract);
			guarantee.setCustomer(customer);
			guaranteeService.save(guarantee);
	}

	@Test
	public void testGet() throws Exception {
		System.out.println(guaranteeService.get(1L));
	}

	@SuppressWarnings("unchecked")
	@Test
	public void testGetAll() throws Exception {
		GuaranteeQuery guaranteeQuery = new GuaranteeQuery();
		List<Guarantee> list = guaranteeService.findByQuery(guaranteeQuery).getRows();
		System.out.println(list.size());
		System.out.println(list.get(0).getItems().size());
	}
}
