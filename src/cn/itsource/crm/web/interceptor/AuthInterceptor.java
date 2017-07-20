package cn.itsource.crm.web.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import cn.itsource.crm.domain.Employee;
import cn.itsource.crm.service.IEmployeeService;
import cn.itsource.crm.util.UserContext;

public class AuthInterceptor implements HandlerInterceptor {
	@Autowired
	IEmployeeService employeeService;

	// 在调用控制器方法前，拦截
	// true->不拦截 ，false->拦截
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String uri = request.getRequestURI();
		// 不需要拦截的放行
		// 登录注销不需要拦截
		if (uri.endsWith("/login") || uri.endsWith("/logout")) {
			return true;
		}
		// 登录拦截
		Employee employee = UserContext.getEmployee(request.getSession());
		if (employee == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return false;
		}
		// 3.权限拦截:只拦截动态请求
		if (handler instanceof HandlerMethod) {
			HandlerMethod controller = (HandlerMethod) handler;
			// 访问具体哪个控制器
			String classMethodName = controller.getBeanType().getName() + "." + controller.getMethod().getName();
			String allClassMethodName = controller.getBeanType().getName() + ".ALL";
			List<String> allPermissionResouce = employeeService.getAllPermissionResouce();
			if (allPermissionResouce.contains(classMethodName) || allPermissionResouce.contains(allClassMethodName)) {
				List<String> list = employeeService.findPermissionResouceByLoginUser(employee);
				if (list.contains(classMethodName) || list.contains(allClassMethodName)) {
				} else {
					request.getRequestDispatcher("/WEB-INF/views/noAuth.jsp").forward(request, response);
//					response.sendRedirect("p3.jsp");
					return false;// 没有权限，拦截权限
				}
			}

		}
		return true;
	}

	// 在调用控制器方法后，拦截（在生成视图之前）
	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3)
			throws Exception {

	}

	// 在视图生成之后（后台所有所有逻辑都完成后）
	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {

	}

}
