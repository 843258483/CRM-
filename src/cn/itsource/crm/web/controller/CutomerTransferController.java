package cn.itsource.crm.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.CutomerTransfer;
import cn.itsource.crm.query.CutomerTransferQuery;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.ICutomerTransferService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;


@Controller
@RequestMapping("/cutomerTransfer")
public class CutomerTransferController extends BaseController {
	@Autowired
	ICutomerTransferService cutomerTransferService;

	// 访问入口：http://localhost/department/list
	// 显示easyui+jsp页面
	@RequestMapping("/list")
	@ResourceControlled(value = "客户移交记录页面")
	public String list() {
		return "cutomerTransfer";
	}

	// 不直接访问：由department.jsp发出ajax请求返回json数据
	@RequestMapping("/json")
	@ResponseBody
	@ResourceControlled(value = "客户移交记录列表")
	public PageList json(CutomerTransferQuery cutomerTransferQuery) {
		return cutomerTransferService.findByQuery(cutomerTransferQuery);
		
	}

	// ajax删除
	// http://localhost:8080/department/delete?id=333
	@RequestMapping("/delete")
	@ResponseBody
	@ResourceControlled(value = "客户移交记录删除")
	public AjaxResult delete(Long id) {
		try {
			cutomerTransferService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("删除出现异常：" + e.getMessage());
		}
	}

	// 新增或者修改后保存
	@RequestMapping("/save")
	@ResponseBody
	@ResourceControlled(value = "客户移交记录保存")
	public AjaxResult save(CutomerTransfer cutomerTransfer) {
		try {
			if (cutomerTransfer.getId() == null) {
				cutomerTransferService.save(cutomerTransfer);
			} else {
				cutomerTransferService.update(cutomerTransfer);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("保存出现异常：" + e.getMessage());
		}
	}
}
