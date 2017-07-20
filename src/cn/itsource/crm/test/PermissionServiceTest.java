package cn.itsource.crm.test;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.Permission;
import cn.itsource.crm.query.PermissionQuery;
import cn.itsource.crm.service.IPermissionService;

public class PermissionServiceTest extends BaseServiceTest {

	@Autowired
	IPermissionService permissionService;

	@Test
	public void testSave() throws Exception {
			Permission permission = new Permission();
			permission.setName("权限管理");
			permissionService.save(permission);
	}

	@Test
	public void testGet() throws Exception {
		System.out.println(permissionService.get(1L));
	}

	@Test
	public void testGetAll() throws Exception {
		PermissionQuery permissionQuery = new PermissionQuery();
		System.out.println(permissionService.findByQuery(permissionQuery).getRows().size());
	}
}
