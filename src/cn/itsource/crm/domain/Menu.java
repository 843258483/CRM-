package cn.itsource.crm.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 菜单模型：根据用户登录后的权限，不同的权限显示他对应的菜单
 * 
 * @author Arick
 *
 */
public class Menu {

	private Long id;

	private String name;// 菜单名称

	private String icon;// 菜单图标

	private String url;// 菜单url地址
	private String sn;
	private String intro;
	// 单向多对一
	private Menu parent;// 父菜单

	private List<Menu> children = new ArrayList<>();// 子菜单

	public Menu(){
		
	}
	
	public Menu(Long id, String name) {
		this.id = id;
		this.name = name;
	}

	public String getText() {
		return name;
	}

	public String getIconCls() {
		return icon;
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

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Menu getParent() {
		return parent;
	}

	public void setParent(Menu parent) {
		this.parent = parent;
	}

	public List<Menu> getChildren() {
		return children;
	}

	public void setChildren(List<Menu> children) {
		this.children = children;
	}

	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

}
