package com.jiabaoer.controller;

import com.jiabaoer.pojo.Leave;
import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.service.LeaveService;
import net.sf.json.JSONArray;
import org.apache.ibatis.annotations.Param;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
public class LeaveController {

    @Resource
    private LeaveService leaveServiceImpl;

    /**
     * 查询所有留言
     *
     * @return
     */
    @RequestMapping("/leave")
    public ModelAndView selAllLeave() {
        List<Leave> leaves = leaveServiceImpl.selAllLeave();
        ModelAndView mdv = new ModelAndView("leacots");
        JSONArray jsonArray = JSONArray.fromObject(leaves);
        mdv.addObject("leaves", jsonArray.toString());
        return mdv;
    }

    /**
     * 添加留言
     *
     * @param leaveText
     * @param request
     * @return
     */
    @RequestMapping("/user/insertLeave")
    @ResponseBody
    public String insertLeave(@Param("leaveText") String leaveText, HttpServletRequest request) {
        String id = (String) SecurityUtils.getSubject().getSession().getAttribute("userId");
        Leave leave = new Leave();
        leave.setLeaveText(leaveText);
        leave.setId(UUID.randomUUID().toString().replace("-","").substring(0,10));
        leave.setUserId(id);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
        leave.setLeaveTime(sdf.format(new Date()));
        int i = leaveServiceImpl.insertLeave(leave);
        if (i > 0) {
            return "留言成功！";
        } else {
            return "留言失败！";
        }
    }

    /**
     * 查询所有留言
     *
     * @param pageSize
     * @param pageNumber
     * @return
     */
    @RequestMapping("/admin/leaveManager")
    public ModelAndView leaveManager(@RequestParam(defaultValue = "0") int pageSize, @RequestParam(defaultValue = "0") int pageNumber) {
        int pageSizeInit = 6;
        if (pageSize > 0) {
            pageSizeInit = pageSize;
        }
        int pageNumberInit = 1;
        if (pageNumber > 1) {
            pageNumberInit = pageNumber;
        }
        PageInfo pageInfo = leaveServiceImpl.leaveManager(pageSizeInit, pageNumberInit);
        ModelAndView mdv = new ModelAndView("admin/leaveManager");
        mdv.addObject("pageInfo", pageInfo);
        return mdv;
    }

    /**
     * 根据id删除评论
     *
     * @param ids
     * @return
     */
    @RequestMapping("/admin/delLeave_ids/{ids}")
    @ResponseBody
    public String delLeave_ids(@PathVariable("ids") String ids) {
        int id = 0;
        if (ids.contains("-")) {
            //批量删除
            List<String> delLeave_ids = new ArrayList<String>();
            String[] str_ids = ids.split("-");
            //组装id集合
            for (String str_id : str_ids) {
                delLeave_ids.add(str_id);
            }
            id = leaveServiceImpl.delLeaveByIdList(delLeave_ids);
        } else {
            //单个删除
            id = leaveServiceImpl.delLeaveById(ids);
        }
        if (id > 0) {
            return "删除成功";
        } else {
            return "删除失败";
        }
    }
}
