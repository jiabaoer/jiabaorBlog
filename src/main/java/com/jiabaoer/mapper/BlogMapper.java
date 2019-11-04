package com.jiabaoer.mapper;

import com.jiabaoer.pojo.Blog;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface BlogMapper {

    int insertBlog(Blog blog);

    List<Blog> selectBlogPageList(Map<String, Object> map);

    @Select("select count(*) from blog")
    long selectBlogCount();

    @Delete("delete blog,comments from blog LEFT JOIN comments on blog.id=comments.con_id where blog.id=#{id}")
    int delBlogById(String id);

    int delBlogByIdList(List<String> delBlog_ids);

    Blog selectByIdBlogAndTypeShow(String id);

    int updateBlog(Blog blog);

    List<Blog> selectBlogByThree();

    List<Blog> selelctByIdBlog(String btId);

    void updateBlogPraise(Blog blog);

    List<Blog> selectAllBlog();
}