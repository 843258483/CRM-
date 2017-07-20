package cn.itsource.crm.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**数据字典模型*/
public class SystemDictionary {
	//ID主键
	private Long id;
	//字典目录名称
	private String name;
	//字典目录编号
	private String sn;
	//字典目录简介
	private String intro;
	//状态:1正常 -1停用
	private Integer state;
	//字典明细,一对多
	private List<SystemDictionaryItem> details = new ArrayList<>();
	
	public List<SystemDictionaryItem> getDetails() {
		return details;
	}
	public void setDetails(List<SystemDictionaryItem> details) {
		this.details = details;
	}
	
	public String getText() {
		return name;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIntro() {
		return intro;
	}
	public void setIntro(String intro) {
		this.intro = intro;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	
	@Override
	public String toString() {
		return "SystemDictionary [id=" + id + ", sn=" + sn + ", name=" + name + ", intro=" + intro + ", state=" + state
				+ "]";
	}

}
