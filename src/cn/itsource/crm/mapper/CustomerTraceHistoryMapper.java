package cn.itsource.crm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import cn.itsource.crm.domain.CustomerTraceHistory;

public interface CustomerTraceHistoryMapper extends BaseMapper<CustomerTraceHistory> {
	
	@Select("select traceType_id from t_customerTraceHistory GROUP BY traceType_id")
	List<Long> getAllTypes();
	@Select("select traceResult from t_customerTraceHistory WHERE o.traceType_id=#{long1}")
	List<Long> getStatsByType(Long long1);
}
