package com.et.edusoho.course.service;

import java.util.List;
import java.util.Map;

import com.et.edusoho.course.bean.Category;

public interface CategoryService {

	public void add(Map<String, String> params);

	public List<Category> list(Map<String, Object> params);

	public void delete(Map<String, String> params);

}