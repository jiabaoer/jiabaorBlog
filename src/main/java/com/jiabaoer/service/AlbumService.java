package com.jiabaoer.service;

import com.jiabaoer.pojo.Album;
import com.jiabaoer.pojo.PageInfo;

import java.util.List;

public interface AlbumService {
    PageInfo showAllAlbum(int pageSizeInit, int pageNumberInit);

    int delAlbumById(String albumId);

    int addAlbum(Album album);

    int updateAlbumById(Album album);

    List<Album> showAllAlbum();

    Album showAlbumAllPictureById(String bId);
}
