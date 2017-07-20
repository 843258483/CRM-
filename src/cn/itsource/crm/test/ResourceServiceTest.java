package cn.itsource.crm.test;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.Resource;
import cn.itsource.crm.query.ResourceQuery;
import cn.itsource.crm.service.IResourceService;

public class ResourceServiceTest extends BaseServiceTest {

	@Autowired
	IResourceService resourceService;

	@Test
	public void testSave() throws Exception {
			Resource resource = new Resource();
			resource.setName("员工添加");
			resourceService.save(resource);
	}

	@Test
	public void testGet() throws Exception {
		resourceService.loadResource();
	}

	@Test
	public void testGetAll() throws Exception {
		ResourceQuery resourceQuery = new ResourceQuery();
		System.out.println(resourceService.findByQuery(resourceQuery).getRows().size());
	}
}
