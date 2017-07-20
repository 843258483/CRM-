package cn.itsource.crm.domain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 部门模型
 * 
 * @author Arick
 *
 */
public class Department {
	private Long id;
	private String name;// 部门名称,非空..
	private String sn;// 部门编号,非空
	private String dirPath;// 部门路径，用来查询子部门
	private Integer state = 0;// 部门状态，默认为0--》未解散，1--》解散(执行删除操作之后修改部门的状态为1，状态为1的不在页面显示)
	private Employee manager;// 部门经理
	private Department parent;// 上级部门
	private List<Department> children = new ArrayList<Department>();// 子部门

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}
	public String getText() {
		return name;
	}
	
	

	public void setName(String name) {
		this.name = name;
	}

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public String getDirPath() {
		return dirPath;
	}
	public Map<String,String>  getAttributes(){
		Map<String, String> attrs = new HashMap<String, String>();
		attrs.put("dirPath", dirPath);
		return attrs;
	}
	

	public void setDirPath(String dirPath) {
		this.dirPath = dirPath;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Employee getManager() {
		return manager;
	}

	public void setManager(Employee manager) {
		this.manager = manager;
	}

	public Department getParent() {
		return parent;
	}

	public void setParent(Department parent) {
		this.parent = parent;
	}

	public List<Department> getChildren() {
		return children;
	}

	public void setChildren(List<Department> children) {
		this.children = children;
	}

	@Override
	public String toString() {
		return "Department [id=" + id + ", name=" + name + ", sn=" + sn + ", dirPath=" + dirPath + ", state=" + state
				+ "]";
	}

}
