package com.jiabaoer.pojo;

public class Leave {
    private String id;
    private String leaveText;
    private String leaveTime;
    private String userId;
    private User user;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getLeaveText() {
        return leaveText;
    }

    public void setLeaveText(String leaveText) {
        this.leaveText = leaveText;
    }

    public String getLeaveTime() {
        return leaveTime;
    }

    public void setLeaveTime(String leaveTime) {
        this.leaveTime = leaveTime;
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

    @Override
    public String toString() {
        return "Leave{" +
                "id=" + id +
                ", leaveText='" + leaveText + '\'' +
                ", leaveTime='" + leaveTime + '\'' +
                ", userId=" + userId +
                ", user=" + user +
                '}';
    }
}
