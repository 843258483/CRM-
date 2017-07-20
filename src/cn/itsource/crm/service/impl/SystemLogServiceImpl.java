package cn.itsource.crm.service.impl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.SystemLog;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.SystemLogMapper;
import cn.itsource.crm.service.ISystemLogService;

@Service
public class SystemLogServiceImpl extends BaseServiceImpl<SystemLog> implements ISystemLogService {
	@Autowired
	private SystemLogMapper systemLogMapper;
	@Override
	protected BaseMapper<SystemLog> getBaseMapper() {
		return systemLogMapper;
	}

	@Override
	public void deleteAll() {
		
		systemLogMapper.deleteAll();
		
	}

	
}
