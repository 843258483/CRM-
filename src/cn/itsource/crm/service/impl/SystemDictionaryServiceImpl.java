package cn.itsource.crm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.SystemDictionary;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.SystemDictionaryMapper;
import cn.itsource.crm.service.ISystemDictionaryService;

@Service
public class SystemDictionaryServiceImpl extends BaseServiceImpl<SystemDictionary> implements ISystemDictionaryService {

	@Autowired
	private SystemDictionaryMapper systemDictionaryMapper;

	@Override
	protected BaseMapper<SystemDictionary> getBaseMapper() {
		
		return systemDictionaryMapper;
	}
	
}
