package com.jiabaoer.mapper;

import com.jiabaoer.pojo.Album;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

public interface AlbumMapper {

    List<Album> showAllAlbum(Map<String, Object> map);

    @Select("select count(*) from album")
    long selectAlbumCount();

    @Delete("delete from album where id=#{0}")
    int delAlbumById(String albumId);

    @Insert("insert into album values(#{id},#{amTitle},#{amTime},#{amCoverFile},#{amProfile},#{userId})")
    int addAlbum(Album album);

    @Update("update album set am_title=#{amTitle},am_coverFile=#{amCoverFile},am_profile=#{amProfile} where id=#{id}")
    int updateAlbumById(Album album);

    List<Album> selectAllAlbum();

    Album showAlbumAllPictureById(String bId);
}