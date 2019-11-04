package com.jiabaoer.service;

import com.jiabaoer.pojo.BlogType;
import com.jiabaoer.pojo.PageInfo;

import java.util.List;

public interface BlogTypeService {
    List<BlogType> showAllBlogType();

    boolean addBlogType(String id, String btName);

    PageInfo selectBlogTypePageInfo(int pageSizeInit, int pageNumberInit);

    int delBlogTypeById(String btId);

    int updateBlogTypeById(String btId,String btName);

}
