package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.Course;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.CourseApply;

import com.chengxusheji.mapper.CourseApplyMapper;
@Service
public class CourseApplyService {

	@Resource CourseApplyMapper courseApplyMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加课程申请记录*/
    public void addCourseApply(CourseApply courseApply) throws Exception {
    	courseApplyMapper.addCourseApply(courseApply);
    }

    /*按照查询条件分页查询课程申请记录*/
    public ArrayList<CourseApply> queryCourseApply(Course courseObj,UserInfo userObj,String applyTime,String shenHeState,String shenHeTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != courseObj &&  courseObj.getCourseNo() != null  && !courseObj.getCourseNo().equals(""))  where += " and t_courseApply.courseObj='" + courseObj.getCourseNo() + "'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_courseApply.userObj='" + userObj.getUser_name() + "'";
    	if(!applyTime.equals("")) where = where + " and t_courseApply.applyTime like '%" + applyTime + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_courseApply.shenHeState like '%" + shenHeState + "%'";
    	if(!shenHeTime.equals("")) where = where + " and t_courseApply.shenHeTime like '%" + shenHeTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return courseApplyMapper.queryCourseApply(where, startIndex, this.rows);
    }
    
    /*按照查询条件分页查询课程申请记录*/
    public ArrayList<CourseApply> teacherQueryCourseApply(String teacherNo,Course courseObj,UserInfo userObj,String applyTime,String shenHeState,String shenHeTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
     	where += " and t_course.teacherObj='" + teacherNo + "'";
    	if(null != courseObj &&  courseObj.getCourseNo() != null  && !courseObj.getCourseNo().equals(""))  where += " and t_courseApply.courseObj='" + courseObj.getCourseNo() + "'";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_courseApply.userObj='" + userObj.getUser_name() + "'";
    	if(!applyTime.equals("")) where = where + " and t_courseApply.applyTime like '%" + applyTime + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_courseApply.shenHeState like '%" + shenHeState + "%'";
    	if(!shenHeTime.equals("")) where = where + " and t_courseApply.shenHeTime like '%" + shenHeTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return courseApplyMapper.queryCourseApply(where, startIndex, this.rows);
    }
    

    /*按照查询条件查询所有记录*/
    public ArrayList<CourseApply> queryCourseApply(Course courseObj,UserInfo userObj,String applyTime,String shenHeState,String shenHeTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != courseObj &&  courseObj.getCourseNo() != null && !courseObj.getCourseNo().equals(""))  where += " and t_courseApply.courseObj='" + courseObj.getCourseNo() + "'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_courseApply.userObj='" + userObj.getUser_name() + "'";
    	if(!applyTime.equals("")) where = where + " and t_courseApply.applyTime like '%" + applyTime + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_courseApply.shenHeState like '%" + shenHeState + "%'";
    	if(!shenHeTime.equals("")) where = where + " and t_courseApply.shenHeTime like '%" + shenHeTime + "%'";
    	return courseApplyMapper.queryCourseApplyList(where);
    }

    /*查询所有课程申请记录*/
    public ArrayList<CourseApply> queryAllCourseApply()  throws Exception {
        return courseApplyMapper.queryCourseApplyList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(Course courseObj,UserInfo userObj,String applyTime,String shenHeState,String shenHeTime) throws Exception {
     	String where = "where 1=1";
    	if(null != courseObj &&  courseObj.getCourseNo() != null && !courseObj.getCourseNo().equals(""))  where += " and t_courseApply.courseObj='" + courseObj.getCourseNo() + "'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_courseApply.userObj='" + userObj.getUser_name() + "'";
    	if(!applyTime.equals("")) where = where + " and t_courseApply.applyTime like '%" + applyTime + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_courseApply.shenHeState like '%" + shenHeState + "%'";
    	if(!shenHeTime.equals("")) where = where + " and t_courseApply.shenHeTime like '%" + shenHeTime + "%'";
        recordNumber = courseApplyMapper.queryCourseApplyCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }
    
    
    /*当前查询条件下计算总的页数和记录数*/
    public void teacherQueryTotalPageAndRecordNumber(String teacherNo,Course courseObj,UserInfo userObj,String applyTime,String shenHeState,String shenHeTime) throws Exception {
     	String where = "where 1=1";
     	where += " and t_course.teacherObj='" + teacherNo + "'";
    	if(null != courseObj &&  courseObj.getCourseNo() != null && !courseObj.getCourseNo().equals(""))  where += " and t_courseApply.courseObj='" + courseObj.getCourseNo() + "'";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_courseApply.userObj='" + userObj.getUser_name() + "'";
    	if(!applyTime.equals("")) where = where + " and t_courseApply.applyTime like '%" + applyTime + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_courseApply.shenHeState like '%" + shenHeState + "%'";
    	if(!shenHeTime.equals("")) where = where + " and t_courseApply.shenHeTime like '%" + shenHeTime + "%'";
        recordNumber = courseApplyMapper.queryCourseApplyCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }
    
    /*根据主键获取课程申请记录*/
    public CourseApply getCourseApply(int applyId) throws Exception  {
        CourseApply courseApply = courseApplyMapper.getCourseApply(applyId);
        return courseApply;
    }

    /*更新课程申请记录*/
    public void updateCourseApply(CourseApply courseApply) throws Exception {
        courseApplyMapper.updateCourseApply(courseApply);
    }

    /*删除一条课程申请记录*/
    public void deleteCourseApply (int applyId) throws Exception {
        courseApplyMapper.deleteCourseApply(applyId);
    }

    /*删除多条课程申请信息*/
    public int deleteCourseApplys (String applyIds) throws Exception {
    	String _applyIds[] = applyIds.split(",");
    	for(String _applyId: _applyIds) {
    		courseApplyMapper.deleteCourseApply(Integer.parseInt(_applyId));
    	}
    	return _applyIds.length;
    }
}
