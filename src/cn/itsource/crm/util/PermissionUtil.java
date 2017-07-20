package cn.itsource.crm.util;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.itsource.crm.domain.Employee;
import cn.itsource.crm.service.IEmployeeService;
@Component
public class PermissionUtil{
	

static	IEmployeeService employeeService;

	@Autowired
	public void setEmployeeService(IEmployeeService employeeService) {
		PermissionUtil.employeeService = employeeService;
	}
	
	public  static String  append(String a,String b){
		return a+b;
	}
	public  static boolean  permission(String permissionName,String permissionName1){
		HttpSession session = UserContext.getSession();
		
		Employee employee = UserContext.getEmployee(session);
//		boolean checkPermission = employeeService.checkPermission(employee.getId(), permissionName, permissionName1);
		return employeeService.checkPermission(employee.getId(), permissionName, permissionName1);
	}
}
