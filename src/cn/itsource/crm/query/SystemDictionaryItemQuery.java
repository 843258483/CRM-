package cn.itsource.crm.query;

/**
 * 子类的查询条件
 * 
 * @author Arick
 *
 */
public class SystemDictionaryItemQuery extends BaseQuery {

	private Long parentId;

	public Long getParentId() {
		return parentId;
	}

	public void setParentId(Long parentId) {
		this.parentId = parentId;
	}
	
	
}
