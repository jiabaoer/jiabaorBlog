package com.jiabaoer.pojo;

import java.io.Serializable;

public class User implements Serializable {
    private String id;

    private String email;

    private String password;

    private String headPictrue;

    private String nickname;

    private String profile;

    private String userType;

    private String roleId;

    private Role role;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getHeadPictrue() {
        return headPictrue;
    }

    public void setHeadPictrue(String headPictrue) {
        this.headPictrue = headPictrue;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getUserType() {
        return userType;
    }

    public void setUserType(String userType) {
        this.userType = userType;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", password='" + password + '\'' +
                ", headPictrue='" + headPictrue + '\'' +
                ", nickname='" + nickname + '\'' +
                ", userType=" + userType +
                ", profile=" + profile +
                ", roleId=" + roleId +
                ", role=" + role +
                '}';
    }
}