package cn.itsource.crm.test;

import java.util.Date;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.Guarantee;
import cn.itsource.crm.domain.GuaranteeItem;
import cn.itsource.crm.query.GuaranteeItemQuery;
import cn.itsource.crm.service.IGuaranteeItemService;

public class GuaranteeItemServiceTest extends BaseServiceTest {

	@Autowired
	IGuaranteeItemService guaranteeItemService;

	@Test
	public void testSave() throws Exception {
			GuaranteeItem guaranteeItem = new GuaranteeItem();
			Guarantee guarantee = new Guarantee();
			guarantee.setId(1L);
			guaranteeItem.setContent("yyyyyyyyy");
			guaranteeItem.setGuaranteeTime(new Date());
			guaranteeItem.setSolve(true);
			guaranteeItem.setGuarantee(guarantee);
			guaranteeItemService.save(guaranteeItem);
	}

	@Test
	public void testGet() throws Exception {
		System.out.println(guaranteeItemService.get(1L));
	}

	@Test
	public void testGetAll() throws Exception {
		GuaranteeItemQuery guaranteeItemQuery = new GuaranteeItemQuery();
		System.out.println(guaranteeItemService.findByQuery(guaranteeItemQuery).getRows().size());
	}
}
