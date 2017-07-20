package cn.itsource.crm.domain;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;



/**
 * @author dcz
 * 合同模型：
 *
 */
public class Contract {
	private Long id;
	private String sn;//合同编号，自动生成，使用uuid的前6位
	private Date signTime;//合同的签订时间
	private String intro;//合同摘要
	private BigDecimal sum;//客户所需要交纳的全款:由首付+剩下部分（可能会是分期付款）构成
	private Integer state = 0;//值可以为0：正常， 1：作废， -1：请选择
	
	private Employee seller;//此客户的营销人员
	private Customer customer;//签订合同的顾客
	private List<ContractItem> items = new ArrayList<ContractItem>();//用来装合同明细的集合
	
	
	
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getSn() {
		return sn;
	}
	public void setSn(String sn) {
		this.sn = sn;
	}
	public Customer getCustomer() {
		return customer;
	}
	public void setCustomer(Customer customer) {
		this.customer = customer;
	}
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getSignTime() {
		return signTime;
	}
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public void setSignTime(Date signTime) {
		this.signTime = signTime;
	}
	public Employee getSeller() {
		return seller;
	}
	public void setSeller(Employee seller) {
		this.seller = seller;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public BigDecimal getSum() {
		return sum;
	}
	public void setSum(BigDecimal sum) {
		this.sum = sum;
	}
	public List<ContractItem> getItems() {
		return items;
	}
	public void setItems(List<ContractItem> items) {
		this.items = items;
	}
	
	
	@Override
	public String toString() {
		return "Contract [id=" + id + ", sn=" + sn + ", signTime=" + signTime + ", intro=" + intro + ", sum=" + sum
				+ ", state=" + state + "]";
	}
	
	

}
