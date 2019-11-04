package com.jiabaoer.service;

import com.jiabaoer.pojo.Comments;
import com.jiabaoer.pojo.PageInfo;

import java.util.List;

public interface CommentsService {
    PageInfo selectAllComments(int pageSizeInit, int pageNumberInit);

    int insertCommentsByBlogId(Comments comments);

    int delCommentsByIdList(List<String> delComments_ids);

    int delCommentsById(String parseInt);
}
