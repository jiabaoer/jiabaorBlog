package com.jiabaoer.controller;

import com.jiabaoer.pojo.Comments;
import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.service.CommentsService;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
public class CommentsController {

    @Resource
    private CommentsService commentsServiceImpl;

    /**
     * 查询所有的评论
     *
     * @param pageSize
     * @param pageNumber
     * @return
     */
    @RequestMapping("admin/selectAllComments")
    public ModelAndView selectAllComments(@RequestParam(defaultValue = "0") int pageSize, @RequestParam(defaultValue = "0") int pageNumber) {
        int pageSizeInit = 6;
        if (pageSize > 0) {
            pageSizeInit = pageSize;
        }
        int pageNumberInit = 1;
        if (pageNumber > 1) {
            pageNumberInit = pageNumber;
        }
        PageInfo pageInfo = commentsServiceImpl.selectAllComments(pageSizeInit, pageNumberInit);
        ModelAndView mdv = new ModelAndView("admin/commentReview");
        mdv.addObject("pageInfo", pageInfo);
        return mdv;
    }

    /**
     * 根据id删除评论
     *
     * @param ids
     * @return
     */
    @RequestMapping("/admin/delComments_ids/{ids}")
    @ResponseBody
    public String delComments_ids(@PathVariable("ids") String ids) {
        int id = 0;
        if (ids.contains("-")) {
            //批量删除
            List<String> delComments_ids = new ArrayList<String>();
            String[] str_ids = ids.split("-");
            //组装id集合
            for (String str_id : str_ids) {
                delComments_ids.add(str_id);
            }
            id = commentsServiceImpl.delCommentsByIdList(delComments_ids);
        } else {
            //单个删除
            id = commentsServiceImpl.delCommentsById(ids);
        }
        if (id > 0) {
            return "删除成功";
        } else {
            return "删除失败";
        }
    }

    /**
     * 插入评论
     *
     * @param comments
     * @return
     */
    @RequestMapping("/user/insertCommentsByBlogId")
    @ResponseBody
    public String insertCommentsByBlogId(Comments comments) {
        String id = (String) SecurityUtils.getSubject().getSession().getAttribute("userId");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
        String comTime = sdf.format(new Date());
        comments.setComId(UUID.randomUUID().toString().replace("-","").substring(0,10));
        comments.setComTime(comTime);
        comments.setUserId(id);
        int i = commentsServiceImpl.insertCommentsByBlogId(comments);
        if (i > 0) {
            return "评论成功！";
        } else {
            return "评论失败！";
        }
    }
}
