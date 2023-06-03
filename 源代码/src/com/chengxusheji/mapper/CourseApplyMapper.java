package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.CourseApply;

public interface CourseApplyMapper {
	/*添加课程申请信息*/
	public void addCourseApply(CourseApply courseApply) throws Exception;

	/*按照查询条件分页查询课程申请记录*/
	public ArrayList<CourseApply> queryCourseApply(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有课程申请记录*/
	public ArrayList<CourseApply> queryCourseApplyList(@Param("where") String where) throws Exception;

	/*按照查询条件的课程申请记录数*/
	public int queryCourseApplyCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条课程申请记录*/
	public CourseApply getCourseApply(int applyId) throws Exception;

	/*更新课程申请记录*/
	public void updateCourseApply(CourseApply courseApply) throws Exception;

	/*删除课程申请记录*/
	public void deleteCourseApply(int applyId) throws Exception;

}
