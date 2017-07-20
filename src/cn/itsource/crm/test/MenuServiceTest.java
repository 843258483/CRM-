package cn.itsource.crm.test;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.Menu;
import cn.itsource.crm.query.MenuQuery;
import cn.itsource.crm.service.IMenuService;

public class MenuServiceTest extends BaseServiceTest {

	@Autowired
	IMenuService menuService;

	@Test
	public void testSave() throws Exception {
			Menu menu = new Menu();
			menu.setName("角色管理");
			menuService.save(menu);
	}

	@Test
	public void testGet() throws Exception {
		System.out.println(menuService.get(1L));
	}

	@Test
	public void testGetAll() throws Exception {
		MenuQuery menuQuery = new MenuQuery();
		System.out.println(menuService.findByQuery(menuQuery).getRows().size());
	}
}
