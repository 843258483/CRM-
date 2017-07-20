package cn.itsource.crm.test;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.SystemDictionaryItem;
import cn.itsource.crm.service.ISystemDictionaryItemService;

public class SystemDictionaryItemServiceTest extends BaseServiceTest {

	@Autowired
	ISystemDictionaryItemService systemDictionaryItemService;

	@Test
	public void save() throws Exception {
		for (int i = 0; i < 30; i++) {
			SystemDictionaryItem dictionaryItem = new SystemDictionaryItem();
			dictionaryItem.setIntro("字典明细    "+i);
			dictionaryItem.setName("明细名称"+i);
			systemDictionaryItemService.save(dictionaryItem);
		}
	}
	
	@Test
	public void testGet() throws Exception {
		System.out.println(systemDictionaryItemService.get(1L));
	}
	
	@Test
	public void testGetAll() throws Exception {
		System.out.println(systemDictionaryItemService.getClass());
		System.out.println(systemDictionaryItemService.getAll().size());
	}
}
