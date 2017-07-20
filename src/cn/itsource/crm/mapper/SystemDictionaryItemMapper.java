package cn.itsource.crm.mapper;


import java.util.List;

import cn.itsource.crm.domain.SystemDictionaryItem;

public interface SystemDictionaryItemMapper extends BaseMapper<SystemDictionaryItem> {

	//通过一个父id获取字典明细
		public List<SystemDictionaryItem> getChildren(Long id);
}
