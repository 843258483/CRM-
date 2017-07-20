package cn.itsource.crm.query;

/**
 * 子类的查询条件
 * 
 * @author dcz
 *
 */
public class CustomerTraceHistoryQuery extends BaseQuery {
	//分类条件
	private String sort="o.id";
	//分组条件
	private String groupBy;
	
	
	public String getGroupBy() {
		return groupBy;
	}

	public void setGroupBy(String groupBy) {
		this.groupBy = groupBy;
	}

	//分类顺序
	private String order="asc";

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}
}
