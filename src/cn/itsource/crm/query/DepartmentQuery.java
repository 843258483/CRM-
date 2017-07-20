package cn.itsource.crm.query;

import org.springframework.util.StringUtils;

/**
 * 子类的查询条件
 * 
 * @author Arick
 *
 */
public class DepartmentQuery extends BaseQuery {
	//查询的状态
	private Integer state;
	//查询的部门路径
	private String dirPath;
	private Long parentId;
	private Long managerId;
	
	

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public String getDirPath() {
		if(StringUtils.hasLength(dirPath)){
			return dirPath + "%";
		}
		return null;
	}

	public void setDirPath(String dirPath) {
		this.dirPath = dirPath;
	}

	public Long getParentId() {
		
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}

	public Long getManagerId() {
		return managerId;
	}

	public void setManagerId(Long managerId) {
		this.managerId = managerId;
	}
}
