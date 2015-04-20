<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%String basePath = request.getContextPath();%>
<form action="<%=basePath%>/admin/course/chapter/add" class="form-horizontal" id="addMarkDownForm" method="post">
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">标题</label>
		<div class="col-sm-9">
			<input type="text" class="form-control" id="title" name="title"
				placeholder="标题" />
		</div>
	</div>
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">摘要</label>
		<div class="col-sm-9">
			<textarea rows="3" cols="" class="form-control"></textarea>
		</div>
	</div>
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">代码</label>
			<div class="col-sm-9">
			   <ul class="nav nav-pills" style="margin-bottom: 5px;">
					<li role="presentation" class="active" id="li1"><a href="javascript:toMDShow('#uploadMd')">上传MD文件</a></li>
					<li role="presentation" id="li2"><a href="javascript:toMDShow('#editMd')">在线编辑</a></li>
			   </ul>
			   <div class="panel panel-default">
				   <div class="panel-body">
						<br /> 
						<div id="uploadMd">
							选择你要上传的文件<p/> 
							<button type="button" class="btn btn-primary" onclick="">上传文件</button>
							<br /> 
						</div>
						<div id="editMd" style="display: none;">
							<button type="button" class="btn btn-primary" onclick="toEdit()">编辑Markdown</button>
							&nbsp;&nbsp;<span style="color: #31708f;">点击按钮后，会弹出一个编写markdown的框</span>
							<br />&nbsp;
							<pre style="min-height: 100px;"><code id="markdownCode" style="font-family: '微软雅黑';"></code></pre>
						</div>
				   </div>
			   </div>
			  <input type="hidden" name="context" value="">
		</div>
	</div>
</form>
<script>
	function toEdit(){
		var xpwidth=window.screen.width-10;
        var xpheight=window.screen.height-35;
		window.open('<%=basePath%>/resource/editor/mdEditor.jsp', '_blank',
				'fullscreen,toolbar=no,location=no,directories=no,status=yes,resizable=yes,directories=no,top=0,left=0,width='+xpwidth+',height='+xpheight);
		
	}
	
	function toMDShow(panel){
		$(panel).show();
		$('#li2').attr("class","");
		$('#li1').attr("class","");
		if(panel == '#uploadMd'){
			$('#editMd').hide();
			$('#li1').attr("class","active");
		}else{
			$('#uploadMd').hide();
			$('#li2').attr("class","active");
		}
	}
</script>
