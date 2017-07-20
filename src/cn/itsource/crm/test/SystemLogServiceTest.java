package cn.itsource.crm.test;

import java.util.Date;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import cn.itsource.crm.domain.Employee;
import cn.itsource.crm.domain.SystemLog;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.query.SystemLogQuery;
import cn.itsource.crm.service.ISystemLogService;



public class SystemLogServiceTest extends BaseServiceTest {

	@Autowired
	ISystemLogService systemLogService;

	@Test
	public void testSave() throws Exception {
		Employee employee = new Employee();
		employee.setId(1L);
		for (int i = 0; i < 50; i++) {
			SystemLog systemLog = new SystemLog();
			systemLog.setOpIp("000000000"+i);
			systemLog.setFunction("Function__"+i);
//			systemLog.setOpUser(employee);
			systemLog.setOpTime(new Date());
			systemLogService.save(systemLog);
		}
	}
	
	@Test
	public void testGet() throws Exception {
		System.out.println(systemLogService.get(2L));
	}
	
	@Test
	public void testGetAll() throws Exception {
		SystemLogQuery baseQuery = new SystemLogQuery();
		baseQuery.setPage(3);
		System.out.println(systemLogService.getClass());
		PageList pageList = systemLogService.findByQuery(baseQuery);
		System.out.println(pageList.getTotal());
		System.out.println(pageList.getRows().size());
	}
}
