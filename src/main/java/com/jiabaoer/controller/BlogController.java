package com.jiabaoer.controller;

import com.jiabaoer.pojo.*;
import com.jiabaoer.service.*;
import net.sf.json.JSONArray;
import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.annotations.Param;
import org.apache.shiro.SecurityUtils;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class BlogController {

    @Resource
    private BlogService blogServiceImpl;

    @Resource
    private BlogTypeService blogTypeServiceImpl;

    @Resource
    private AlbumService albumServiceImpl;

    @Resource
    private UserService userServiceImpl;

    @Resource
    private CarouselService carouselServiceImpl;

    @Resource
    private FriendsService friendsServiceImpl;

    /**
     * 文章封面图片上传
     *
     * @param request
     * @param file
     * @return
     * @throws IOException
     */
    @RequestMapping("/admin/uploadBlogCover")
    @ResponseBody
    public String uploadBlogCover(HttpServletRequest request, @Param("file") MultipartFile file) throws IOException {
        String name = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 10);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String res = sdf.format(new Date());
        //设置图片上传路径
        String url = request.getServletContext().getRealPath("blogCover");
        //设置新的文件名称
        String newFileName = res + name;
        //获取图片的扩展名
        String ext = FilenameUtils.getExtension(file.getOriginalFilename());
        file.transferTo(new File(url + "/" + newFileName + "." + ext));
        //完整的url
        String fileUrl = "/blogCover/" + newFileName + "." + ext;
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> map1 = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "上传成功");
        map.put("data", map1);
        map1.put("src", fileUrl);
        map1.put("title", newFileName);
        String result = new JSONObject(map).toString();
        return result;
    }

    /**
     * 博客内容图片上传
     *
     * @param request
     * @param file
     * @return
     * @throws IOException
     */
    @RequestMapping("/admin/uploadFile")
    @ResponseBody
    public String uploadFile(HttpServletRequest request, @Param("file") MultipartFile file) throws IOException {
        String name = UUID.randomUUID().toString().replaceAll("-", "").substring(0, 10);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String res = sdf.format(new Date());
        //设置图片上传路径
        String url = request.getServletContext().getRealPath("blogImage");
        //设置新的文件名称
        String newFileName = res + name;
        //获取图片的扩展名
        String ext = FilenameUtils.getExtension(file.getOriginalFilename());
        file.transferTo(new File(url + "/" + newFileName + "." + ext));
        //完整的url
        String fileUrl = "/blogImage/" + newFileName + "." + ext;
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> map1 = new HashMap<String, Object>();
        map.put("code", 0);
        map.put("msg", "上传成功");
        map.put("data", map1);
        map1.put("src", fileUrl);
        map1.put("title", newFileName);
        String result = new JSONObject(map).toString();
        return result;
    }

    /**
     * 添加博客文章
     *
     * @param blog 博客
     * @return
     */
    @RequestMapping(value = "/admin/addBlog", method = RequestMethod.POST)
    @ResponseBody
    public String addBlog(Blog blog) {
        String id = (String) SecurityUtils.getSubject().getSession().getAttribute("userId");
        //发表的时间
        SimpleDateFormat sd = new SimpleDateFormat("yyyy年MM月dd日");
        String date = sd.format(new Date());
        blog.setId(UUID.randomUUID().toString().replace("-", "").substring(0, 10));
        blog.setBgTime(date);
        blog.setUserId(id);
        int i = blogServiceImpl.insertBlog(blog);
        if (i > 0) {
            return "发布成功";
        } else {
            return "发布失败";
        }
    }

    /**
     * 显示所有的博客文章
     *
     * @param pageSize   每页显示个数
     * @param pageNumber 当前第几页
     * @return
     */
    @RequestMapping("/admin/selectBlogList")
    public ModelAndView selectBlogList(@RequestParam(defaultValue = "0") int pageSize, @RequestParam(defaultValue = "0") int pageNumber) {
        int pageSizeInit = 5;
        if (pageSize > 0) {
            pageSizeInit = pageSize;
        }
        int pageNumberInit = 1;
        if (pageNumber > 1) {
            pageNumberInit = pageNumber;
        }
        PageInfo pageInfo = blogServiceImpl.selectBlogList(pageSizeInit, pageNumberInit);
        ModelAndView mdv = new ModelAndView();
        mdv.setViewName("admin/blogManage");
        mdv.addObject("pageInfo", pageInfo);
        return mdv;
    }

    /**
     * 博客文章删除
     * 单个删除：1
     * 批量删除：1-2-3
     *
     * @param ids 博客文章id
     * @return
     */
    @RequestMapping("/admin/delBlog_ids/{ids}")
    @ResponseBody
    public String delBlog_ids(@PathVariable("ids") String ids) {
        int id = 0;
        if (ids.contains("-")) {
            //批量删除
            List<String> delBlog_ids = new ArrayList<String>();
            String[] str_ids = ids.split("-");
            //组装id集合
            for (String str_id : str_ids) {
                delBlog_ids.add(str_id);
            }
            id = blogServiceImpl.delBlogByIdList(delBlog_ids);
        } else {
            //单个删除
            id = blogServiceImpl.delBlogById(ids);
        }
        if (id > 0) {
            return "删除成功";
        } else {
            return "删除失败";
        }
    }

    /**
     * 将数据回显
     *
     * @param id
     * @return
     */
    @RequestMapping("/admin/selectByIdBlogAndTypeShow/{id}")
    public ModelAndView selectByIdBlogAndTypeShow(@PathVariable("id") String id) {
        //根据id查询博客文章及类别
        Blog blog = blogServiceImpl.selectByIdBlogAndTypeShow(id);
        //查询所有分类
        List<BlogType> blogtypeList = blogTypeServiceImpl.showAllBlogType();
        ModelAndView mdv = new ModelAndView("admin/updateBlogInfo");
        mdv.addObject("blog", blog);
        mdv.addObject("blogtypeList", blogtypeList);
        return mdv;
    }

    /**
     * 修改博客文章
     *
     * @param blog 博客
     * @return
     */
    @RequestMapping("/admin/updateBlog")
    @ResponseBody
    public Map<String, String> updateBlog(Blog blog) {
        boolean bl = blogServiceImpl.updateBlog(blog);
        Map<String, String> map = new HashMap<String, String>();
        if (bl) {
            map.put("info", "修改成功");
        } else {
            map.put("info", "修改失败");
        }
        return map;
    }


    /**
     * 查询分类及图片及文章
     *
     * @return
     */
    @RequestMapping("/")
    public ModelAndView indexShow() {
        //查询轮播显示
        List<Carousel> carouselList = carouselServiceImpl.selectCarousel();
        //查询最新的文章进行主页显示
        List<Blog> blogs = blogServiceImpl.selectBlogByThree();
        User admin = userServiceImpl.selUserInfo("jiabaoer");
        ModelAndView mdv = new ModelAndView("index");
        mdv.addObject("carouselList", carouselList);
        mdv.addObject("blogs", blogs);
        mdv.addObject("admin", admin);
        return mdv;
    }

    /**
     * 根据id查询单个博客文章及评论及分类
     *
     * @param id
     * @return
     */
    @RequestMapping("/selectBlogById/{id}")
    public ModelAndView selectBlogById(@PathVariable("id") String id) {
        Blog blog = blogServiceImpl.selectByIdBlogAndTypeShow(id);
        //博客点击次数加1
        blog.setBgPraise(blog.getBgPraise() + 1);
        blogServiceImpl.updateBlogPraise(blog);
        Blog newBlog = blogServiceImpl.selectByIdBlogAndTypeShow(id);
        User user = userServiceImpl.selUserInfo(newBlog.getUserId());
        User admin = userServiceImpl.selUserInfo("jiabaoer");
        //查询所有的分类
        List<BlogType> blogTypeList = blogTypeServiceImpl.showAllBlogType();
        JSONArray jsonArray = JSONArray.fromObject(newBlog.getCommentsList());
        ModelAndView mdv = new ModelAndView("blogInfo");
        mdv.addObject("newBlog", newBlog);
        mdv.addObject("blogTypeList", blogTypeList);
        mdv.addObject("user", user);
        mdv.addObject("comments", jsonArray.toString());
        mdv.addObject("admin", admin);
        return mdv;
    }

    /**
     * 查询分类及文章
     *
     * @return
     */
    @RequestMapping("/blogs")
    public ModelAndView showAllBlogContent() {
        //查询所有的分类
        List<BlogType> blogTypeList = blogTypeServiceImpl.showAllBlogType();
        //查询所有文章
        List<Blog> blogs = blogServiceImpl.selectAllBlog();
        User admin = userServiceImpl.selUserInfo("jiabaoer");
        ModelAndView mdv = new ModelAndView("whisper");
        JSONArray blogList = JSONArray.fromObject(blogs);
        mdv.addObject("blogTypeList", blogTypeList);
        mdv.addObject("blogs", blogList.toString());
        mdv.addObject("admin", admin);
        return mdv;
    }

    /**
     * 侧边数据显示
     *
     * @return
     */
    @RequestMapping("/showBroadside")
    @ResponseBody
    public Map<String, Object> showBroadside() {
        //查询所有的分类
        List<BlogType> blogTypeList = blogTypeServiceImpl.showAllBlogType();
        //查询最新的文章进行主页显示
        List<Blog> blogs = blogServiceImpl.selectBlogByThree();
        //显示所有相册
        List<Album> albumList = albumServiceImpl.showAllAlbum();
        //查询所有友链
        List<Friends> friends = friendsServiceImpl.selectAllFriends();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("blogTypeList", blogTypeList);
        map.put("blogs", blogs);
        map.put("albumList", albumList);
        map.put("friends", friends);
        return map;
    }

}
