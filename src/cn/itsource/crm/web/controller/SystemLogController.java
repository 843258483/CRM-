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
import org.springframework.web.bind.annotation.ResponseBody;

import cn.itsource.crm.domain.SystemLog;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.query.SystemLogQuery;
import cn.itsource.crm.service.ISystemLogService;
import cn.itsource.crm.util.AjaxResult;
import cn.itsource.crm.util.ResourceControlled;

//交给Spring来管理
@Controller
@RequestMapping("/systemLog")
public class SystemLogController extends BaseController {

	// 自动注入systemDictionaryService
	@Autowired
	private ISystemLogService systemLogService;

	// localhost:8080/systemLog/list
	@RequestMapping("/list")
	@ResourceControlled(value = "系统日志页面")
	public String list() {
		// 显示systemDictionary.jsp页面
		return "systemLog";
	}

	@RequestMapping("/json")
	@ResponseBody
	@ResourceControlled(value = "系统日志列表")
	public Object json(SystemLogQuery baseQuery) {

		return systemLogService.findByQuery(baseQuery);
	}

	@RequestMapping("/save")
	@ResponseBody
	@ResourceControlled(value = "保存系统日志")
	// 保存方法
	public AjaxResult save(SystemLog systemLog) {
		try {
			if (systemLog.getId() == null) {
				systemLogService.save(systemLog);
			} else {
				systemLogService.update(systemLog);
			}
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult(e.getMessage());
		}
	}

	@RequestMapping("/delete")
	@ResponseBody
	@ResourceControlled(value = "删除一条系统日志")
	// ajax删除方法
	public AjaxResult delete(Long id) {
		try {
			systemLogService.delete(id);
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult(e.getMessage());
		}
	}

	@RequestMapping("/deleteAll")
	@ResponseBody
	@ResourceControlled(value = "删除所有日志")
	// ajax删除方法
	public AjaxResult deleteAll() {
		try {
			systemLogService.deleteAll();
			return new AjaxResult();
		} catch (Exception e) {
			e.printStackTrace();
			return new AjaxResult(e.getMessage());
		}
	}

	@RequestMapping("/download")
	@ResourceControlled(value = "导出系统日志")
	public void download(HttpServletRequest request, HttpServletResponse response, SystemLogQuery baseQuery)
			throws IOException {
		// response.reset();
		// response.setContentType("application/vnd.ms-excel;charset=utf-8");
		// response.setHeader("Content-Disposition",
		// "attachment;filename=" + new String(("log.xls").getBytes(),
		// "iso-8859-1"));

		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		response.setHeader("Content-Disposition",
				"attachment;fileName=" + new String(("log.xls").getBytes(), "iso-8859-1"));

		baseQuery.setRows(Integer.MAX_VALUE);
		PageList pageList = systemLogService.findByQuery(baseQuery);
		List<SystemLog> list_log = pageList.getRows();
		// 准备一个表头
		String[] head = { "用户名", "ip地址", "实际操作", "时间" };
		List<String[]> list = new ArrayList<>();
		for (int i = 0; i < list_log.size(); i++) {
			String[] row = new String[head.length];
//			row[0] = list_log.get(i).getOpUser().getUsername();
			row[0] = list_log.get(i).getOpIp();
			row[1] = list_log.get(i).getFunction() == null ? "" : list_log.get(i).getFunction();
			row[2] = list_log.get(i).getOpTime() == null ? "" : list_log.get(i).getOpTime().toLocaleString();

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
}
