package com.jiabaoer.controller;

import com.jiabaoer.pojo.Carousel;
import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.service.CarouselService;
import org.apache.commons.io.FilenameUtils;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class CarouselController {

    @Resource
    private CarouselService carouselServiceImpl;


    @RequestMapping("/admin/carouselUpd")
    public String carouselUpd() {
        return "admin/carouselUpd";
    }

    /**
     * 显示所有轮播图
     *
     * @param pageSize
     * @param pageNumber
     * @return
     */
    @RequestMapping("/admin/carousel")
    public ModelAndView showAllCarousel(int pageSize, int pageNumber) {
        int pageSizeInit = 8;
        if (pageSize > 0) {
            pageSizeInit = pageSize;
        }
        int pageNumberInit = 1;
        if (pageNumber > 1) {
            pageNumberInit = pageNumber;
        }
        PageInfo pageInfo = carouselServiceImpl.showAllCarousel(pageSizeInit, pageNumberInit);
        ModelAndView mdv = new ModelAndView();
        mdv.setViewName("admin/carouselManager");
        mdv.addObject("pageInfo", pageInfo);
        return mdv;
    }


    @RequestMapping("/admin/delCarouselById/{id}")
    @ResponseBody
    public String delCarouselById(@PathVariable("id") String id) {
        int i = carouselServiceImpl.delCarouselById(id);
        if (i > 0) {
            return "删除成功";
        } else {
            return "删除失败";
        }
    }

    /**
     * 图片上传
     *
     * @param request
     * @param file
     * @return
     * @throws IOException
     */
    @RequestMapping("admin/carouselUpload")
    @ResponseBody
    public String uploadPicture(HttpServletRequest request, MultipartFile file) throws IOException {
        String name = UUID.randomUUID().toString().replaceAll("-", "").substring(0,10);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSS");
        String res = sdf.format(new Date());
        //设置图片上传路径
        String url = request.getServletContext().getRealPath("carousel");
        //设置新的文件名称
        String newFileName = res + name;
        //获取图片的扩展名
        String ext = FilenameUtils.getExtension(file.getOriginalFilename());
        file.transferTo(new File(url + "/" + newFileName + "." + ext));
        //完整的url
        String fileUrl = "/carousel/" + newFileName + "." + ext;
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

    @RequestMapping("/admin/addCaousel")
    @ResponseBody
    public String addCaousel(String carouselUrl) {
        int i = 0;
        Carousel c = null;
        if (carouselUrl.contains("-")) {
            //批量添加
            List<Carousel> list = new ArrayList<Carousel>();
            String[] carouselUrls = carouselUrl.split("-");

            //组装图片集合
            for (String ptUrl : carouselUrls) {
                c = new Carousel();
                System.out.println(ptUrl);
                c.setId(UUID.randomUUID().toString().replace("-", "").substring(0,10));
                c.setCarouselUrl(ptUrl);
                list.add(c);
            }
            i = carouselServiceImpl.addCarouselList(list);
        } else {
            c = new Carousel();
            c.setId(UUID.randomUUID().toString().replace("-", "").substring(0,10));
            c.setCarouselUrl(carouselUrl);
            //单个添加
            i = carouselServiceImpl.addCarouselOne(c);
        }
        if (i > 0) {
            return "添加成功";
        } else {
            return "添加失败";
        }
    }
}
