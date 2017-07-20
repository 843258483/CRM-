package cn.itsource.crm.service.impl;

import java.io.File;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.itsource.crm.domain.Menu;
import cn.itsource.crm.domain.Resource;
import cn.itsource.crm.mapper.BaseMapper;
import cn.itsource.crm.mapper.ResourceMapper;
import cn.itsource.crm.query.PageList;
import cn.itsource.crm.service.IResourceService;
import cn.itsource.crm.util.ResourceControlled;

@Service
public class ResourceServiceImpl extends BaseServiceImpl<Resource> implements IResourceService {
	@Autowired
	private ResourceMapper resourceMapper;

	@Override
	protected BaseMapper<Resource> getBaseMapper() {
		return resourceMapper;
	}

	@Override
	public PageList findByPermissionId(Long permissionId) {
		PageList pageList = new PageList();
		int total = resourceMapper.findCountByPermissionId(permissionId);
		if (total == 0) {
			return pageList;
		}
		List<Resource> list = resourceMapper.findByPermissionId(permissionId);
		pageList.setRows(list);
		pageList.setTotal(total);
		return pageList;
	}

	@Override
	public void loadResource() {
		// 保存controller包里面所有类的全限定名
		List<String> qualifiedNameList = new ArrayList<>();
		// 获取编译后的路径
		String packageName = "com.champion.crm.web.controller";
		String packagePath = "";
		String path = getClass().getResource("/").getFile().toString();
		packagePath = path.replace("webapp/WEB-INF/classes", "java").substring(1) + packageName.replace(".", "/");
		File dir = new File(packagePath);
		// 获取包里面所有class文件
		File[] dirfiles = dir.listFiles();
		for (File file : dirfiles) {
			String name = file.getName();
			// 排除非.class结尾的文件 (因为项目里包含 一个隐藏的.svn文件 把它排除掉)
			if (name.endsWith(".java")) {
				// 去点.class后缀 得到全限定名称
				String className = file.getName().substring(0, file.getName().length() - 5);
				String qualifiedName = packageName + "." + className;
				qualifiedNameList.add(qualifiedName);
			}
		}

		// 读取标注的资源
		List<Resource> resources = new ArrayList<>();
		for (String qualifiedName : qualifiedNameList) {
			try {
				Class<?> clz = Class.forName(qualifiedName);
				Method[] methods = clz.getDeclaredMethods();
				for (Method method : methods) {
					ResourceControlled annotation = method.getAnnotation(ResourceControlled.class);
					if (annotation != null) {
						Resource resource = new Resource();
						resource.setName(annotation.value());
						resource.setUrl(clz.getName() + "." + method.getName());
						resources.add(resource);
					}
				}
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		}

		// 如果权限控制资源有增减，则重新读取
		if (resources.size() != getAll().size()) {
			resourceMapper.deleteResource();
			for (Resource resource : resources) {
				resourceMapper.saveResource(resource);
			}
		}
	}

	@Override
	public PageList findChildrenMenu() {
		List<Menu> list = resourceMapper.findChildrenMenu();
		PageList pageList = new PageList();
		int total = resourceMapper.findCountChildrenMenu();
		pageList.setRows(list);
		pageList.setTotal(total);
		return pageList;
	}

}
