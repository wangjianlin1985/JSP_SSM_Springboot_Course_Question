<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.CourseApply" %>
<%@ page import="com.chengxusheji.po.Course" %>
<%@ page import="com.chengxusheji.po.UserInfo" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<CourseApply> courseApplyList = (List<CourseApply>)request.getAttribute("courseApplyList");
    //获取所有的courseObj信息
    List<Course> courseList = (List<Course>)request.getAttribute("courseList");
    //获取所有的userObj信息
    List<UserInfo> userInfoList = (List<UserInfo>)request.getAttribute("userInfoList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    Course courseObj = (Course)request.getAttribute("courseObj");
    UserInfo userObj = (UserInfo)request.getAttribute("userObj");
    String applyTime = (String)request.getAttribute("applyTime"); //申请时间查询关键字
    String shenHeState = (String)request.getAttribute("shenHeState"); //审核状态查询关键字
    String shenHeTime = (String)request.getAttribute("shenHeTime"); //审核时间查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>课程申请查询</title>
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
			    	<li role="presentation" class="active"><a href="#courseApplyListPanel" aria-controls="courseApplyListPanel" role="tab" data-toggle="tab">课程申请列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>CourseApply/courseApply_frontAdd.jsp" style="display:none;">添加课程申请</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="courseApplyListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>申请id</td><td>申请课程</td><td>申请学生</td><td>申请时间</td><td>审核状态</td><td>审核说明</td><td>审核时间</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<courseApplyList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		CourseApply courseApply = courseApplyList.get(i); //获取到课程申请对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=courseApply.getApplyId() %></td>
 											<td><%=courseApply.getCourseObj().getCourseName() %></td>
 											<td><%=courseApply.getUserObj().getName() %></td>
 											<td><%=courseApply.getApplyTime() %></td>
 											<td><%=courseApply.getShenHeState() %></td>
 											<td><%=courseApply.getShenHeResult() %></td>
 											<td><%=courseApply.getShenHeTime() %></td>
 											<td>
 												<a href="<%=basePath  %>CourseApply/<%=courseApply.getApplyId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="courseApplyEdit('<%=courseApply.getApplyId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="courseApplyDelete('<%=courseApply.getApplyId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>课程申请查询</h1>
		</div>
		<form name="courseApplyQueryForm" id="courseApplyQueryForm" action="<%=basePath %>CourseApply/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="courseObj_courseNo">申请课程：</label>
                <select id="courseObj_courseNo" name="courseObj.courseNo" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Course courseTemp:courseList) {
	 					String selected = "";
 					if(courseObj!=null && courseObj.getCourseNo()!=null && courseObj.getCourseNo().equals(courseTemp.getCourseNo()))
 						selected = "selected";
	 				%>
 				 <option value="<%=courseTemp.getCourseNo() %>" <%=selected %>><%=courseTemp.getCourseName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
            <div class="form-group">
            	<label for="userObj_user_name">申请学生：</label>
                <select id="userObj_user_name" name="userObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(UserInfo userInfoTemp:userInfoList) {
	 					String selected = "";
 					if(userObj!=null && userObj.getUser_name()!=null && userObj.getUser_name().equals(userInfoTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=userInfoTemp.getUser_name() %>" <%=selected %>><%=userInfoTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="applyTime">申请时间:</label>
				<input type="text" id="applyTime" name="applyTime" class="form-control"  placeholder="请选择申请时间" value="<%=applyTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="shenHeState">审核状态:</label>
				<input type="text" id="shenHeState" name="shenHeState" value="<%=shenHeState %>" class="form-control" placeholder="请输入审核状态">
			</div>






			<div class="form-group">
				<label for="shenHeTime">审核时间:</label>
				<input type="text" id="shenHeTime" name="shenHeTime" value="<%=shenHeTime %>" class="form-control" placeholder="请输入审核时间">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="courseApplyEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;课程申请信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="courseApplyEditForm" id="courseApplyEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="courseApply_applyId_edit" class="col-md-3 text-right">申请id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="courseApply_applyId_edit" name="courseApply.applyId" class="form-control" placeholder="请输入申请id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="courseApply_courseObj_courseNo_edit" class="col-md-3 text-right">申请课程:</label>
		  	 <div class="col-md-9">
			    <select id="courseApply_courseObj_courseNo_edit" name="courseApply.courseObj.courseNo" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="courseApply_userObj_user_name_edit" class="col-md-3 text-right">申请学生:</label>
		  	 <div class="col-md-9">
			    <select id="courseApply_userObj_user_name_edit" name="courseApply.userObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="courseApply_applyTime_edit" class="col-md-3 text-right">申请时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date courseApply_applyTime_edit col-md-12" data-link-field="courseApply_applyTime_edit">
                    <input class="form-control" id="courseApply_applyTime_edit" name="courseApply.applyTime" size="16" type="text" value="" placeholder="请选择申请时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="courseApply_shenHeState_edit" class="col-md-3 text-right">审核状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="courseApply_shenHeState_edit" name="courseApply.shenHeState" class="form-control" placeholder="请输入审核状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="courseApply_shenHeResult_edit" class="col-md-3 text-right">审核说明:</label>
		  	 <div class="col-md-9">
			    <textarea id="courseApply_shenHeResult_edit" name="courseApply.shenHeResult" rows="8" class="form-control" placeholder="请输入审核说明"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="courseApply_shenHeTime_edit" class="col-md-3 text-right">审核时间:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="courseApply_shenHeTime_edit" name="courseApply.shenHeTime" class="form-control" placeholder="请输入审核时间">
			 </div>
		  </div>
		</form> 
	    <style>#courseApplyEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxCourseApplyModify();">提交</button>
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
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.courseApplyQueryForm.currentPage.value = currentPage;
    document.courseApplyQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.courseApplyQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.courseApplyQueryForm.currentPage.value = pageValue;
    documentcourseApplyQueryForm.submit();
}

/*弹出修改课程申请界面并初始化数据*/
function courseApplyEdit(applyId) {
	$.ajax({
		url :  basePath + "CourseApply/" + applyId + "/update",
		type : "get",
		dataType: "json",
		success : function (courseApply, response, status) {
			if (courseApply) {
				$("#courseApply_applyId_edit").val(courseApply.applyId);
				$.ajax({
					url: basePath + "Course/listAll",
					type: "get",
					success: function(courses,response,status) { 
						$("#courseApply_courseObj_courseNo_edit").empty();
						var html="";
		        		$(courses).each(function(i,course){
		        			html += "<option value='" + course.courseNo + "'>" + course.courseName + "</option>";
		        		});
		        		$("#courseApply_courseObj_courseNo_edit").html(html);
		        		$("#courseApply_courseObj_courseNo_edit").val(courseApply.courseObjPri);
					}
				});
				$.ajax({
					url: basePath + "UserInfo/listAll",
					type: "get",
					success: function(userInfos,response,status) { 
						$("#courseApply_userObj_user_name_edit").empty();
						var html="";
		        		$(userInfos).each(function(i,userInfo){
		        			html += "<option value='" + userInfo.user_name + "'>" + userInfo.name + "</option>";
		        		});
		        		$("#courseApply_userObj_user_name_edit").html(html);
		        		$("#courseApply_userObj_user_name_edit").val(courseApply.userObjPri);
					}
				});
				$("#courseApply_applyTime_edit").val(courseApply.applyTime);
				$("#courseApply_shenHeState_edit").val(courseApply.shenHeState);
				$("#courseApply_shenHeResult_edit").val(courseApply.shenHeResult);
				$("#courseApply_shenHeTime_edit").val(courseApply.shenHeTime);
				$('#courseApplyEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除课程申请信息*/
function courseApplyDelete(applyId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "CourseApply/deletes",
			data : {
				applyIds : applyId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#courseApplyQueryForm").submit();
					//location.href= basePath + "CourseApply/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交课程申请信息表单给服务器端修改*/
function ajaxCourseApplyModify() {
	$.ajax({
		url :  basePath + "CourseApply/" + $("#courseApply_applyId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#courseApplyEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#courseApplyQueryForm").submit();
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

    /*申请时间组件*/
    $('.courseApply_applyTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

