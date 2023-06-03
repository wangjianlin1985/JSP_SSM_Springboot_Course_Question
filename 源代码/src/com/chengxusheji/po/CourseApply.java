package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class CourseApply {
    /*申请id*/
    private Integer applyId;
    public Integer getApplyId(){
        return applyId;
    }
    public void setApplyId(Integer applyId){
        this.applyId = applyId;
    }

    /*申请课程*/
    private Course courseObj;
    public Course getCourseObj() {
        return courseObj;
    }
    public void setCourseObj(Course courseObj) {
        this.courseObj = courseObj;
    }

    /*申请学生*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*申请时间*/
    @NotEmpty(message="申请时间不能为空")
    private String applyTime;
    public String getApplyTime() {
        return applyTime;
    }
    public void setApplyTime(String applyTime) {
        this.applyTime = applyTime;
    }

    /*审核状态*/
    @NotEmpty(message="审核状态不能为空")
    private String shenHeState;
    public String getShenHeState() {
        return shenHeState;
    }
    public void setShenHeState(String shenHeState) {
        this.shenHeState = shenHeState;
    }

    /*审核说明*/
    @NotEmpty(message="审核说明不能为空")
    private String shenHeResult;
    public String getShenHeResult() {
        return shenHeResult;
    }
    public void setShenHeResult(String shenHeResult) {
        this.shenHeResult = shenHeResult;
    }

    /*审核时间*/
    @NotEmpty(message="审核时间不能为空")
    private String shenHeTime;
    public String getShenHeTime() {
        return shenHeTime;
    }
    public void setShenHeTime(String shenHeTime) {
        this.shenHeTime = shenHeTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonCourseApply=new JSONObject(); 
		jsonCourseApply.accumulate("applyId", this.getApplyId());
		jsonCourseApply.accumulate("courseObj", this.getCourseObj().getCourseName());
		jsonCourseApply.accumulate("courseObjPri", this.getCourseObj().getCourseNo());
		jsonCourseApply.accumulate("userObj", this.getUserObj().getName());
		jsonCourseApply.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonCourseApply.accumulate("applyTime", this.getApplyTime().length()>19?this.getApplyTime().substring(0,19):this.getApplyTime());
		jsonCourseApply.accumulate("shenHeState", this.getShenHeState());
		jsonCourseApply.accumulate("shenHeResult", this.getShenHeResult());
		jsonCourseApply.accumulate("shenHeTime", this.getShenHeTime());
		return jsonCourseApply;
    }}