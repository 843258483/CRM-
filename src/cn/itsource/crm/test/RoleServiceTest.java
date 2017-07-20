package cn.itsource.crm.test;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.Role;
import cn.itsource.crm.query.RoleQuery;
import cn.itsource.crm.service.IRoleService;

public class RoleServiceTest extends BaseServiceTest {

	@Autowired
	IRoleService roleService;

	@Test
	public void testSave() throws Exception {
			Role role = new Role();
			role.setName("普通管理员");
			roleService.save(role);
	}

	@Test
	public void testGet() throws Exception {
		System.out.println(roleService.get(1L));
	}

	@Test
	public void testGetAll() throws Exception {
		RoleQuery roleQuery = new RoleQuery();
		System.out.println(roleService.findByQuery(roleQuery).getRows().size());
	}
}
