package com.jiabaoer.pojo;

public class Picture {
    private String id;

    private String ptUrl;

    private String amId;

    private String updTime;

    private Album album;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPtUrl() {
        return ptUrl;
    }

    public void setPtUrl(String ptUrl) {
        this.ptUrl = ptUrl == null ? null : ptUrl.trim();
    }

    public String getAmId() {
        return amId;
    }

    public void setAmId(String amId) {
        this.amId = amId;
    }

    public Album getAlbum() {
        return album;
    }

    public void setAlbum(Album album) {
        this.album = album;
    }

    public String getUpdTime() {
        return updTime;
    }

    public void setUpdTime(String updTime) {
        this.updTime = updTime;
    }

    @Override
    public String toString() {
        return "Picture{" +
                "id=" + id +
                ", ptUrl='" + ptUrl + '\'' +
                ", amId=" + amId +
                ", updTime=" + updTime +
                ", album=" + album +
                '}';
    }
}