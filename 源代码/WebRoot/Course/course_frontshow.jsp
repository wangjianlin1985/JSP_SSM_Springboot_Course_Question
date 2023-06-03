<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Course" %>
<%@ page import="com.chengxusheji.po.Teacher" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    //获取所有的teacherObj信息
    List<Teacher> teacherList = (List<Teacher>)request.getAttribute("teacherList");
    Course course = (Course)request.getAttribute("course");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>查看课程详情</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li><a href="<%=basePath %>Course/frontlist">课程信息</a></li>
  		<li class="active">详情查看</li>
	</ul>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">课程编号:</div>
		<div class="col-md-10 col-xs-6"><%=course.getCourseNo()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">课程名称:</div>
		<div class="col-md-10 col-xs-6"><%=course.getCourseName()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">课程介绍:</div>
		<div class="col-md-10 col-xs-6"><%=course.getCourseDesc()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">总学时:</div>
		<div class="col-md-10 col-xs-6"><%=course.getCourseHours()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">课程学分:</div>
		<div class="col-md-10 col-xs-6"><%=course.getCourseScore()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">上课教室:</div>
		<div class="col-md-10 col-xs-6"><%=course.getCoursePlace()%></div>
	</div>
	<div class="row bottom15"> 
		<div class="col-md-2 col-xs-4 text-right bold">上课老师:</div>
		<div class="col-md-10 col-xs-6"><%=course.getTeacherObj().getName() %></div>
	</div>
	<div class="row bottom15">
		<div class="col-md-2 col-xs-4"></div>
		<div class="col-md-6 col-xs-6">
			<button onclick="courseApply();" class="btn btn-primary">申请课程</button>
			<button onclick="history.back();" class="btn btn-info">返回</button>
		</div>
	</div>
</div> 
<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script>
var basePath = "<%=basePath%>";



function courseApply() {
	  
	$.ajax({
		url : basePath + "CourseApply/userAdd",
		type : "post",
		dataType: "json",
		data: {
			"courseApply.courseObj.courseNo": "<%=course.getCourseNo() %>",
		},
		success : function (data, response, status) {
			//var obj = jQuery.parseJSON(data);
			if(data.success){
				alert("申请提交成功~");
				location.reload();
			}else{
				alert(data.message);
			}
		}
	});
}



$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
 })
 </script> 
</body>
</html>

