package com.jiabaoer.mapper;


import com.jiabaoer.pojo.BlogType;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

public interface BlogTypeMapper {
    List<BlogType> selectAllBlogType();

    @Insert("insert into blogtype values(#{id},#{btName})")
    int addBlogType(@Param("id") String id,@Param("btName") String btName);

    List<BlogType> selectBlogTypePageInfo(Map<String, Object> map);

    @Select("select count(*) from blogtype")
    long selectBlogTypeCount();

    @Delete("delete from blogtype where bt_id=#{0}")
    int delBlogTypeById(String btId);

    int updateBlogTypeById(@Param("btId") String btId, @Param("btName") String btName);

}