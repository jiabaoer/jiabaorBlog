package com.jiabaoer.controller;

import com.jiabaoer.pojo.Friends;
import com.jiabaoer.service.FriendsService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;
import java.util.UUID;

@Controller
public class FriendsController {

    @Resource
    private FriendsService friendsServiceImpl;

    /**
     * 查询所有友链
     *
     * @return
     */
    @RequestMapping("/admin/friends")
    public ModelAndView selectAllFriends() {
        List<Friends> friends = friendsServiceImpl.selectAllFriends();
        ModelAndView mdv = new ModelAndView("admin/friendsManager");
        mdv.addObject("friends", friends);
        return mdv;
    }

    /**
     * 添加友链
     *
     * @param friends
     * @return
     */
    @RequestMapping("/admin/addFriend")
    @ResponseBody
    public String addFriend(Friends friends) {
        friends.setId(UUID.randomUUID().toString().replace("-", "").substring(0,10));
        int i = friendsServiceImpl.insertFriends(friends);
        if (i > 0) {
            return "添加成功";
        } else {
            return "添加失败";
        }

    }

    /**
     * 根据id删除友链
     *
     * @param id
     * @return
     */
    @RequestMapping("/admin/delFriendById/{id}")
    @ResponseBody
    public String delFriendById(@PathVariable("id") String id) {
        int i = friendsServiceImpl.deleteFriend(id);
        if (i > 0) {
            return "删除成功";
        } else {
            return "删除失败";
        }
    }

    /**
     * 修改友链
     *
     * @param friends
     * @return
     */
    @RequestMapping("/admin/updFriendById")
    @ResponseBody
    public String updFriendById(Friends friends) {
        int i = friendsServiceImpl.updateFirnds(friends);
        if (i > 0) {
            return "修改成功";
        } else {
            return "修改失败";
        }
    }
}
