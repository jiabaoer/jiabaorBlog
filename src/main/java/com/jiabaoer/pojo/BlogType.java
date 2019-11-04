package com.jiabaoer.pojo;

public class BlogType {
    private String btId;

    private String btName;

    public String getBtId() {
        return btId;
    }

    public void setBtId(String btId) {
        this.btId = btId;
    }

    public String getBtName() {
        return btName;
    }

    public void setBtName(String btName) {
        this.btName = btName;
    }

    @Override
    public String toString() {
        return "BlogType{" +
                "btId=" + btId +
                ", btName='" + btName + '\'' +
                '}';
    }
}