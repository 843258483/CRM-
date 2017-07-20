package cn.itsource.crm.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.SystemDictionary;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.query.SystemDictionaryQuery;
import cn.itsource.crm.service.ISystemDictionaryService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;


//交给Spring来管理
@Controller
@RequestMapping("/systemDictionary")
public class SystemDictionaryController extends BaseController{

	//自动注入systemDictionaryService
	@Autowired
	private ISystemDictionaryService systemDictionaryService;
	//localhost:8080/systemDictionary/list
	@RequestMapping("/list")
	@ResourceControlled(value = "数据字典页面")
	public String list(){
		//显示systemDictionary.jsp页面
		return "systemDictionary";
	}
	@RequestMapping("/json")
	@ResponseBody
	@ResourceControlled(value = "数据字典列表")
	public Object json(SystemDictionaryQuery baseQuery){
		
		PageList pageList = systemDictionaryService.findByQuery(baseQuery);
		System.out.println(pageList.getTotal());
		return systemDictionaryService.findByQuery(baseQuery);
		
	}
	
	@RequestMapping("/save")
	@ResponseBody
	@ResourceControlled(value = "保存数据字典")
	//保存方法
	public AjaxResult save(SystemDictionary systemDictionary){
		try {
			if(systemDictionary.getId()==null){
				systemDictionaryService.save(systemDictionary);;
			}else{
				systemDictionaryService.update(systemDictionary);
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
			systemDictionaryService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult(e.getMessage());
		}
	}
	
	@RequestMapping("/getAll")
	@ResponseBody
	@ResourceControlled(value = "回显数据字典")
	public Object getAll() {
		
		List<SystemDictionary> all = systemDictionaryService.getAll();
		
		return all;
	}
}
