package cn.itsource.crm.domain;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * @author Administrator
 *	客户模型
 */
	public class Customer {
		private Long id;  //主键 id 无业务意义
		private String name;  //基本资料 姓名
		private Integer gender=2; // 0代表女士 1 代表男人 2表示客户没有留下 性别
		private Integer age; // 年龄 
		private String tel;	// 联系方式
		private String email;	//email 邮箱
		private String qq;	//qq号码
		private String wechat;	//微信
		private Date inputTime = new Date();
		private Integer state = 0; // 0正常，-1作废（放入资源池）
		private Employee seller;// 营销人员
		private Employee inputUser;// 录入人员 
		// 扩展信息
		private SystemDictionaryItem job;// 客户职业
		private SystemDictionaryItem customerSource;// 客户来源
		private SystemDictionaryItem salaryLevel; // 薪资等级
		
		
		public Customer(){}
		public Customer(Long id){
			this.id=id;
		}
		public SystemDictionaryItem getJob() {
			return job;
		}
		public void setJob(SystemDictionaryItem job) {
			this.job = job;
		}
		public SystemDictionaryItem getCustomerSource() {
			return customerSource;
		}
		public void setCustomerSource(SystemDictionaryItem customerSource) {
			this.customerSource = customerSource;
		}
		public SystemDictionaryItem getSalaryLevel() {
			return salaryLevel;
		}
		public void setSalaryLevel(SystemDictionaryItem salaryLevel) {
			this.salaryLevel = salaryLevel;
		}
		public Long getId() {
			return id;
		}
		public void setId(Long id) {
			this.id = id;
		}
		
		public String getText() {
			return name;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public Integer getGender() {
			return gender;
		}
		public void setGender(Integer gender) {
			this.gender = gender;
		}
		public Integer getAge() {
			return age;
		}
		public void setAge(Integer age) {
			this.age = age;
		}
		public String getTel() {
			return tel;
		}
		public void setTel(String tel) {
			this.tel = tel;
		}
		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}
		public String getQq() {
			return qq;
		}
		public void setQq(String qq) {
			this.qq = qq;
		}
		public String getWechat() {
			return wechat;
		}
		public void setWechat(String wechat) {
			this.wechat = wechat;
		}
		@JsonFormat(pattern="yyyy-MM-dd",timezone="GMT+8")
		public Date getInputTime() {
			return inputTime;
		}
		@DateTimeFormat(pattern="yyyy-MM-dd")
		public void setInputTime(Date inputTime) {
			this.inputTime = inputTime;
		}
		public Integer getState() {
			return state;
		}
		public void setState(Integer state) {
			this.state = state;
		}
		public Employee getSeller() {
			return seller;
		}
		public void setSeller(Employee seller) {
			this.seller = seller;
		}
		public Employee getInputUser() {
			return inputUser;
		}
		public void setInputUser(Employee inputUser) {
			this.inputUser = inputUser;
		}
		@Override
		public String toString() {
			return "Customer [id=" + id + ", name=" + name + ", gender=" + gender + ", age=" + age + ", tel=" + tel
					+ ", email=" + email + ", qq=" + qq + ", wechat=" + wechat + ", inputTime=" + inputTime + ", state="
					+ state + ", seller=" + seller + ", inputUser=" + inputUser + ", job=" + job + ", customerSource="
					+ customerSource + ", salaryLevel=" + salaryLevel + "]";
		}
		
}