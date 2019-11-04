package com.jiabaoer.service;

import com.jiabaoer.pojo.Album;
import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.pojo.Picture;

import java.util.List;

public interface PictureService {
    List<Album> selectAllAlbum();

    int addPictureList(List<Picture> list);

    int addPictureOne(Picture picture);

    PageInfo selectAllPicture(int pageSizeInit, int pageNumberInit);

    int delPictureByIdList(List<String> delPicture_ids);

    int delPictureById(String id);

}
