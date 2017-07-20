package cn.itsource.crm.domain;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 保修单明细
 * 
 * @author Arick
 *
 */
public class GuaranteeItem {
	private Long id;
	private Date guaranteeTime;// 保修时间(必填)
	private String content;// 保修内容(必填)
	private Boolean solve;// 是否解决(解决->true;未解决->false)
	private Guarantee guarantee;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
	public Date getGuaranteeTime() {
		return guaranteeTime;
	}
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	public void setGuaranteeTime(Date guaranteeTime) {
		this.guaranteeTime = guaranteeTime;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Boolean getSolve() {
		return solve;
	}

	public void setSolve(Boolean solve) {
		this.solve = solve;
	}

	public Guarantee getGuarantee() {
		return guarantee;
	}

	public void setGuarantee(Guarantee guarantee) {
		this.guarantee = guarantee;
	}

	@Override
	public String toString() {
		return "GuaranteeItem [id=" + id + ", guaranteeTime=" + guaranteeTime + ", content=" + content + ", solve="
				+ solve + "]";
	}

}
