package cn.itsource.crm.domain;

import java.io.Serializable;

/**
 * 资源模型
 * 
 * @author Arick
 *
 */
public class Resource {
	private Long id;
	private String name;// 资源名称
	private String url;// 资源路径
	private Menu menu;// 所属菜单

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

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}

}
