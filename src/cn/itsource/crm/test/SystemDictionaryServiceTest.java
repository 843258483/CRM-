package cn.itsource.crm.test;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.SystemDictionary;
import cn.itsource.crm.service.ISystemDictionaryService;



public class SystemDictionaryServiceTest extends BaseServiceTest {

	@Autowired
	ISystemDictionaryService systemDictionaryService;

	@Test
	public void testSave() throws Exception {
		for (int i = 0; i < 25; i++) {
			SystemDictionary dictionary = new SystemDictionary();
			dictionary.setIntro("数据字典简介"+i);
			dictionary.setName("字典名称_"+i);
			dictionary.setSn("字典编号"+(i+100));
			dictionary.setState(1);
			systemDictionaryService.save(dictionary);
		}
	}
	
	@Test
	public void testGet() throws Exception {
		System.out.println(systemDictionaryService.get(1L));
	}
	
	@Test
	public void testGetAll() throws Exception {
		System.out.println(systemDictionaryService.getClass());
		System.out.println(systemDictionaryService.getAll().size());
	}
}
