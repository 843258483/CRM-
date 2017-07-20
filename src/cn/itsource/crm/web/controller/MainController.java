package cn.itsource.crm.web.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.Menu;
import cn.itsource.crm.service.IEmployeeService;
import cn.itsource.crm.util.UserContext;

@Controller
public class MainController {
	@Autowired
	IEmployeeService employeeService;
	
	@RequestMapping("/main")
	public String main() {
		return "main";
	}
	
	@RequestMapping("/left")
	@ResponseBody
	public List<Menu> left(HttpSession httpSession) {
		List<Menu> list = employeeService.findMenusByLoginUser(UserContext.getEmployee(httpSession));
		return list;
	}
}
