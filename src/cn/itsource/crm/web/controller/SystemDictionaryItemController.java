package cn.itsource.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.SystemDictionary;
import cn.itsource.crm.domain.SystemDictionaryItem;
import cn.itsource.crm.query.SystemDictionaryItemQuery;
import cn.itsource.crm.service.ISystemDictionaryItemService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;


//交给Spring来管理
@Controller
@RequestMapping("/systemDictionaryItem")
public class SystemDictionaryItemController extends BaseController{

	//自动注入systemDictionaryItemService
	@Autowired
	private ISystemDictionaryItemService systemDictionaryItemService;
	//localhost:8080/systemDictionaryItem/list
	@RequestMapping("/list")
	@ResourceControlled(value = "数据字典页面")
	public String list(){
		//显示systemDictionaryItem.jsp页面
		return "systemDictionaryItem";
	}
	@RequestMapping("/json")
	@ResponseBody
	@ResourceControlled(value = "数据字典列表")
	public Object json(SystemDictionaryItemQuery baseQuery){
		System.out.println(baseQuery.getQ());
		return systemDictionaryItemService.findByQuery(baseQuery);

	}
	
	@RequestMapping("/save")
	@ResponseBody
	@ResourceControlled(value = "保存数据字典")
	//保存方法
	public AjaxResult save(SystemDictionaryItem systemDictionaryItem){
		try {
			if(systemDictionaryItem.getId()==null){
				systemDictionaryItemService.save(systemDictionaryItem);
			}else{
				systemDictionaryItemService.update(systemDictionaryItem);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult(e.getMessage());
		}
	}
	
	
	@RequestMapping("/delete")
	@ResponseBody
	@ResourceControlled(value = "删除数据字典")
	//ajax删除方法
	public AjaxResult delete(Long id){
		try {
			systemDictionaryItemService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult(e.getMessage());
		}
	}
	@RequestMapping("/getChildren")
	@ResponseBody
	public List<SystemDictionaryItem> getChildren(Long id) {
		SystemDictionary systemDictionary = new SystemDictionary();
		List<SystemDictionaryItem> list = systemDictionaryItemService.getChildren(id);
		systemDictionary.setDetails(list);
		return list;
	}
	@RequestMapping("/get")
	@ResponseBody
	public Object get(Long id) {
		
		SystemDictionaryItem systemDictionaryItem = systemDictionaryItemService.get(id);
		
		return systemDictionaryItem;
	}
	
}
