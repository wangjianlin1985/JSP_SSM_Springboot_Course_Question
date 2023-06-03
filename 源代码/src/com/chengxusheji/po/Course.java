package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Course {
    /*课程编号*/
    @NotEmpty(message="课程编号不能为空")
    private String courseNo;
    public String getCourseNo(){
        return courseNo;
    }
    public void setCourseNo(String courseNo){
        this.courseNo = courseNo;
    }

    /*课程名称*/
    @NotEmpty(message="课程名称不能为空")
    private String courseName;
    public String getCourseName() {
        return courseName;
    }
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    /*课程介绍*/
    @NotEmpty(message="课程介绍不能为空")
    private String courseDesc;
    public String getCourseDesc() {
        return courseDesc;
    }
    public void setCourseDesc(String courseDesc) {
        this.courseDesc = courseDesc;
    }

    /*总学时*/
    @NotNull(message="必须输入总学时")
    private Integer courseHours;
    public Integer getCourseHours() {
        return courseHours;
    }
    public void setCourseHours(Integer courseHours) {
        this.courseHours = courseHours;
    }

    /*课程学分*/
    @NotNull(message="必须输入课程学分")
    private Float courseScore;
    public Float getCourseScore() {
        return courseScore;
    }
    public void setCourseScore(Float courseScore) {
        this.courseScore = courseScore;
    }

    /*上课教室*/
    @NotEmpty(message="上课教室不能为空")
    private String coursePlace;
    public String getCoursePlace() {
        return coursePlace;
    }
    public void setCoursePlace(String coursePlace) {
        this.coursePlace = coursePlace;
    }

    /*上课老师*/
    private Teacher teacherObj;
    public Teacher getTeacherObj() {
        return teacherObj;
    }
    public void setTeacherObj(Teacher teacherObj) {
        this.teacherObj = teacherObj;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonCourse=new JSONObject(); 
		jsonCourse.accumulate("courseNo", this.getCourseNo());
		jsonCourse.accumulate("courseName", this.getCourseName());
		jsonCourse.accumulate("courseDesc", this.getCourseDesc());
		jsonCourse.accumulate("courseHours", this.getCourseHours());
		jsonCourse.accumulate("courseScore", this.getCourseScore());
		jsonCourse.accumulate("coursePlace", this.getCoursePlace());
		jsonCourse.accumulate("teacherObj", this.getTeacherObj().getName());
		jsonCourse.accumulate("teacherObjPri", this.getTeacherObj().getTeacherNo());
		return jsonCourse;
    }}