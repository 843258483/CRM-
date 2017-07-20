package cn.itsource.crm.web.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.Resource;
import cn.itsource.crm.query.BaseQuery;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.IResourceService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;
@Controller
@RequestMapping("/resource")
public class ResourceController extends BaseController{
	@Autowired
	IResourceService resourceService;
	
	//展示页面
	@RequestMapping("/list")
	@ResourceControlled(value="资源页面")
	public String list(){
		System.out.println("list------");
		return "resource";
	}
	//从resource.jsp发出ajax获得json
	@RequestMapping("/json")
	@ResponseBody
	@ResourceControlled(value="资源列表")
	public PageList json(BaseQuery baseQuery){
		return resourceService.findByQuery(baseQuery);
	}
	
	@RequestMapping("/findByPermissionId")
	@ResponseBody
	@ResourceControlled(value="权限的资源")
	public PageList findByPermissionId(Long permissionId){
		return resourceService.findByPermissionId(permissionId);
	}
	
	//保存或者修改
	@RequestMapping("/save")
	@ResponseBody
	@ResourceControlled(value="资源保存")
	public AjaxResult save(Resource resource){
		
		try {
			if(resource.getId()!=null){
				resourceService.update(resource);
			}else {
				resourceService.save(resource);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存出现异常"+e.getMessage());
		}
	}
	//删除方法
	@RequestMapping("/delete")
	@ResponseBody
	@ResourceControlled(value="资源删除")
	public AjaxResult delete(Long id){
		return null;
	}
	
	@RequestMapping("/findChildrenMenu")
	@ResponseBody
	@ResourceControlled(value="资源子菜单明细")
	public PageList findChildrenMenu(){
		return resourceService.findChildrenMenu();
	}
	
	
}
