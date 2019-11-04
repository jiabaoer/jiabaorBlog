package com.jiabaoer.service.impl;

import com.jiabaoer.mapper.AlbumMapper;
import com.jiabaoer.mapper.PictureMapper;
import com.jiabaoer.pojo.Album;
import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.pojo.Picture;
import com.jiabaoer.service.PictureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PictureServiceImpl implements PictureService {

    @Autowired
    private AlbumMapper albumMapper;

    @Autowired
    private PictureMapper pictureMapper;

    public List<Album> selectAllAlbum() {
        return albumMapper.selectAllAlbum();
    }

    public int addPictureList(List<Picture> list) {
        return pictureMapper.addPictureList(list);
    }

    public int addPictureOne(Picture picture) {
        return pictureMapper.addPictureOne(picture);
    }

    public PageInfo selectAllPicture(int pageSizeInit, int pageNumberInit) {
        PageInfo pi = new PageInfo();
        pi.setPageSize(pageSizeInit);
        pi.setPageNumber(pageNumberInit);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("pageStart", pageSizeInit * (pageNumberInit - 1));
        map.put("pageSize", pageSizeInit);
        pi.setList(pictureMapper.selectAllPicture(map));
        // 总条数
        long count = pictureMapper.selectAllPictureCount();
        pi.setTotal(count % pageSizeInit == 0 ? count / pageSizeInit : count / pageSizeInit + 1);
        return pi;
    }

    public int delPictureByIdList(List<String> delPicture_ids) {
        return pictureMapper.delPictureByIdList(delPicture_ids);
    }

    public int delPictureById(String id) {
        return pictureMapper.delPictureById(id);
    }

}
