package com.jiabaoer.pojo;

public class Comments {
    private String comId;

    private String conId;

    private String comTime;

    private String comText;

    private String userId;

    private Blog blog;

    private User user;

    public String getComId() {
        return comId;
    }

    public void setComId(String comId) {
        this.comId = comId;
    }

    public String getConId() {
        return conId;
    }

    public void setConId(String conId) {
        this.conId = conId;
    }

    public String getComTime() {
        return comTime;
    }

    public void setComTime(String comTime) {
        this.comTime = comTime;
    }

    public String getComText() {
        return comText;
    }

    public void setComText(String comText) {
        this.comText = comText == null ? null : comText.trim();
    }

    public Blog getBlog() {
        return blog;
    }

    public void setBlog(Blog blog) {
        this.blog = blog;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "Comments{" +
                "comId=" + comId +
                ", conId=" + conId +
                ", comTime=" + comTime +
                ", comText='" + comText +
                ", comText='" + userId +
                ", blog=" + blog +
                ", user=" + user +
                '}';
    }
}