package com.jiabaoer.service.impl;

import com.jiabaoer.mapper.AlbumMapper;
import com.jiabaoer.mapper.UserMapper;
import com.jiabaoer.pojo.Album;
import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.service.AlbumService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AlbumServiceImpl implements AlbumService {

    @Autowired
    private AlbumMapper albumMapper;

    @Autowired
    private UserMapper userMapper;

    public PageInfo showAllAlbum(int pageSizeInit, int pageNumberInit){
        PageInfo pi = new PageInfo();
        pi.setPageSize(pageSizeInit);
        pi.setPageNumber(pageNumberInit);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("pageStart", pageSizeInit * (pageNumberInit - 1));
        map.put("pageSize", pageSizeInit);
        pi.setList(albumMapper.showAllAlbum(map));
        // 总条数
        long count = albumMapper.selectAlbumCount();
        pi.setTotal(count % pageSizeInit == 0 ? count / pageSizeInit : count / pageSizeInit + 1);
        return pi;
    }

    public int delAlbumById(String albumId) {
        return albumMapper.delAlbumById(albumId);
    }

    public int addAlbum(Album album) {
        return albumMapper.addAlbum(album);
    }

    public int updateAlbumById(Album album) {
        return albumMapper.updateAlbumById(album);
    }

    public List<Album> showAllAlbum() {
        return albumMapper.selectAllAlbum();
    }

    public Album showAlbumAllPictureById(String bId) {
        Album album = albumMapper.showAlbumAllPictureById(bId);
        album.setUser(userMapper.selUserInfo(album.getUserId()));
        return album;
    }
}
