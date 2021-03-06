<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%String basePath = request.getContextPath();%>
<style type="text/css">
	ul{
		list-style: none;
	}
</style>
<form action="<%=basePath%>/course/lesson/add" class="form-horizontal" id="audioForm" method="post">
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">标题</label>
		<div class="col-sm-9">
			<input type="text" class="form-control" id="title" name="title" placeholder="标题" />
		</div>
	</div>
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">摘要</label>
		<div class="col-sm-9">
			<textarea rows="3" cols="" class="form-control"></textarea>
		</div>
	</div>
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">音频</label>
		<div class="col-sm-9">
			<ul class="nav nav-pills" style="margin-bottom: 5px;">
				<li role="presentation" class="active" id="vli1"><a href="javascript:toShow('#pill1')">上传音频</a></li>
				<li role="presentation" id="vli2"><a href="javascript:toShow('#pill2')">从课程文件中选择</a></li>
				<li role="presentation" id="vli3"><a href="javascript:toShow('#pill3')">导入网络音频</a></li>
			</ul>
			<div class="panel panel-default">
				<div class="panel-body">
					<div id="pill1">
						选择你要上传的音频文件：
						<p/>
						<button type="button" class="btn btn-primary" onclick="toSelect()" >上传文件</button>
						<p />
						<div class="alert alert-info" role="alert">
							<ul>
				                <li>支持<strong>mp3</strong>格式的音频文件上传，且文件大小不能超过<strong> 20MB</strong></li>
	                            <li>音频将上传到<strong>网站服务器</strong></li>
	                        </ul>
						</div>
						<span>
							<label id="upFile"></label>		
							<span id="auPlayer"></span>				
						</span>
					</div>
					<div id="pill2" style="height: 150px;display: none;overflow:auto;">
					</div>
					<div id="pill3" style="display: none;">
						输入下载的音频文件的网络的地址，点击导入即可:<p/>
						<div class="input-group">
					      <input type="text" class="form-control" placeholder="输入导入音频文件的地址" id="url">
					      <span class="input-group-btn">
					        <button class="btn btn-default" type="button" id="importBtn">导入</button>
					      </span>
					    </div>
					     <br/>
				        <span id="importTip">
				        </span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="form-group">
		<label for="title" class="col-sm-2 control-label">视频时长</label>
		<div class="col-sm-9">
			<div class="form-inline">
				<input type="text" class="form-control" style="width: 120px;" placeholder="分" name="minute"/>
					&nbsp;分&nbsp; &nbsp; 
					<input type="text" class="form-control" style="width: 120px;" placeholder="秒" name="second"/>
					&nbsp;秒&nbsp;
			</div>
			时长必须为整数。
		</div>
	</div>
	
	<input type="hidden" name="context">
	<input type="hidden" name="pId" value="${param.pId}">
	<input type="hidden" name="courseId" value="${param.courseId}">
	<input type="hidden" name="type" value="2">
</form>

<form id="audioFileForm"  action="<%=basePath%>/course/lesson/uploadFile"  enctype="multipart/form-data" method="post">
	<input type="file" name="upload" id="audioFile" style="display: none;">
</form>
<script type="text/javascript">
	
	var file;
	
	$(function(){
		$("#auPlayer").load('<%=basePath%>/resource/jPlayer/audioPlayer.jsp');
		$("#audioFile").change(function(){
			var fileName = $(this).val();
			var fileType=fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
			if(fileType != 'mp3'){
				alert("你选择的不是mp3音频文件，请重新选择!");
			}else{
				$("#audioFileForm").ajaxSubmit({
					dataType	: "text",
					type        : "POST",
					cache       : false,
					success		: function(data){
						$("[name=context]").val(data);
						file =  data;
						$("#upFile").html("你选择的mp3文件: <label>" + fileName  +
								"&nbsp;&nbsp;<span class='glyphicon glyphicon-play-circle' title='点击试听' onclick='toPlay()'></span></label>");
					}
				});
			}
		});
		
	
		$("#importBtn").bind("click",function(){
			var url = $("#url").val();
			if(url != "" && url != null && url != undefined){
				$.post("<%=basePath%>/course/lesson/toURLDownload", {'url': url}, 
					function(data){
			   		if(data == '-1' || data == '0'){
			   			alert("无法下载文件或者是下载文件失败");
			   		}else{
			   			$("[name=context]").val(data);
			   			file = data;
			   			$("#importTip").html("<label>导入成功，试听:&nbsp;&nbsp;<span class='glyphicon glyphicon-play-circle' title='点击试听' onclick='toPlay()'></span></label>");
			   		}
			   });
			}else{
				alert("请输入导入的音频的地址");
			}
		});
		
		$("#audioForm").validate({
			success:success,
			ignore: "",
			errorPlacement: showErrorTab,
			rules:{
				"title":{
					required: true
				},
				"minute":{
					required: false,
					rangelength: [0,60],
					digits: true
				},
				"second":{
					required: false,
					min: 0,
					digits: true
				}
			},
			messages:{
				"title": "标题是必填项",
				"minute":{
					rangelength : "分钟为0-60",
					digits:"只能为正整数"
				},
				"second":{
					min : "秒钟数要大于0",
					digits:"只能为正整数"
				}
			},
			submitHandler: function(form) {
				form.submit();
			}
		});
		
	});

	function toShow(panel){
		$(panel).show();
		$("#vli1").removeAttr("class");
		$('#vli2').removeAttr("class");
		$('#vli3').removeAttr("class");
		if(panel == '#pill1'){
			$('#vli1').attr("class","active");
			$("#pill2").hide();
			$("#pill3").hide();
		}else if(panel == '#pill2'){
			$('#vli2').attr("class","active");
			toFrom();
			$("#pill1").hide();
			$("#pill3").hide();
		}else{
			$('#vli3').attr("class","active");
			$("#pill1").hide();
			$("#pill2").hide();
		} 
	}
	
	function toFrom(){
		$.getJSON("<%=basePath%>/course/lesson/audios", function(json){
			$("#pill2").empty();
		   	for(var i in json){
		   		var bgc = "";
		   		if(json[i] == file){
		   			bgc = "#CCFFFF";
		   		}
		   		var templ = "<ol class='breadcrumb' style='background-color: " + bgc + "'>"+
		   		"<span class='glyphicon glyphicon-music'/>&nbsp;&nbsp;&nbsp;"+
		   		"<a id='a"+ i +"' href='javascript:slctFrom(\""+ json[i] + "\",\"#a"+i+"\")'>" + json[i] + "</a>&nbsp;&nbsp;&nbsp;&nbsp;"+
		   		"<span class='glyphicon glyphicon-play-circle' title='点击试听' onclick='toFromSlct(\"" + json[i]+ "\",this)'/></ol>";
		   		
		   		$("#pill2").append(templ);
		   	}
		});
	}
	
	function slctFrom(audioFile,obj){
		file = audioFile;
		$("[name=context]").val(audioFile);
		$("ol").css("background-color","");
		$(obj).parents("ol").css("background-color","#CCFFFF");
	}
	
	function toFromSlct(audioFile,obj){
		file = audioFile;
		$("[name=context]").val(audioFile);
		$("ol").css("background-color","");
		$(obj).parents("ol").css("background-color","#CCFFFF");
		toPlay(); 
	}
	
	function toSelect(){
		$("#audioFile").click();
	}
	
	function toPlay(){
		jplayer.jPlayer("setMedia", {
	        mp3: "<%=basePath%>/course/lesson/downloadFile?file=" + file
	    }).jPlayer("play");
	}
</script>