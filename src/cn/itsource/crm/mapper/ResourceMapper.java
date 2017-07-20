package cn.itsource.crm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;

import cn.itsource.crm.domain.Menu;
import cn.itsource.crm.domain.Resource;

public interface ResourceMapper extends BaseMapper<Resource> {
	
	List<Resource> findByPermissionId(Long id);
	
	int findCountByPermissionId(Long permissionId);

	@Delete("delete from t_resource")
	void deleteResource();

	void saveResource(Resource resources);

	List<Menu> findChildrenMenu();
	
	int findCountChildrenMenu();
}
