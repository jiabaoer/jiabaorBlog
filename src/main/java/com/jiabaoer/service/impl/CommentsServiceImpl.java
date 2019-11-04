package com.jiabaoer.service.impl;

import com.jiabaoer.mapper.CommentsMapper;
import com.jiabaoer.pojo.Comments;
import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.service.CommentsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CommentsServiceImpl implements CommentsService {

    @Autowired
    private CommentsMapper commentsMapper;

    /**
     * 查询所有未通过的评论
     * @return
     */
    public PageInfo selectAllComments(int pageSizeInit, int pageNumberInit) {
        PageInfo pi = new PageInfo();
        pi.setPageSize(pageSizeInit);
        pi.setPageNumber(pageNumberInit);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("pageStart", pageSizeInit * (pageNumberInit - 1));
        map.put("pageSize", pageSizeInit);
        pi.setList(commentsMapper.selectAllComments(map));
        // 总条数
        long count = commentsMapper.selectCommentsCount();
        pi.setTotal(count % pageSizeInit == 0 ? count / pageSizeInit : count / pageSizeInit + 1);
        return pi;
    }

    public int insertCommentsByBlogId(Comments comments) {
        return commentsMapper.insertCommentsByBlogId(comments);
    }

    @Override
    public int delCommentsByIdList(List<String> delComments_ids) {
        return commentsMapper.delCommentsByIdList(delComments_ids);
    }

    @Override
    public int delCommentsById(String parseInt) {
        return commentsMapper.delCommentsById(parseInt);
    }
}
