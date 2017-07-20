package cn.itsource.crm.test;

import java.math.BigDecimal;
import java.util.Date;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.Contract;
import cn.itsource.crm.domain.ContractItem;
import cn.itsource.crm.service.IContractItemService;

public class ContractItemServiceTest extends BaseServiceTest {

	@Autowired
	IContractItemService contractItemService;

	@Test
	public void testSave() throws Exception {
		
		ContractItem item = new ContractItem();
		Contract contract = new Contract();
		contract.setId(3L);
		item.setContract(contract);
		item.setPayTime(new Date());
		item.setIsPayment(false);
		item.setMoney(new BigDecimal(14400));
//		item.setScal(new BigDecimal(14400).divide(new BigDecimal(14900)));
	
		contractItemService.save(item);
	}
	
	@Test
	public void testUpdate() throws Exception {
		
			ContractItem item = contractItemService.get(2L);
			Contract contract = new Contract();
			contract.setId(1L);
			item.setContract(contract);
			item.setIsPayment(false);
			BigDecimal divide = new BigDecimal(14400).divide(new BigDecimal(14900), 2, BigDecimal.ROUND_HALF_EVEN);
			System.out.println(divide);
			item.setScale(divide);
			contractItemService.update(item);
	}
}
