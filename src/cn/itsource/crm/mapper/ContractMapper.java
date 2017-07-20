package cn.itsource.crm.mapper;

import java.math.BigDecimal;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import cn.itsource.crm.domain.Contract;

public interface ContractMapper extends BaseMapper<Contract> {
	//改变他的state为作废
	@Delete("update t_contract set state= 1 where id=#{id}")
	void deleteContract(Long id);
	//查询和合同关联的订单的id
	@Select("select id from t_order where contract_id = #{id}")
	Long getOrderByContract(Long id);
	
	//查询和合同关联的保修单的id
	@Select("select id from t_guarantee where contract_id = #{id}")
	Long getGuaranteeByContract(Long id);
	
	//通过顾客id来统计他的合同总金额
	@Select("select SUM(sum) from t_contract where customer_id = #{id}")
	BigDecimal totalSum(Long id);
	
	//拿到所有有业绩的销售人员id
	@Select("select seller_id from t_contract GROUP BY seller_id")
	List<Long> allSeller();
	
	//通过顾客id来统计他的合同总金额
	@Select("select SUM(sum) from t_contract where seller_id = #{id}")
	BigDecimal totalSumBySeller(Long id);
}
