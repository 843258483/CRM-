package cn.itsource.crm.query;

import java.util.List;

import javax.servlet.http.HttpSession;

import cn.itsource.crm.domain.Employee;
import cn.itsource.crm.domain.Role;
import cn.itsource.crm.util.UserContext;

/**
 * 公共的查询条件
 * 
 * @author Arick
 *
 */
public class BaseQuery {
	// easyui自动帮我们处理分页，传回后台有两个参数page==currentPage，rows==pageSize，定义属性进行接收
	private int page = 1;
	private int rows = 10;
	public Long getLoginUserId(){
		HttpSession session = UserContext.getSession();
		if(session!=null){
			return UserContext.getEmployee(session).getId();
		}
		return null;
	}
	public boolean getIsAdmin(){
		HttpSession session = UserContext.getSession();
		if(session==null){
			return false;
		}else{
			Employee employee = UserContext.getEmployee(session);
			List<Role> roles = UserContext.findByUserRoles(employee.getId());
			for (Role role : roles) {
				if(role.getName().endsWith("Admin")){
					return true;
				}
			}
			return false;
		}

	}
	
	
	
	// 高级查询参数接收
	private String keyword;// 关键字查询，支持名称、编号sn....
	
	private String q;
	
	//分类条件
	private String sort="d.id";
	
	//分类顺序
	private String order="asc";

	// 给mapper映射文件提供分页的条件
	public int getBegin() {// 从什么位置开始
		return (page - 1) * rows;
	}

	public int getEnd() {// 每页显示多少条数据
		return rows;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getQ() {
		return q;
	}

	public void setQ(String q) {
		this.q = q;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		if("parent".equals(sort)){
			this.sort = "d.parent_id";
		}else if("manager".equals(sort)){
			this.sort = "d.manager_id";
		}
		else if("department".equals(sort)){
			this.sort = "e.department_id";
		
		}
		else{
			this.sort = sort;
		}
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

}
