package com.jiabaoer.service;

import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.pojo.User;

import java.util.List;
import java.util.Set;

public interface UserService {

    int checkEmail(String email);

    int userRegister(User user);

    User userLogin(String email);

    int updPassword(String email, String password);

    /**
     *   通过用户名查找该用户所有的角色并保存在Set集合中
     *   @param email
     *   @return Set<String>
     */
    Set<String> getRoles(String email);

    /**
     *   通过用户名查找该用户所有的权限并保存在Set集合中
     *   @param email
     *   @return Set<String>
     */
    Set<String> getPermissions(String email);

    User selUserInfo(String id);

    int updUserInfo(User user);

    int checkPassword(String id, String password);

    User updPwd(String id, String newPassword);

    PageInfo userManager(int pageSizeInit, int pageNumberInit);

    int delUserByIdList(List<String> delLeave_ids);

    int delUserById(String parseInt);
}
