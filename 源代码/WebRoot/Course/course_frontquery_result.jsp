﻿<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Course" %>
<%@ page import="com.chengxusheji.po.Teacher" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Course> courseList = (List<Course>)request.getAttribute("courseList");
    //获取所有的teacherObj信息
    List<Teacher> teacherList = (List<Teacher>)request.getAttribute("teacherList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String courseNo = (String)request.getAttribute("courseNo"); //课程编号查询关键字
    String courseName = (String)request.getAttribute("courseName"); //课程名称查询关键字
    Teacher teacherObj = (Teacher)request.getAttribute("teacherObj");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>课程查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#courseListPanel" aria-controls="courseListPanel" role="tab" data-toggle="tab">课程列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Course/course_frontAdd.jsp" style="display:none;">添加课程</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="courseListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>课程编号</td><td>课程名称</td><td>总学时</td><td>课程学分</td><td>上课教室</td><td>上课老师</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<courseList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Course course = courseList.get(i); //获取到课程对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=course.getCourseNo() %></td>
 											<td><%=course.getCourseName() %></td>
 											<td><%=course.getCourseHours() %></td>
 											<td><%=course.getCourseScore() %></td>
 											<td><%=course.getCoursePlace() %></td>
 											<td><%=course.getTeacherObj().getName() %></td>
 											<td>
 												<a href="<%=basePath  %>Course/<%=course.getCourseNo() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="courseEdit('<%=course.getCourseNo() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="courseDelete('<%=course.getCourseNo() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>课程查询</h1>
		</div>
		<form name="courseQueryForm" id="courseQueryForm" action="<%=basePath %>Course/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="courseNo">课程编号:</label>
				<input type="text" id="courseNo" name="courseNo" value="<%=courseNo %>" class="form-control" placeholder="请输入课程编号">
			</div>






			<div class="form-group">
				<label for="courseName">课程名称:</label>
				<input type="text" id="courseName" name="courseName" value="<%=courseName %>" class="form-control" placeholder="请输入课程名称">
			</div>






            <div class="form-group">
            	<label for="teacherObj_teacherNo">上课老师：</label>
                <select id="teacherObj_teacherNo" name="teacherObj.teacherNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Teacher teacherTemp:teacherList) {
	 					String selected = "";
 					if(teacherObj!=null && teacherObj.getTeacherNo()!=null && teacherObj.getTeacherNo().equals(teacherTemp.getTeacherNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=teacherTemp.getTeacherNo() %>" <%=selected %>><%=teacherTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="courseEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;课程信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="courseEditForm" id="courseEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="course_courseNo_edit" class="col-md-3 text-right">课程编号:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="course_courseNo_edit" name="course.courseNo" class="form-control" placeholder="请输入课程编号" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="course_courseName_edit" class="col-md-3 text-right">课程名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="course_courseName_edit" name="course.courseName" class="form-control" placeholder="请输入课程名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="course_courseDesc_edit" class="col-md-3 text-right">课程介绍:</label>
		  	 <div class="col-md-9">
			 	<textarea name="course.courseDesc" id="course_courseDesc_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="course_courseHours_edit" class="col-md-3 text-right">总学时:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="course_courseHours_edit" name="course.courseHours" class="form-control" placeholder="请输入总学时">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="course_courseScore_edit" class="col-md-3 text-right">课程学分:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="course_courseScore_edit" name="course.courseScore" class="form-control" placeholder="请输入课程学分">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="course_coursePlace_edit" class="col-md-3 text-right">上课教室:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="course_coursePlace_edit" name="course.coursePlace" class="form-control" placeholder="请输入上课教室">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="course_teacherObj_teacherNo_edit" class="col-md-3 text-right">上课老师:</label>
		  	 <div class="col-md-9">
			    <select id="course_teacherObj_teacherNo_edit" name="course.teacherObj.teacherNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		</form> 
	    <style>#courseEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxCourseModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var course_courseDesc_edit = UE.getEditor('course_courseDesc_edit'); //课程介绍编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.courseQueryForm.currentPage.value = currentPage;
    document.courseQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.courseQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.courseQueryForm.currentPage.value = pageValue;
    documentcourseQueryForm.submit();
}

/*弹出修改课程界面并初始化数据*/
function courseEdit(courseNo) {
	$.ajax({
		url :  basePath + "Course/" + courseNo + "/update",
		type : "get",
		dataType: "json",
		success : function (course, response, status) {
			if (course) {
				$("#course_courseNo_edit").val(course.courseNo);
				$("#course_courseName_edit").val(course.courseName);
				course_courseDesc_edit.setContent(course.courseDesc, false);
				$("#course_courseHours_edit").val(course.courseHours);
				$("#course_courseScore_edit").val(course.courseScore);
				$("#course_coursePlace_edit").val(course.coursePlace);
				$.ajax({
					url: basePath + "Teacher/listAll",
					type: "get",
					success: function(teachers,response,status) { 
						$("#course_teacherObj_teacherNo_edit").empty();
						var html="";
		        		$(teachers).each(function(i,teacher){
		        			html += "<option value='" + teacher.teacherNo + "'>" + teacher.name + "</option>";
		        		});
		        		$("#course_teacherObj_teacherNo_edit").html(html);
		        		$("#course_teacherObj_teacherNo_edit").val(course.teacherObjPri);
					}
				});
				$('#courseEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除课程信息*/
function courseDelete(courseNo) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Course/deletes",
			data : {
				courseNos : courseNo,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#courseQueryForm").submit();
					//location.href= basePath + "Course/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交课程信息表单给服务器端修改*/
function ajaxCourseModify() {
	$.ajax({
		url :  basePath + "Course/" + $("#course_courseNo_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#courseEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#courseQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
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

