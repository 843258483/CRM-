package cn.itsource.crm.domain;

import java.io.Serializable;

/**数据字典明细*/
public class SystemDictionaryItem {
	//id
	private Long id;
	//字典明细名称
	private String name;
	//字典明细简介
	private String intro;
	//字典目录,字典目录对象(多对一)
	private SystemDictionary parent;
	private int sequence;
	//兼容easyUI前台展示
	public String getText() {
		return name;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
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
	public SystemDictionary getParent() {
		return parent;
	}
	public void setParent(SystemDictionary parent) {
		this.parent = parent;
	}
	public int getSequence() {
		return sequence;
	}
	public void setSequence(int sequence) {
		this.sequence = sequence;
	}
	@Override
	public String toString() {
		return "SystemDictionaryItem [id=" + id + ", name=" + name + ", intro=" + intro + ", parent=" + parent
				+ ", sequence=" + sequence + "]";
	}
	
}
