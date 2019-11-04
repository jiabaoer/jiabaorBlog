package com.jiabaoer.service.impl;

import com.jiabaoer.mapper.BlogTypeMapper;
import com.jiabaoer.pojo.BlogType;
import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.service.BlogTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class BlogTypeServiceImpl implements BlogTypeService {

    @Autowired
    private BlogTypeMapper blogtypeMapper;

    /**
     * 查询所有的博客分类
     *
     * @return
     */
    public List<BlogType> showAllBlogType() {
        return blogtypeMapper.selectAllBlogType();
    }

    /**
     * 添加博客类别
     *
     *
     * @param id
     * @param btName
     * @return
     */
    public boolean addBlogType(String id, String btName) {
        int i = blogtypeMapper.addBlogType(id,btName);
        if (i > 0) return true;
        else return false;
    }

    /**
     * 查询所有的博客分类
     *
     * @param pageSizeInit
     * @param pageNumberInit
     * @return
     */
    public PageInfo selectBlogTypePageInfo(int pageSizeInit, int pageNumberInit) {
        PageInfo pi = new PageInfo();
        pi.setPageSize(pageSizeInit);
        pi.setPageNumber(pageNumberInit);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("pageStart", pageSizeInit * (pageNumberInit - 1));
        map.put("pageSize", pageSizeInit);
        pi.setList(blogtypeMapper.selectBlogTypePageInfo(map));
        // 总条数
        long count = blogtypeMapper.selectBlogTypeCount();
        pi.setTotal(count % pageSizeInit == 0 ? count / pageSizeInit : count / pageSizeInit + 1);
        return pi;
    }

    /**
     * 更具id删除博客类别
     *
     * @param btId
     * @return
     */
    public int delBlogTypeById(String btId) {
        return blogtypeMapper.delBlogTypeById(btId);
    }

    /**
     * 更新博客类别
     *
     * @param btId
     * @param btName
     * @return
     */
    public int updateBlogTypeById(String btId,String btName) {
        return blogtypeMapper.updateBlogTypeById(btId,btName);
    }

}
