package com.jiabaoer.pojo;

import java.util.List;

public class Blog {
    private String id;

    private String bgTitle;

    private String bgTime;

    private String bgProfile;

    private Long bgPraise;

    private String typeId;

    private String bgContent;

    private String bgCoverFile;

    private String userId;

    private User user;

    private BlogType blogType;

    private List<Comments> commentsList;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getBgTitle() {
        return bgTitle;
    }

    public void setBgTitle(String bgTitle) {
        this.bgTitle = bgTitle == null ? null : bgTitle.trim();
    }

    public String getBgTime() {
        return bgTime;
    }

    public void setBgTime(String bgTime) {
        this.bgTime = bgTime;
    }

    public String getBgProfile() {
        return bgProfile;
    }

    public void setBgProfile(String bgProfile) {
        this.bgProfile = bgProfile == null ? null : bgProfile.trim();
    }

    public Long getBgPraise() {
        return bgPraise;
    }

    public void setBgPraise(Long bgPraise) {
        this.bgPraise = bgPraise;
    }

    public String getTypeId() {
        return typeId;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    public String getBgContent() {
        return bgContent;
    }

    public void setBgContent(String bgContent) {
        this.bgContent = bgContent == null ? null : bgContent.trim();
    }

    public String getBgCoverFile() {
        return bgCoverFile;
    }

    public void setBgCoverFile(String fileStyle) {
        this.bgCoverFile = fileStyle;
    }

    public BlogType getBlogType() {
        return blogType;
    }

    public void setBlogType(BlogType blogType) {
        this.blogType = blogType;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Comments> getCommentsList() {
        return commentsList;
    }

    public void setCommentsList(List<Comments> commentsList) {
        this.commentsList = commentsList;
    }

    @Override
    public String toString() {
        return "Blog{" +
                "id=" + id +
                ", bgTitle='" + bgTitle + '\'' +
                ", bgTime='" + bgTime + '\'' +
                ", bgProfile='" + bgProfile + '\'' +
                ", bgPraise=" + bgPraise +
                ", typeId=" + typeId +
                ", bgContent='" + bgContent + '\'' +
                ", bgCoverFile='" + bgCoverFile + '\'' +
                ", userId=" + userId +
                ", user=" + user +
                ", blogType=" + blogType +
                ", commentsList=" + commentsList +
                '}';
    }
}