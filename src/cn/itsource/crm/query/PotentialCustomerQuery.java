package cn.itsource.crm.query;

/**
 * 子类的查询条件
 * 
 * @author Arick
 *
 */
public class PotentialCustomerQuery extends BaseQuery {
	private String order = "asc";
	private String sort="o.id";
	private Integer maxSuccesNum ;
	private Integer mixSuccesNum ;
	private Integer sourceId;
	
	
	public Integer getSourceId() {
		return sourceId;
	}
	public void setSourceId(Integer sourceId) {
		this.sourceId = sourceId;
	}
	public Integer getMaxSuccesNum() {
		return maxSuccesNum;
	}
	public void setMaxSuccesNum(Integer maxSuccesNum) {
		this.maxSuccesNum = maxSuccesNum;
	}
	public Integer getMixSuccesNum() {
		return mixSuccesNum;
	}
	public void setMixSuccesNum(Integer mixSuccesNum) {
		this.mixSuccesNum = mixSuccesNum;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	
	
}
