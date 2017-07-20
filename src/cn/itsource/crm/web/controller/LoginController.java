package cn.itsource.crm.web.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.Employee;
import cn.itsource.crm.service.IEmployeeService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.UserContext;

@Controller
public class LoginController {

	@Autowired
	IEmployeeService employeeService;

	// 登录页面
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String get() {
		return "login2";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	@ResponseBody
	public AjaxResult post(String username, String password, HttpSession httpSession) {

		try {
			Employee employee = employeeService.findByLoginUser(username, password);
			UserContext.setEmployee(httpSession, employee);
			return new AjaxResult();
		} catch (RuntimeException e) {
			e.printStackTrace();
			return new AjaxResult(e.getMessage());
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult(e.getMessage());
		}
	}
	
	
		// 显示登录页面：get方法
		@RequestMapping("/logout")
		public String logout(HttpSession httpSession) {
			// 清空原来的httpSession的值
			UserContext.remove(httpSession);
			return "login2";
		}

}
