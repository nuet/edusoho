package com.et.edusoho.course.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.et.edusoho.course.bean.Chapter;
import com.et.edusoho.course.bean.Course;
import com.et.edusoho.course.bean.Lesson;
import com.et.edusoho.course.service.ChapterService;
import com.et.edusoho.course.service.CourseService;
import com.et.edusoho.course.service.LessonService;
import com.et.edusoho.support.constroller.BaseController;
import com.et.edusoho.tools.CONSTANTCONTEXT;
import com.et.edusoho.tools.DateUtil;
import com.et.edusoho.tools.FileUtil;
import com.et.edusoho.tools.PathUtil;

@Controller
@RequestMapping("/admin/*")
public class LessonController extends BaseController {
	
	private static Logger logger = Logger.getLogger(LessonController.class);
	
	@Autowired
	private CourseService courseService;
	
	@Autowired
	private ChapterService chapterService;
	
	@Autowired
	private LessonService lessonService;
	
	public LessonController(){
		super("admin/course/lesson/",CONSTANTCONTEXT.LESSON_FILE_DIR);
	}
	
	@RequestMapping("course/lesson/toAdd")
	public String toAdd(){
		return getContext("add");
	}
	
	@RequestMapping("course/lesson/toAddVideo")
	public String toAddVideo(){
		return getContext("type/video");
	}
	
	@RequestMapping("course/lesson/toAddAudio")
	public String toAddAudio(){
		return getContext("type/audio");
	}
	
	@RequestMapping("course/lesson/toAddText")
	public String toAddText(){
		return getContext("type/text");
	}
	
	
	@RequestMapping("course/lesson/toAddCode")
	public String toAddDoc(){
		return getContext("type/code");
	}
	
	@RequestMapping("course/lesson/add")
	public String add(final ModelMap modelMap, @RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response){
		
		String courseId =  params.get("courseId") == null? "" : params.get("courseId");
		
		try {
			
			setWebContext(request, response);
			
			if (params.size() > 0) {
				
				Course course = courseService.viewById(params.get("courseId"));
				params.put("seq", course.getMaxSeq());
				
				params.put("creater", getUserId());
				lessonService.addMarkdown(params);
				courseService.updateSeq(courseId);
			}
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
		}
		
		
		return "redirect:/admin/course/lesson?active=lesson&id=" + courseId;
	}
	
	@RequestMapping("course/lesson")
	public String toLesson(final ModelMap modelMap,
			@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response){
		
		try {
			
			setWebContext(request, response);
			
			Course course = courseService.view(params);
			
			if (course !=  null) {
				
				String courseId = course.getId();
				
				List<Lesson> lessons = lessonService.getListByCourseId(courseId);
				List<Chapter> chapters = chapterService.getListByCourseId(courseId);
				
				modelMap.addAttribute("lessons", lessons);
				modelMap.addAttribute("chapters", chapters);
				modelMap.addAttribute("course", course);
			}
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
		}
		
		return getContext("list");
	}
	
	@RequestMapping("course/lesson/uploadFile")
	public void uploadFile(@RequestParam("upload") Object uploadFile,
			HttpServletRequest request, HttpServletResponse response){
		
		try {
			
			
			String callback = request.getParameter("CKEditorFuncNum");    
			
			String fileName = DateUtil.getFileNameTime();

			this.setWebContext(request, response);

			String newFileName = super.upload(uploadFile, fileName);
			
			String path = PathUtil.getHttpPath(request) + "/admin/course/lesson/downloadFile?file=" + newFileName ;
			
			write("<script type=\'text/javascript\'>window.parent.CKEDITOR.tools.callFunction(" 
					+ callback + ",'"+path+ "','')</script>");

		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
			write("");
		}
	}
	
	@RequestMapping("course/lesson/downloadFile")
	public synchronized void  downloadFile(@RequestParam Map<String, String> params,
			HttpServletRequest request, HttpServletResponse response){
		
		try {
			
			this.setWebContext(request, response);

			download(params);

		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
		}
	}
	
	
	@RequestMapping("course/lesson/Images")
	public String getImages(final ModelMap modelMap,
			HttpServletRequest request, HttpServletResponse response){
		
		try {
			
			this.setWebContext(request, response);
			
			modelMap.addAttribute("images", FileUtil.findLessonImage());
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
		}
		
		return getContext("type/showImages");
	}
}