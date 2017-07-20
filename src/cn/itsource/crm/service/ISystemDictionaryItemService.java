package cn.itsource.crm.service;

import java.util.List;

import cn.itsource.crm.domain.SystemDictionaryItem;

public interface ISystemDictionaryItemService extends IBaseService<SystemDictionaryItem> {
	
	//通过一个父id获取字典明细
		public List<SystemDictionaryItem> getChildren(Long id);
}