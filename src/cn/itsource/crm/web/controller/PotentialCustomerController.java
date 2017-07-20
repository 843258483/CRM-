package cn.itsource.crm.web.controller;


import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.itsource.crm.domain.Customer;
import cn.itsource.crm.domain.PotentialCustomer;
import cn.itsource.crm.domain.SystemDictionaryItem;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.query.PotentialCustomerQuery;
import cn.itsource.crm.service.IPotentialCustomerService;
import cn.itsource.crm.service.ISystemDictionaryItemService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;
@Controller
@RequestMapping("/potentialCustomer")
public class PotentialCustomerController extends BaseController{
	@Autowired
	IPotentialCustomerService potentialCustomerService;
	@Autowired
	ISystemDictionaryItemService systemDictionaryItemService;
	
	//展示页面
	@RequestMapping("/list")
	@ResourceControlled(value = "潜在客户页面")
	public String list(){
		return "potentialCustomer";
	}
	//从department.jsp发出ajax获得json
	@RequestMapping("/json")
	@ResponseBody
	@ResourceControlled(value = "潜在客户列表")
	public Object json(PotentialCustomerQuery baseQuery){
		return potentialCustomerService.findByQuery(baseQuery);
	}
	//保存或者修改
	@RequestMapping("/save")
	@ResponseBody
	@ResourceControlled(value = "潜在客户保存")
	public AjaxResult save(PotentialCustomer department){
		
		try {
			if(department.getId()!=null){
				potentialCustomerService.update(department);
			}else {
				potentialCustomerService.save(department);
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
	@ResourceControlled(value = "潜在客户删除")
	public AjaxResult delete(Long id){
		
		try {
//			int i = 5/0;
			potentialCustomerService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("删除出现异常"+e.getMessage());
		}
	}
	
	
	
	//将潜在客户转换为 客户的方法
	@RequestMapping("/upToCustomer")
	@ResponseBody
	@ResourceControlled(value = "潜在客户升级")
	public AjaxResult upToCustomer(Customer customer){
		potentialCustomerService.upToCustomer(customer);
		try {
			
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult("升级出现异常 请确认无误再升级"+e.getMessage());
		}
	}
	
	
	
	
	@RequestMapping("/getCustomerSource")
	@ResponseBody
	public List<SystemDictionaryItem> getCustomerSource(){
		return null;
	}
	
	@RequestMapping("/download")
	public void download(HttpServletRequest request, HttpServletResponse response, PotentialCustomerQuery baseQuery)
			throws IOException {
		
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		response.setHeader("Content-Disposition",
				"attachment;fileName=" + new String(("已登记潜在客户列表.xls").getBytes(), "iso-8859-1"));

		baseQuery.setRows(Integer.MAX_VALUE);
		PageList pageList = potentialCustomerService.findByQuery(baseQuery);
		List<PotentialCustomer> potentialCustomers = pageList.getRows();
		// 准备一个表头
		String[] head = { "潜在客户编号", "姓名", "成功率", "联系人","联系电话","简要备注","录入时间","客户来源","录入人员"};
		List<String[]> list = new ArrayList<>();
		for (int i = 0; i < potentialCustomers.size(); i++) {
			String[] row = new String[head.length];
			row[0] = potentialCustomers.get(i).getId().toString();
			row[1] = potentialCustomers.get(i).getName();			
			row[2] = potentialCustomers.get(i).getSuccessRate().toString();		
			row[3] = potentialCustomers.get(i).getLinkMan();			
			row[4] = potentialCustomers.get(i).getLinkManTel();		
			row[5] = potentialCustomers.get(i).getRemark();
			row[6] = potentialCustomers.get(i).getInputTime().toLocaleString();
			row[7] = potentialCustomers.get(i).getCustomerSource().getName();
			row[8] = potentialCustomers.get(i).getInputUser().getRealName();
			list.add(row);
		}
		// 创建一个对象内存
		// SXSSFWorkbook workbook = new SXSSFWorkbook();
		HSSFWorkbook workbook = new HSSFWorkbook();// 创建工作薄
		// 创建一个表
		Sheet sheet = workbook.createSheet();
		// 创建表头
		Row row0 = sheet.createRow(0);
		for (int cellNum = 0; cellNum < head.length; cellNum++) {
			Cell cell = row0.createCell(cellNum);
			cell.setCellValue(head[cellNum]);
		}

		for (int i = 0; i < list.size(); i++) {
			Row rowNum = sheet.createRow(i + 1);
			String[] strings = list.get(i);
			for (int cellNum = 0; cellNum < head.length; cellNum++) {
				Cell cell = rowNum.createCell(cellNum);
				cell.setCellValue(strings[cellNum]);
			}
		}

		// 内存缓冲流
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		workbook.write(out);
		out.close();
		workbook.close();
		// byte[] context = out.toByteArray();
		InputStream inputStream = new ByteArrayInputStream(out.toByteArray());

		ServletOutputStream outputStream = response.getOutputStream();
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		try {
			bis = new BufferedInputStream(inputStream);
			bos = new BufferedOutputStream(outputStream);
			byte[] buff = new byte[2048];
			int bytesRead;
			// Simple read/write loop.
			while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
				bos.write(buff, 0, bytesRead);
			}
		} catch (final IOException e) {
			throw e;
		} finally {
			if (bis != null)
				bis.close();
			if (bos != null)
				bos.close();
		}
	}
	
	@RequestMapping(value = "/uploadfile", method = RequestMethod.POST)
	public void upload(String username, MultipartFile upload, HttpServletRequest request) throws Exception {
		try {
			if (upload != null) {
				InputStream inputStream = upload.getInputStream();
				HSSFWorkbook workbook = new HSSFWorkbook(inputStream);// 创建工作薄
				List<String[]> lists = new ArrayList<>();
				// 获取表
				Sheet sheet = workbook.getSheetAt(0);
				int lastRowNum = sheet.getLastRowNum();
				for (int i = 1; i <= lastRowNum; i++) {
					Row row = sheet.getRow(i);
					short lastCellNum = row.getLastCellNum();
					String[] strings = new String[lastCellNum];
					for (int j = 0; j < lastCellNum; j++) {
						Cell cell = row.getCell(j);
						if (cell != null) {
							strings[j] = cell.getStringCellValue();
						}
					}
					lists.add(strings);
				}
				inputStream.close();
			// 将list解析为systemLog对象
				for (String[] strings : lists) {
				//	SystemLog systemLog = new SystemLog();
					// { "用户名", "ip地址", "实际操作", "时间" };将字段对应解析封装为systemLog
					// Employee employee = new Employee();
					// employee.setId(1L);
				//	Employee employee = employeeMapper.findUserByName(strings[0]);
				//	systemLog.setOpUser(employee);
				//	systemLog.setOpIp(strings[1]);
				//	systemLog.setFunction(strings[2]);
				//	systemLog.setOpTime(DateUtils.parseDate(strings[3], "yyyy-MM-dd HH:mm:ss"));
					// 持久化到数据库
				//	systemLogService.save(systemLog);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("上传文件出错");
		}
	}
		
}
