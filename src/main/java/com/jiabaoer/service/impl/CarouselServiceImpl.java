package com.jiabaoer.service.impl;

import com.jiabaoer.mapper.CarouselMapper;
import com.jiabaoer.pojo.Carousel;
import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.service.CarouselService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CarouselServiceImpl implements CarouselService {

    @Autowired
    private CarouselMapper carouselMapper;

    @Override
    public List<Carousel> selectCarousel() {
        return carouselMapper.selectCarousel();
    }

    @Override
    public PageInfo showAllCarousel(int pageSizeInit, int pageNumberInit) {
        PageInfo pi = new PageInfo();
        pi.setPageSize(pageSizeInit);
        pi.setPageNumber(pageNumberInit);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("pageStart", pageSizeInit * (pageNumberInit - 1));
        map.put("pageSize", pageSizeInit);
        pi.setList(carouselMapper.showAllCarouselByPage(map));
        // 总条数
        long count = carouselMapper.selectCarouselCount();
        pi.setTotal(count % pageSizeInit == 0 ? count / pageSizeInit : count / pageSizeInit + 1);
        return pi;
    }

    @Override
    public int delCarouselById(String id) {
        return carouselMapper.delCarouselById(id);
    }

    @Override
    public int addCarouselOne(Carousel c) {
        return carouselMapper.addCarouselOne(c);
    }

    @Override
    public int addCarouselList(List<Carousel> list) {
        return carouselMapper.addCarouselList(list);
    }
}
