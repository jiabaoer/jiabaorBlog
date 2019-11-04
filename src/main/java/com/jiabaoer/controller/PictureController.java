package com.jiabaoer.controller;

import com.jiabaoer.pojo.Album;
import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.pojo.Picture;
import com.jiabaoer.service.PictureService;
import org.apache.commons.io.FilenameUtils;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
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
public class PictureController {

    @Resource
    private PictureService pictureServiceImpl;

    /**
     * 查询所有相册列表
     *
     * @return
     */
    @RequestMapping("/admin/picture")
    public ModelAndView picture() {
        List<Album> albumList = pictureServiceImpl.selectAllAlbum();
        ModelAndView mdv = new ModelAndView("admin/uploadPhoto");
        mdv.addObject("albumList", albumList);
        return mdv;
    }

    /**
     * 图片上传
     *
     * @param request
     * @param file
     * @return
     * @throws IOException
     */
    @RequestMapping("/admin/uploadPicture")
    @ResponseBody
    public String uploadPicture(HttpServletRequest request, MultipartFile file) throws IOException {
        String name = UUID.randomUUID().toString().replaceAll("-", "").substring(0,10);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSS");
        String res = sdf.format(new Date());
        //设置图片上传路径
        String url = request.getServletContext().getRealPath("picture");
        //设置新的文件名称
        String newFileName = res + name;
        //获取图片的扩展名
        String ext = FilenameUtils.getExtension(file.getOriginalFilename());
        file.transferTo(new File(url + "/" + newFileName + "." + ext));
        //完整的url
        String fileUrl = "/picture/" + newFileName + "." + ext;
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
     * 添加图片
     *
     * @param picture
     * @return
     */
    @RequestMapping("/admin/addPicture")
    @ResponseBody
    public String addPicture(Picture picture) {
        int i = 0;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String date = sdf.format(new Date());
        if (picture.getPtUrl().contains("-")) {
            //批量添加
            List<Picture> list = new ArrayList<Picture>();
            String[] ptUrls = picture.getPtUrl().split("-");
            //组装图片集合
            Picture p = null;
            for (String ptUrl : ptUrls) {
                p = new Picture();
                p.setId(UUID.randomUUID().toString().replace("-", "").substring(0,10));
                p.setAmId(picture.getAmId());
                p.setPtUrl(ptUrl);
                p.setUpdTime(date);
                list.add(p);
            }
            i = pictureServiceImpl.addPictureList(list);
        } else {
            picture.setId(UUID.randomUUID().toString().replace("-", "").substring(0,10));
            picture.setUpdTime(date);
            //单个添加
            i = pictureServiceImpl.addPictureOne(picture);
        }
        if (i > 0) {
            return "添加成功";
        } else {
            return "添加失败";
        }
    }

    /**
     * 查询所有的图片进行分页显示
     *
     * @param pageSize
     * @param pageNumber
     * @return
     */
    @RequestMapping("/admin/selectAllPicture")
    public ModelAndView selectAllPicture(int pageSize, int pageNumber) {
        int pageSizeInit = 5;
        if (pageSize > 0) {
            pageSizeInit = pageSize;
        }
        int pageNumberInit = 1;
        if (pageNumber > 1) {
            pageNumberInit = pageNumber;
        }
        PageInfo pageInfo = pictureServiceImpl.selectAllPicture(pageSizeInit, pageNumberInit);
        ModelAndView mdv = new ModelAndView("admin/photoManage");
        mdv.addObject("pageInfo", pageInfo);
        return mdv;
    }

}
