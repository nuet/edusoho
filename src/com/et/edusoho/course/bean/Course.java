package com.et.edusoho.course.bean;

public class Course implements Comparable<Course>{

	private long id;

	private String title;

	private String subtitle;

	private String status;

	private String type;

	private String createTime;

	private String learnTime;

	private String openLearner;

	private String creater;

	private String about;

	private String goals;

	private String audiences;

	private String recommended;

	private String recommendedTime;

	private String logoImage;

	private String maxSeq;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getSubtitle() {
		return subtitle;
	}

	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getLearnTime() {
		return learnTime;
	}

	public void setLearnTime(String learnTime) {
		this.learnTime = learnTime;
	}

	public String getCreater() {
		return creater;
	}

	public void setCreater(String creater) {
		this.creater = creater;
	}

	public String getAbout() {
		return about;
	}

	public void setAbout(String about) {
		this.about = about;
	}

	public String getGoals() {
		return goals;
	}

	public void setGoals(String goals) {
		this.goals = goals;
	}

	public String getAudiences() {
		return audiences;
	}

	public void setAudiences(String audiences) {
		this.audiences = audiences;
	}

	public String getRecommended() {
		return recommended;
	}

	public void setRecommended(String recommended) {
		this.recommended = recommended;
	}

	public String getRecommendedTime() {
		return recommendedTime;
	}

	public void setRecommendedTime(String recommendedTime) {
		this.recommendedTime = recommendedTime;
	}

	public String getOpenLearner() {
		return openLearner;
	}

	public void setOpenLearner(String openLearner) {
		this.openLearner = openLearner;
	}

	public String getLogoImage() {
		return logoImage;
	}

	public void setLogoImage(String logoImage) {
		this.logoImage = logoImage;
	}

	public String getMaxSeq() {
		return maxSeq;
	}

	public void setMaxSeq(String maxSeq) {
		this.maxSeq = maxSeq;
	}

	public int compareTo(Course o) {
		return (int) (this.id - o.id);
	}
}
