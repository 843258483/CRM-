package cn.itsource.crm.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.Role;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.query.RoleQuery;
import cn.itsource.crm.service.IRoleService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;

//交给Spring来管理
@Controller
@RequestMapping("/role")
public class RoleController extends BaseController {

	// 自动注入roleService
	@Autowired
	private IRoleService roleService;

	// localhost:8080/role/list
	@RequestMapping("/list")
	@ResourceControlled(value = "角色页面")
	public String list() {
		// 显示role.jsp页面
		return "role";
	}

	@RequestMapping("/json")
	@ResponseBody
	@ResourceControlled(value = "角色列表")
	public PageList json(RoleQuery baseQuery) {
		return roleService.findByQuery(baseQuery);
	}

	@RequestMapping("/save")
	@ResponseBody
	// 保存方法
	@ResourceControlled(value = "角色保存")
	public AjaxResult save(Role role) {
		try {
			if (role.getId() == null) {
				roleService.save(role);
			} else {
				roleService.update(role);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存失败" + e.getMessage());
		}
	}

	@RequestMapping("/delete")
	@ResponseBody
	@ResourceControlled(value = "角色删除")
	// ajax删除方法
	public AjaxResult delete(Long id) {
		try {
			roleService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("删除失败" + e.getMessage());
		}
	}
}
