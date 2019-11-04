package com.jiabaoer.controller;

import com.jiabaoer.pojo.Blog;
import com.jiabaoer.pojo.BlogType;
import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.pojo.User;
import com.jiabaoer.service.BlogService;
import com.jiabaoer.service.BlogTypeService;
import com.jiabaoer.service.UserService;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.UUID;

/**
 * 博客类别管理
 */
@Controller
public class BlogTypeController {

    @Resource
    private BlogTypeService blogTypeServiceImpl;

    @Resource
    private BlogService blogServiceImpl;

    @Resource
    private UserService userServiceImpl;

    /**
     * 查询所有的博客分类
     *
     * @return
     */
    @RequestMapping(value = "/admin/showAllBlogType/{blog}")
    @ResponseBody
    public ModelAndView showAllBlogType(@PathVariable("blog") String blog, HttpServletRequest request) {
        ModelAndView ma = new ModelAndView();
        if ("bg".equals(blog)) {
            List<BlogType> blogtypeList = blogTypeServiceImpl.showAllBlogType();
            ma.setViewName("/admin/writeBlog");
            ma.addObject("blogtypeList", blogtypeList);
        } else {
            int pageSize = Integer.parseInt(request.getParameter("pageSize"));
            int pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
            int pageSizeInit = 6;
            if (pageSize > 0) {
                pageSizeInit = pageSize;
            }
            int pageNumberInit = 1;
            if (pageNumber > 1) {
                pageNumberInit = pageNumber;
            }
            PageInfo pageInfo = blogTypeServiceImpl.selectBlogTypePageInfo(pageSizeInit, pageNumberInit);
            ma.setViewName("admin/blogTypeManage");
            ma.addObject("pageInfo", pageInfo);
        }
        return ma;
    }

    /**
     * 添加博客类别
     *
     * @param btName
     * @return
     */
    @RequestMapping("admin/addBlogType/{btName}")
    @ResponseBody
    public String addBlogType(@PathVariable("btName") String btName) {
        boolean bl = blogTypeServiceImpl.addBlogType(UUID.randomUUID().toString().replace("-","").substring(0,10),btName);
        String info;
        if (bl) {
            info = "添加成功";
        } else {
            info = "添加失败";
        }
        return info;
    }

    /**
     * 更新博客类别
     *
     * @param btId
     * @param btName
     * @return
     */
    @RequestMapping("admin/updateBlogTypeById")
    @ResponseBody
    public String updateBlogTypeById(String btId, String btName) {
        int i = blogTypeServiceImpl.updateBlogTypeById(btId, btName);
        if (i > 0) {
            return "修改成功";
        } else {
            return "修改失败";
        }
    }


    /**
     * 更具id删除博客类别
     *
     * @param btId
     * @return
     */
    @RequestMapping("admin/delBlogTypeById/{btId}")
    @ResponseBody
    public String delBlogTypeById(@PathVariable("btId") String btId) {
        int i = blogTypeServiceImpl.delBlogTypeById(btId);
        if (i > 0) {
            return "删除成功";
        } else {
            return "删除失败";
        }
    }

    /**
     * 根据类别id查询所有博客文章
     *
     * @param btId
     * @return
     */
    @RequestMapping("selelctByIdBlog/{btId}")
    public ModelAndView selelctByIdBlog(@PathVariable("btId") String btId) {
        List<Blog> blogs = blogServiceImpl.selelctByIdBlog(btId);
        //查询所有的分类
        List<BlogType> blogTypeList = blogTypeServiceImpl.showAllBlogType();
        User admin = userServiceImpl.selUserInfo("jiabaoer");
        ModelAndView mdv = new ModelAndView("whisper");
        JSONArray blogList = JSONArray.fromObject(blogs);
        mdv.addObject("blogs",blogList.toString());
        mdv.addObject("blogTypeList",blogTypeList);
        mdv.addObject("admin",admin);
        return mdv;
    }

}

