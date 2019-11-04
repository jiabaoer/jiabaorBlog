package com.jiabaoer.mapper;


import com.jiabaoer.pojo.Picture;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface PictureMapper {

    int addPictureList(List<Picture> list);

    @Insert("insert into picture values(#{id},#{ptUrl},#{updTime},#{amId})")
    int addPictureOne(Picture picture);

    List<Picture> selectAllPicture(Map<String, Object> map);

    @Select("select count(*) from picture")
    long selectAllPictureCount();

    @Delete("delete from picture where pId=#{0}")
    int delPictureById(String id);

    int delPictureByIdList(List<String> delPicture_ids);

    List<Picture> selectPictureByThree();

}