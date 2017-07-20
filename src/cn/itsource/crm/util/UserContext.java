package cn.itsource.crm.util;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import cn.itsource.crm.domain.Employee;
import cn.itsource.crm.domain.Role;
import cn.itsource.crm.service.IEmployeeService;

/**
 * 登录用户的上下文对象
 * 
 * @author Arick
 *
 */
@Component
public class UserContext {
	static IEmployeeService employeeService;
	
	@Autowired
	public  void setEmployeeService(IEmployeeService employeeService) {
		UserContext.employeeService = employeeService;
	}
	
	private static String EMPLOYEE_IN_SESSION = "employeeInSession";

	public static void setEmployee(HttpSession httpSession, Employee employee) {
		httpSession.setAttribute(EMPLOYEE_IN_SESSION, employee);
	}

	public static Employee getEmployee(HttpSession httpSession) {
		return (Employee) httpSession.getAttribute(EMPLOYEE_IN_SESSION);
	}

	public static void remove(HttpSession httpSession) {
		httpSession.removeAttribute(EMPLOYEE_IN_SESSION);
	}
	//获得请求
	public static HttpServletRequest getRequest(){
		ServletRequestAttributes requestAttributes = (ServletRequestAttributes)RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = requestAttributes.getRequest();
		return request;
	}
	public static HttpSession getSession(){
		HttpSession session = getRequest().getSession();
		return session;
	}
	public static Employee getUser(){
		Employee user = (Employee)getSession().getAttribute(EMPLOYEE_IN_SESSION);
		return user;
	}
	
	public static List<Role> findByUserRoles(Long  loginUserId){
		return employeeService.findByEmployeeRoles(loginUserId);
	}
}
