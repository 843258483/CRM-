package cn.itsource.crm.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.Menu;
import cn.itsource.crm.query.DepartmentQuery;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.IMenuService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;

@Controller
@RequestMapping("/menu")
public class MenuController extends BaseController {
	@Autowired
	IMenuService menuService;

	@RequestMapping("/list")
	@ResourceControlled(value="菜单页面")
	public String main() {
		return "menu";
	}

	@RequestMapping("/json")
	@ResponseBody
	@ResourceControlled(value="菜单列表")
	public PageList json(DepartmentQuery baseQuery) {
		return menuService.findByQuery(baseQuery);
	}

	@RequestMapping("/save")
	@ResponseBody
	// 保存方法
	@ResourceControlled(value="菜单保存")
	public AjaxResult save(Menu menu) {
		try {
			if (menu.getId() == null) {
				menuService.save(menu);
			} else {
				menuService.update(menu);
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
	@ResourceControlled(value="菜单删除")
	public AjaxResult delete(Long id) {
		try {
			menuService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("删除失败" + e.getMessage());
		}
	}
	
	@RequestMapping("/findParentMenu")
	@ResponseBody
	@ResourceControlled(value="子菜单明细")
	public PageList findChildrenMenu(){
		return menuService.findParentMenu();
	}
}
