package cn.itsource.crm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.CutomerTransfer;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.CutomerTransferMapper;
import cn.itsource.crm.service.ICutomerTransferService;

@Service
public class CutomerTransferServiceImpl extends BaseServiceImpl<CutomerTransfer> implements ICutomerTransferService {
	@Autowired
	private CutomerTransferMapper cutomerTransferMapper;
	@Override
	protected BaseMapper<CutomerTransfer> getBaseMapper() {
		return cutomerTransferMapper;
	}

}
