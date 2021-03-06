package com.et.edusoho.admin.curriculum.dao;

import java.util.List;
import java.util.Map;

import com.et.edusoho.course.bean.Course;

public interface CurriculumDao {

	public void create(Map<String, String> params);

	public List<Course> getAll(Map<String, String> params);

	public void update(Map<String, String> params);

	public void delete(Map<String, String> params);

	public Course view(Map<String, String> params);
}
