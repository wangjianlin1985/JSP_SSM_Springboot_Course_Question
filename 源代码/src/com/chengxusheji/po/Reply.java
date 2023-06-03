package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Reply {
    /*回答id*/
    private Integer replyId;
    public Integer getReplyId(){
        return replyId;
    }
    public void setReplyId(Integer replyId){
        this.replyId = replyId;
    }

    /*被回问题*/
    private PostInfo postInfoObj;
    public PostInfo getPostInfoObj() {
        return postInfoObj;
    }
    public void setPostInfoObj(PostInfo postInfoObj) {
        this.postInfoObj = postInfoObj;
    }

    /*回答内容*/
    @NotEmpty(message="回答内容不能为空")
    private String content;
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }

    /*回答人*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*回答时间*/
    @NotEmpty(message="回答时间不能为空")
    private String replyTime;
    public String getReplyTime() {
        return replyTime;
    }
    public void setReplyTime(String replyTime) {
        this.replyTime = replyTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonReply=new JSONObject(); 
		jsonReply.accumulate("replyId", this.getReplyId());
		jsonReply.accumulate("postInfoObj", this.getPostInfoObj().getTitle());
		jsonReply.accumulate("postInfoObjPri", this.getPostInfoObj().getPostInfoId());
		jsonReply.accumulate("content", this.getContent());
		jsonReply.accumulate("userObj", this.getUserObj().getName());
		jsonReply.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonReply.accumulate("replyTime", this.getReplyTime().length()>19?this.getReplyTime().substring(0,19):this.getReplyTime());
		return jsonReply;
    }}