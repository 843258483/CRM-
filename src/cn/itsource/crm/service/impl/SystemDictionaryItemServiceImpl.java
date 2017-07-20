package cn.itsource.crm.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.SystemDictionaryItem;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.SystemDictionaryItemMapper;
import cn.itsource.crm.service.ISystemDictionaryItemService;

@Service
public class SystemDictionaryItemServiceImpl extends BaseServiceImpl<SystemDictionaryItem> implements ISystemDictionaryItemService {
	@Autowired
	private SystemDictionaryItemMapper systemDictionaryItemMapper;
	@Override
	protected BaseMapper<SystemDictionaryItem> getBaseMapper() {
		return systemDictionaryItemMapper;
	}
	@Override
	public List<SystemDictionaryItem> getChildren(Long id) {
		
		return systemDictionaryItemMapper.getChildren(id);
	}

	
}
