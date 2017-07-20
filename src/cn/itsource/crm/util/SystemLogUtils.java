package cn.itsource.crm.util;

import java.util.Date;

import org.aspectj.lang.JoinPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import cn.itsource.crm.domain.Employee;
import cn.itsource.crm.domain.SystemLog;
import cn.itsource.crm.service.ISystemLogService;
@Component
public class SystemLogUtils {

	//注入service
	@Autowired
	private ISystemLogService logService;
	
	public void writeLog(JoinPoint joinPoint){
		//创建日志对象
		SystemLog systemLog = new SystemLog();
		//封装对象，给对象设置属性
		systemLog.setOpTime(new Date());
		 Object target = joinPoint.getTarget();
		    // 判断是否重复加载
		    if (target instanceof ISystemLogService) {
		      return;
		    }
		Employee user = UserContext.getUser();
		if(user ==null){
			return;
		}
//		systemLog.setOpUser(user);
		//获得动态Ip地址
		systemLog.setOpIp(UserContext.getRequest().getRemoteAddr());
		String name = joinPoint.getTarget().getClass().getName();
		String method = joinPoint.getSignature().getName();
		String function = name+":"+method;
		systemLog.setFunction(function);
		//保存日志文件到数据库
		logService.save(systemLog);
	}
}
