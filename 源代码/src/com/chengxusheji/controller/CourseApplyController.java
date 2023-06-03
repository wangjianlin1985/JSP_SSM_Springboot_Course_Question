package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.CourseApplyService;
import com.chengxusheji.po.CourseApply;
import com.chengxusheji.service.CourseService;
import com.chengxusheji.po.Course;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//CourseApply管理控制层
@Controller
@RequestMapping("/CourseApply")
public class CourseApplyController extends BaseController {

    /*业务层对象*/
    @Resource CourseApplyService courseApplyService;

    @Resource CourseService courseService;
    @Resource UserInfoService userInfoService;
	@InitBinder("courseObj")
	public void initBindercourseObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("courseObj.");
	}
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("courseApply")
	public void initBinderCourseApply(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("courseApply.");
	}
	/*跳转到添加CourseApply视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new CourseApply());
		/*查询所有的Course信息*/
		List<Course> courseList = courseService.queryAllCourse();
		request.setAttribute("courseList", courseList);
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "CourseApply_add";
	}

	/*客户端ajax方式提交添加课程申请信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated CourseApply courseApply, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        courseApplyService.addCourseApply(courseApply);
        message = "课程申请添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*客户端ajax方式提交添加课程申请信息*/
	@RequestMapping(value = "/userAdd", method = RequestMethod.POST)
	public void userAdd(CourseApply courseApply, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
	 
		
		String user_name = (String) session.getAttribute("user_name");
		if(user_name == null) {
			message = "请先登录网站！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
		UserInfo userObj = new UserInfo();
		userObj.setUser_name(user_name);
		
		if(courseApplyService.queryCourseApply(courseApply.getCourseObj(), userObj, "", "", "").size() > 0 ) {
			message = "你已经申请过这门课程了！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
		
		courseApply.setUserObj(userObj);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		courseApply.setApplyTime(sdf.format(new java.util.Date()));
		
		courseApply.setShenHeResult("--");
		courseApply.setShenHeState("待审核");
		courseApply.setShenHeTime("--");
		 
		
        courseApplyService.addCourseApply(courseApply);
        message = "课程申请添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*ajax方式按照查询条件分页查询课程申请信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("courseObj") Course courseObj,@ModelAttribute("userObj") UserInfo userObj,String applyTime,String shenHeState,String shenHeTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (applyTime == null) applyTime = "";
		if (shenHeState == null) shenHeState = "";
		if (shenHeTime == null) shenHeTime = "";
		if(rows != 0)courseApplyService.setRows(rows);
		List<CourseApply> courseApplyList = courseApplyService.queryCourseApply(courseObj, userObj, applyTime, shenHeState, shenHeTime, page);
	    /*计算总的页数和总的记录数*/
	    courseApplyService.queryTotalPageAndRecordNumber(courseObj, userObj, applyTime, shenHeState, shenHeTime);
	    /*获取到总的页码数目*/
	    int totalPage = courseApplyService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = courseApplyService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(CourseApply courseApply:courseApplyList) {
			JSONObject jsonCourseApply = courseApply.getJsonObject();
			jsonArray.put(jsonCourseApply);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}
	
	
	
	/*ajax方式按照查询条件分页查询课程申请信息*/
	@RequestMapping(value = { "/teacherlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void teacherlist(@ModelAttribute("courseObj") Course courseObj,@ModelAttribute("userObj") UserInfo userObj,String applyTime,String shenHeState,String shenHeTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		if (page==null || page == 0) page = 1;
		if (applyTime == null) applyTime = "";
		if (shenHeState == null) shenHeState = "";
		if (shenHeTime == null) shenHeTime = "";
		if(rows != 0)courseApplyService.setRows(rows);
		
		String teacherNo = session.getAttribute("teacherNo").toString();
		
		List<CourseApply> courseApplyList = courseApplyService.teacherQueryCourseApply(teacherNo,courseObj, userObj, applyTime, shenHeState, shenHeTime, page);
	    /*计算总的页数和总的记录数*/
	    courseApplyService.teacherQueryTotalPageAndRecordNumber(teacherNo,courseObj, userObj, applyTime, shenHeState, shenHeTime);
	    /*获取到总的页码数目*/
	    int totalPage = courseApplyService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = courseApplyService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(CourseApply courseApply:courseApplyList) {
			JSONObject jsonCourseApply = courseApply.getJsonObject();
			jsonArray.put(jsonCourseApply);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}
	
	

	/*ajax方式按照查询条件分页查询课程申请信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<CourseApply> courseApplyList = courseApplyService.queryAllCourseApply();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(CourseApply courseApply:courseApplyList) {
			JSONObject jsonCourseApply = new JSONObject();
			jsonCourseApply.accumulate("applyId", courseApply.getApplyId());
			jsonArray.put(jsonCourseApply);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询课程申请信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("courseObj") Course courseObj,@ModelAttribute("userObj") UserInfo userObj,String applyTime,String shenHeState,String shenHeTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (applyTime == null) applyTime = "";
		if (shenHeState == null) shenHeState = "";
		if (shenHeTime == null) shenHeTime = "";
		List<CourseApply> courseApplyList = courseApplyService.queryCourseApply(courseObj, userObj, applyTime, shenHeState, shenHeTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    courseApplyService.queryTotalPageAndRecordNumber(courseObj, userObj, applyTime, shenHeState, shenHeTime);
	    /*获取到总的页码数目*/
	    int totalPage = courseApplyService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = courseApplyService.getRecordNumber();
	    request.setAttribute("courseApplyList",  courseApplyList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("courseObj", courseObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("applyTime", applyTime);
	    request.setAttribute("shenHeState", shenHeState);
	    request.setAttribute("shenHeTime", shenHeTime);
	    List<Course> courseList = courseService.queryAllCourse();
	    request.setAttribute("courseList", courseList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "CourseApply/courseApply_frontquery_result"; 
	}
	
	
	/*前台按照查询条件分页查询课程申请信息*/
	@RequestMapping(value = { "/userFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String userFrontlist(@ModelAttribute("courseObj") Course courseObj,@ModelAttribute("userObj") UserInfo userObj,String applyTime,String shenHeState,String shenHeTime,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (applyTime == null) applyTime = "";
		if (shenHeState == null) shenHeState = "";
		if (shenHeTime == null) shenHeTime = "";
		userObj = new UserInfo();
		userObj.setUser_name(session.getAttribute("user_name").toString());
		
		List<CourseApply> courseApplyList = courseApplyService.queryCourseApply(courseObj, userObj, applyTime, shenHeState, shenHeTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    courseApplyService.queryTotalPageAndRecordNumber(courseObj, userObj, applyTime, shenHeState, shenHeTime);
	    /*获取到总的页码数目*/
	    int totalPage = courseApplyService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = courseApplyService.getRecordNumber();
	    request.setAttribute("courseApplyList",  courseApplyList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("courseObj", courseObj);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("applyTime", applyTime);
	    request.setAttribute("shenHeState", shenHeState);
	    request.setAttribute("shenHeTime", shenHeTime);
	    List<Course> courseList = courseService.queryAllCourse();
	    request.setAttribute("courseList", courseList);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "CourseApply/courseApply_userFrontquery_result"; 
	}
	

     /*前台查询CourseApply信息*/
	@RequestMapping(value="/{applyId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer applyId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键applyId获取CourseApply对象*/
        CourseApply courseApply = courseApplyService.getCourseApply(applyId);

        List<Course> courseList = courseService.queryAllCourse();
        request.setAttribute("courseList", courseList);
        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("courseApply",  courseApply);
        return "CourseApply/courseApply_frontshow";
	}

	/*ajax方式显示课程申请修改jsp视图页*/
	@RequestMapping(value="/{applyId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer applyId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键applyId获取CourseApply对象*/
        CourseApply courseApply = courseApplyService.getCourseApply(applyId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonCourseApply = courseApply.getJsonObject();
		out.println(jsonCourseApply.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新课程申请信息*/
	@RequestMapping(value = "/{applyId}/update", method = RequestMethod.POST)
	public void update(@Validated CourseApply courseApply, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		courseApply.setShenHeTime(sdf.format(new java.util.Date()));
		
		try {
			courseApplyService.updateCourseApply(courseApply);
			message = "课程申请更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "课程申请更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除课程申请信息*/
	@RequestMapping(value="/{applyId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer applyId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  courseApplyService.deleteCourseApply(applyId);
	            request.setAttribute("message", "课程申请删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "课程申请删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条课程申请记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String applyIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = courseApplyService.deleteCourseApplys(applyIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出课程申请信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("courseObj") Course courseObj,@ModelAttribute("userObj") UserInfo userObj,String applyTime,String shenHeState,String shenHeTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(applyTime == null) applyTime = "";
        if(shenHeState == null) shenHeState = "";
        if(shenHeTime == null) shenHeTime = "";
        List<CourseApply> courseApplyList = courseApplyService.queryCourseApply(courseObj,userObj,applyTime,shenHeState,shenHeTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "CourseApply信息记录"; 
        String[] headers = { "申请id","申请课程","申请学生","申请时间","审核状态","审核说明","审核时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<courseApplyList.size();i++) {
        	CourseApply courseApply = courseApplyList.get(i); 
        	dataset.add(new String[]{courseApply.getApplyId() + "",courseApply.getCourseObj().getCourseName(),courseApply.getUserObj().getName(),courseApply.getApplyTime(),courseApply.getShenHeState(),courseApply.getShenHeResult(),courseApply.getShenHeTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"CourseApply.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
