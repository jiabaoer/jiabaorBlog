package com.jiabaoer.mapper;

import com.jiabaoer.pojo.Comments;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface CommentsMapper {

    List<Comments> selectAllComments(Map<String, Object> map);

    @Select("select count(*) from comments")
    long selectCommentsCount();

    int insertCommentsByBlogId(Comments comments);

    List<Comments> selectCommentsByBlogIdAndUser(String id);

    @Delete("delete from comments where com_id=#{0}")
    int delCommentsById(String parseInt);

    int delCommentsByIdList(List<String> delComments_ids);

}