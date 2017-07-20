package cn.itsource.crm.service;

import cn.itsource.crm.domain.SystemLog;

public interface ISystemLogService extends IBaseService<SystemLog> {

	//清除所有日志
	void deleteAll();
}