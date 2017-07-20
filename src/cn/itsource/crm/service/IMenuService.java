package cn.itsource.crm.service;

import cn.itsource.crm.domain.Menu;
import cn.itsource.crm.query.PageList;

public interface IMenuService extends IBaseService<Menu> {

	PageList findParentMenu();

}