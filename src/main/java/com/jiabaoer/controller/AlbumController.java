package com.jiabaoer.controller;

import com.jiabaoer.pojo.Album;
import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.service.AlbumService;
import com.jiabaoer.service.PictureService;
import org.apache.commons.io.FilenameUtils;
import org.apache.shiro.SecurityUtils;
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
public class AlbumController {

    @Resource
    private AlbumService albumServiceImpl;

    @Resource
    private PictureService pictureServiceImpl;

    /**
     * 显示所有相册
     *
     * @param pageSize
     * @param pageNumber
     * @return
     */
    @RequestMapping("/admin/showAllAlbum")
    public ModelAndView showAllAlbum(int pageSize, int pageNumber) {
        int pageSizeInit = 8;
        if (pageSize > 0) {
            pageSizeInit = pageSize;
        }
        int pageNumberInit = 1;
        if (pageNumber > 1) {
            pageNumberInit = pageNumber;
        }
        PageInfo pageInfo = albumServiceImpl.showAllAlbum(pageSizeInit, pageNumberInit);
        ModelAndView mdv = new ModelAndView();
        mdv.setViewName("admin/albumManage");
        mdv.addObject("pageInfo", pageInfo);
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
    @RequestMapping("/admin/uploadAlbumPicture")
    @ResponseBody
    public String uploadAlbumPicture(HttpServletRequest request, MultipartFile file) throws IOException {
        String name = UUID.randomUUID().toString().replaceAll("-", "").substring(0,10);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSS");
        String res = sdf.format(new Date());
        //设置图片上传路径
        String url = request.getServletContext().getRealPath("album");
        //设置新的文件名称
        String newFileName = res + name;
        //获取图片的扩展名
        String ext = FilenameUtils.getExtension(file.getOriginalFilename());
        file.transferTo(new File(url + "/" + newFileName + "." + ext));
        //完整的url
        String fileUrl = "/album/" + newFileName + "." + ext;
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
     * 根据id删除相册
     *
     * @param albumId
     * @return
     */
    @RequestMapping("/admin/delAlbumById/{albumId}")
    @ResponseBody
    public String delAlbumById(@PathVariable("albumId") String albumId) {
        int i = albumServiceImpl.delAlbumById(albumId);
        if (i > 0) {
            return "删除成功";
        } else {
            return "删除失败";
        }
    }

    /**
     * 添加相册
     *
     * @param album
     * @return
     */
    @RequestMapping("/admin/addAlbum")
    @ResponseBody
    public String addAlbum(Album album) {
        String id = (String) SecurityUtils.getSubject().getSession().getAttribute("userId");
        album.setUserId(id);
        album.setId(UUID.randomUUID().toString().replace("-", "").substring(0,10));
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
        String date = sdf.format(new Date());
        album.setAmTime(date);
        album.setId(UUID.randomUUID().toString().replace("-", "").substring(0,10));
        int i = albumServiceImpl.addAlbum(album);
        if (i > 0) {
            return "添加成功";
        } else {
            return "添加失败";
        }
    }

    /**
     * 通过id更新相册
     *
     * @param album
     * @return
     */
    @RequestMapping("/admin/updateAlbumById")
    @ResponseBody
    public String updateAlbumById(Album album) {
        int i = albumServiceImpl.updateAlbumById(album);
        if (i > 0) {
            return "修改成功";
        } else {
            return "修改失败";
        }
    }

    /**
     * 根据id删除相片
     *
     * @param ids
     * @return
     */
    @RequestMapping("/admin/delPicture_ids/{ids}")
    @ResponseBody
    public String delPicture_ids(@PathVariable("ids") String ids) {
        int id = 0;
        if (ids.contains("-")) {
            //批量删除
            List<String> delPicture_ids = new ArrayList<String>();
            String[] str_ids = ids.split("-");
            //组装id集合
            for (String str_id : str_ids) {
                delPicture_ids.add(str_id);
            }
            id = pictureServiceImpl.delPictureByIdList(delPicture_ids);
        } else {
            //单个删除
            id = pictureServiceImpl.delPictureById(ids);
        }
        if (id > 0) {
            return "删除成功";
        } else {
            return "删除失败";
        }
    }

    /**
     * 显示所有相册
     *
     * @return
     */
    @RequestMapping("/album")
    public ModelAndView showAllAlbum() {
        List<Album> albumList = albumServiceImpl.showAllAlbum();
        ModelAndView mdv = new ModelAndView("album");
        mdv.addObject("albumList", albumList);
        return mdv;
    }

    /**
     * 显示所有图片根据相册id
     *
     * @param bId
     * @return
     */
    @RequestMapping("/showAlbumAllPictureById/{bId}")
    public ModelAndView showAlbumAllPictureById(@PathVariable("bId") String bId) {
        Album album = albumServiceImpl.showAlbumAllPictureById(bId);
        ModelAndView mdv = new ModelAndView("phoneInfo");
        mdv.addObject("album", album);
        return mdv;
    }
}
