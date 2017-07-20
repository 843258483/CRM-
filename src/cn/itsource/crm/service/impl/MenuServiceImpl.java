package cn.itsource.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.Menu;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.MenuMapper;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.IMenuService;

@Service
public class MenuServiceImpl extends BaseServiceImpl<Menu> implements IMenuService {
	@Autowired
	private MenuMapper menuMapper;

	@Override
	protected BaseMapper<Menu> getBaseMapper() {
		return menuMapper;
	}

	@Override
	public PageList findParentMenu() {
		List<Menu> list = menuMapper.findParentMenu();
		PageList pageList = new PageList();
		int total = menuMapper.findCountParentMenu();
		pageList.setRows(list);
		pageList.setTotal(total);
		return pageList;
	}
	
}
