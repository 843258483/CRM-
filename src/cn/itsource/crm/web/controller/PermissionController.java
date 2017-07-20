package cn.itsource.crm.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.Permission;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.query.PermissionQuery;
import cn.itsource.crm.service.IPermissionService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;

//交给Spring来管理
@Controller
@RequestMapping("/permission")
public class PermissionController extends BaseController {

	// 自动注入permissionService
	@Autowired
	private IPermissionService permissionService;

	// localhost:8080/permission/list
	@RequestMapping("/list")
	@ResourceControlled(value="权限页面")
	public String list() {
		// 显示permission.jsp页面
		return "permission";
	}

	@RequestMapping("/json")
	@ResponseBody
	@ResourceControlled(value="权限列表")
	public PageList json(PermissionQuery baseQuery) {
			return permissionService.findByQuery(baseQuery);
	}

	@RequestMapping("/findByRoleId")
	@ResponseBody
	@ResourceControlled(value="角色权限明细")
	public PageList findByRoleId(Long roleId) {
		return permissionService.findByRoleId(roleId);
	}
	
	@RequestMapping("/save")
	@ResponseBody
	// 保存方法
	@ResourceControlled(value="权限保存")
	public AjaxResult save(Permission permission) {
		try {
			if (permission.getId() == null) {
				permissionService.save(permission);
			} else {
				permissionService.update(permission);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存失败" + e.getMessage());
		}
	}

	@RequestMapping("/delete")
	@ResponseBody
	// ajax删除方法
	@ResourceControlled(value="权限删除")
	public AjaxResult delete(Long id) {
		try {
			permissionService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("删除失败" + e.getMessage());
		}
	}

}
