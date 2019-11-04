package com.jiabaoer.service;

import com.jiabaoer.pojo.Blog;
import com.jiabaoer.pojo.PageInfo;

import java.util.List;

public interface BlogService {

    int insertBlog(Blog blog);

    PageInfo selectBlogList(int pageSizeInit, int pageNumberInit);

    int delBlogById(String id);

    int delBlogByIdList(List<String> delBlog_ids);

    Blog selectByIdBlogAndTypeShow(String id);

    boolean updateBlog(Blog blog);

    List<Blog> selectBlogByThree();

    List<Blog> selelctByIdBlog(String btId);

    void updateBlogPraise(Blog blog);

    List<Blog> selectAllBlog();
}
