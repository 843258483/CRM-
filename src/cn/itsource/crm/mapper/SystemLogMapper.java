package cn.itsource.crm.mapper;

import cn.itsource.crm.domain.SystemLog;

public interface SystemLogMapper extends BaseMapper<SystemLog> {

	//清除所有日志
	void deleteAll();
}
