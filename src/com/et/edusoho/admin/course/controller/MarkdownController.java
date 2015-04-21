package com.et.edusoho.admin.course.controller;


import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.et.edusoho.admin.course.service.MarkdownService;
import com.et.edusoho.support.constroller.BaseController;

@Controller
@RequestMapping("/admin/*")
public class MarkdownController extends BaseController{
	
	private static Logger logger = Logger.getLogger(MarkdownController.class);
	
	@Autowired
	private MarkdownService mkdnService;
	
	public MarkdownController(){
		super("admin/course/lesson/type/");
	}
	
	@RequestMapping("course/lesson/toAddMarkdown")
	public String toMarkdown(){
		return getContext("markdown");
	}
	
	@RequestMapping("course/lesson/add")
	public String toAdd(final ModelMap modelMap,
			@RequestParam Map<String, String> params){
		
		mkdnService.addMarkdown(params);
		
		return "";
	}
	
	@RequestMapping("course/lesson/uploadMD")
	public void uploadFile(@RequestParam("file") Object uploadFile,
			HttpServletRequest request, HttpServletResponse response){
		
		try {
			
			setWebContext(request, response);
			
			if (uploadFile instanceof MultipartFile) {
				MultipartFile file = (MultipartFile) uploadFile;
				
				String code = new String(file.getBytes(),"UTF-8");
				write(getEncoding(code));
			}
			
		} catch (Exception e) {
			logger.warn(e.getMessage(), e);
		}
	}
}