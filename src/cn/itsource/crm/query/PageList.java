package cn.itsource.crm.query;

import java.util.ArrayList;
import java.util.List;

/**
 * 返回页面查询后的数据
 * 
 * @author Arick
 *
 */
public class PageList {
	// 定义两个easyui(datagrid)需要的两个属性
	// 在service层进行封装

	private int total=0;// 总条数
	private List rows = new ArrayList<>();// 查询出来的数据

	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public List getRows() {
		return rows;
	}

	public void setRows(List rows) {
		this.rows = rows;
	}

}
