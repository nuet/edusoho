package com.et.edusoho.admin.course.service;

import java.util.List;

import com.et.edusoho.admin.course.bean.Lesson;

public interface LessonService {

	public List<Lesson> getListByCourseId(String courseId);


}
