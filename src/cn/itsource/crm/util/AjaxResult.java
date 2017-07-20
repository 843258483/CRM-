package cn.itsource.crm.util;

public class AjaxResult {
	private Boolean success=true;
	private String  message="操作成功!";
	public AjaxResult() {
	}
	
	public AjaxResult(String message) {
		this.success = false;
		this.message = message;
	}
	public Boolean getSuccess() {
		return success;
	}
	public void setSuccess(Boolean success) {
		this.success = success;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
}
