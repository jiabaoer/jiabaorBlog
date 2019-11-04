package com.jiabaoer.pojo;

import java.util.List;

public class Album {
    private String id;

    private String amTitle;

    private String amTime;

    private String amCoverFile;

    private String amProfile;

    private String userId;

    private User user;

    private List<Picture> pictureList;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAmTitle() {
        return amTitle;
    }

    public void setAmTitle(String amTitle) {
        this.amTitle = amTitle == null ? null : amTitle.trim();
    }

    public String getAmTime() {
        return amTime;
    }

    public void setAmTime(String amTime) {
        this.amTime = amTime;
    }

    public String getAmProfile() {
        return amProfile;
    }

    public void setAmProfile(String amProfile) {
        this.amProfile = amProfile == null ? null : amProfile.trim();
    }

    public String getAmCoverFile() {
        return amCoverFile;
    }

    public void setAmCoverFile(String amCoverFile) {
        this.amCoverFile = amCoverFile;
    }

    public List<Picture> getPictureList() {
        return pictureList;
    }

    public void setPictureList(List<Picture> pictureList) {
        this.pictureList = pictureList;
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
}