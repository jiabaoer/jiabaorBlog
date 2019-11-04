package com.jiabaoer.mapper;

import com.jiabaoer.pojo.Carousel;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface CarouselMapper {

    List<Carousel> selectCarousel();

    @Select("select count(*) from carousel")
    long selectCarouselCount();

    List<Carousel> showAllCarouselByPage(Map<String, Object> map);

    @Delete("delete from carousel where id=#{0}")
    int delCarouselById(String id);

    @Insert("insert into carousel values(#{id},#{carouselUrl})")
    int addCarouselOne(Carousel c);

    int addCarouselList(List<Carousel> list);
}
