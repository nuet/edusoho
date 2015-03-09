package com.et.edusoho.web.tag;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;

import com.et.edusoho.admin.menu.bean.Menu;
import com.et.edusoho.login.bean.User;
import com.et.edusoho.tools.CONSTANTCONTEXT;

public class MenuTagSupport extends TagSupport {

	private static final long serialVersionUID = 1L;
	
	private static Logger logger = Logger.getLogger(MenuTagSupport.class);
	
	private String context = null;
	
	@Override
	public int doEndTag() throws JspException {
		try {
			
			this.context = pageContext.getServletContext().getContextPath();
			
			String menuBody = createMenuBody();
			pageContext.getOut().print(menuBody);
		} catch (IOException e) {
			logger.warn("创建用户菜单出错,"+e.getMessage(), e);
		}

		return SKIP_BODY;
	}

	
	@SuppressWarnings("unchecked")
	private String createMenuBody() {
		
		List<Menu> menus = (List<Menu>) pageContext.getServletContext().
				getAttribute(CONSTANTCONTEXT.USER_MENU);
		
		if (menus == null) {
			return "<div class='alert alert-danger' role='alert'>目前系统无法显示导航菜单 !</div>";
		}
		
		HttpSession session = pageContext.getSession();
		
		User user = (User) session.getAttribute(CONSTANTCONTEXT.USER);
		
		return createNavigation(menus, user);
	}
	

	private String createNavigation(List<Menu> menus, User user) {
		
		StringBuffer buffer = new StringBuffer();
		
		initNavbarHead(buffer);
		
		if (menus.size() > 0) {
			createNavbarMenuBody(buffer, getSortMenus(menus,"0"));
		}
		
		initNavbarEnd(buffer, user);
		
		return buffer.toString();
	}

	
	private void initNavbarHead(StringBuffer buffer){
		
		String navbarTitle = (String) pageContext.getServletContext().getAttribute(CONSTANTCONTEXT.NAVBAR_TITLE);
		
		if (StringUtils.isEmpty(navbarTitle)) {
			navbarTitle = "";
		}
		
		buffer.append("<div class='navbar-inverse'><div class='container-fluid'><div class='navbar-header'>");
		buffer.append("<button type='button' class='navbar-toggle collapsed' data-toggle='collapse' data-target='#bs-example-navbar-collapse-1'>");
		buffer.append("<span class='sr-only'>Toggle navigation</span> <span class='icon-bar'></span>");
		buffer.append("<span class='icon-bar'></span> <span class='icon-bar'></span></button>");
		
		buffer.append("<a class='navbar-brand' href='").append(context).append("'>").append(navbarTitle).append("</a></div>");
		buffer.append("<div class='collapse navbar-collapse' id='bs-example-navbar-collapse-1'>");
		buffer.append("<ul class='nav navbar-nav'>");
		
	}
	
	private List<MenuItem> getSortMenus(List<Menu> menus, String pid) {
		List<MenuItem> items = new LinkedList<MenuItem>();
		for (Menu menu : menus) {
			if (menu.getPid().equals(pid)) {
				MenuItem item = new MenuItem(menu, getSortMenus(menus,menu.getId()));
				items.add(item);
			}
		}

		return items;
	}
	
	private void createNavbarMenuBody(StringBuffer buffer, List<MenuItem> menus){
		
		for (MenuItem item : menus) {
			
			Menu menu = item.getMenu();
			List<MenuItem> subMenus = item.getSubMenus();
			
			buffer.append("<li");
			
			if (subMenus.size() > 0) {
				if ("0".equals(menu.getPid())) {
					buffer.append(" class='dropdown'>");
				}else {
					buffer.append(" class='dropdown-submenu'>");
				}
				
				buffer.append("<a href='#' class='dropdown-toggle' data-toggle='dropdown' role='button' aria-expanded='false'>");
				buffer.append(menu.getName()).append("<span class='caret'></span></a>");
				buffer.append("<ul class='dropdown-menu' role='menu'>\n");
				
				createNavbarMenuBody(buffer, subMenus);
				
			}else {
				buffer.append("><a href='").append(menu.getUrl()).append("' >").append(menu.getName());
				buffer.append("</a></li>");
			}
			
			buffer.append("</li>\n");
		}
		
		buffer.append("</ul>\n");
	}
	
	
	private void initNavbarEnd(StringBuffer buffer, User user) {
		if (user != null) {
			
			
		}else {
			buffer.append("<ul class='nav navbar-nav navbar-right'>");
			buffer.append("<li><a href='search.jsp'><span class='glyphicon glyphicon-search'></span>&nbsp;搜索</a></li>");
			buffer.append("<li><a href='").append(context).append("/").append("toLogin").append("'>");
			buffer.append("<span class='glyphicon glyphicon-hand-right'></span>&nbsp;登录</a></li>");
			buffer.append("<li><a href='addUser.jsp'><span class='glyphicon glyphicon-user'></span>&nbsp;注册</a></li>");
			buffer.append("</ul>");
		}
		
		buffer.append("</div></div></div>");
	}

	@Override
	public int doStartTag() throws JspException {
		
		return SKIP_BODY;
	}
}
