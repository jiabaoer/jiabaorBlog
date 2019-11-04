package com.jiabaoer.service;

import com.jiabaoer.pojo.Carousel;
import com.jiabaoer.pojo.PageInfo;

import java.util.List;

public interface CarouselService {
    List<Carousel> selectCarousel();

    PageInfo showAllCarousel(int pageSizeInit, int pageNumberInit);

    int delCarouselById(String id);

    int addCarouselOne(Carousel c);

    int addCarouselList(List<Carousel> list);
}
