package com.jiabaoer.service.impl;

import com.jiabaoer.mapper.BlogMapper;
import com.jiabaoer.mapper.CommentsMapper;
import com.jiabaoer.pojo.Blog;
import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.service.BlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BlogServiceImpl implements BlogService {

    @Autowired
    private BlogMapper blogMapper;

    @Autowired
    private CommentsMapper commentsMapper;

    /**
     * 插入博客文章
     *
     * @param blog
     * @return
     */
    public int insertBlog(Blog blog) {
        return blogMapper.insertBlog(blog);
    }

    /**
     * 博客管理分页显示
     *
     * @param pageSizeInit   每页显示个数
     * @param pageNumberInit 当前第几页
     * @return
     */
    public PageInfo selectBlogList(int pageSizeInit, int pageNumberInit) {
        PageInfo pi = new PageInfo();
        pi.setPageSize(pageSizeInit);
        pi.setPageNumber(pageNumberInit);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("pageStart", pageSizeInit * (pageNumberInit - 1));
        map.put("pageSize", pageSizeInit);
        pi.setList(blogMapper.selectBlogPageList(map));
        // 总条数
        long count = blogMapper.selectBlogCount();
        pi.setTotal(count % pageSizeInit == 0 ? count / pageSizeInit : count / pageSizeInit + 1);
        return pi;
    }

    /**
     * 根据id单个删除博客文章
     *
     * @param id 博客id编号
     * @return
     */
    public int delBlogById(String id) {
        return blogMapper.delBlogById(id);
    }

    /**
     * 根据多个id删除博客文章
     *
     * @param delBlog_ids 多个id
     * @return
     */
    public int delBlogByIdList(List<String> delBlog_ids) {
        return blogMapper.delBlogByIdList(delBlog_ids);
    }

    /**
     * 将数据回显
     *
     * @param id
     * @return
     */
    public Blog selectByIdBlogAndTypeShow(String id) {
        Blog blog = blogMapper.selectByIdBlogAndTypeShow(id);
        blog.setCommentsList(commentsMapper.selectCommentsByBlogIdAndUser(blog.getId()));
        return blog;
    }

    /**
     * 修改博客文章
     *
     * @param blog 博客
     * @return
     */
    public boolean updateBlog(Blog blog) {
        int i = blogMapper.updateBlog(blog);
        if (i > 0)
            return true;
        else
            return false;
    }

    public List<Blog> selectBlogByThree() {
        return blogMapper.selectBlogByThree();
    }

    public List<Blog> selelctByIdBlog(String btId) {
        return blogMapper.selelctByIdBlog(btId);
    }

    @Override
    public void updateBlogPraise(Blog blog) {
        blogMapper.updateBlogPraise(blog);
    }

    /**
     * 查询所有的文章
     *
     * @return
     */
    @Override
    public List<Blog> selectAllBlog() {
        return blogMapper.selectAllBlog();
    }
}
