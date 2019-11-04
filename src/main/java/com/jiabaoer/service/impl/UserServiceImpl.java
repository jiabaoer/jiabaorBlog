package com.jiabaoer.service.impl;

import com.jiabaoer.mapper.UserMapper;
import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.pojo.User;
import com.jiabaoer.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;

    public int checkEmail(String email) {
        return userMapper.checkEmail(email);
    }

    public int userRegister(User user) {
        return userMapper.userRegister(user);
    }

    public User userLogin(String email) {
        return userMapper.userLogin(email);
    }

    @Override
    public int updPassword(String email, String password) {
        return userMapper.updPassword(email, password);
    }

    @Override
    public Set<String> getRoles(String email) {
        return userMapper.getRoles(email);
    }

    @Override
    public Set<String> getPermissions(String email) {
        return userMapper.getPermissions(email);
    }

    @Override
    public User selUserInfo(String id) {
        return userMapper.selUserInfo(id);
    }

    @Override
    public int updUserInfo(User user) {
        return userMapper.updUserInfo(user);
    }

    @Override
    public int checkPassword(String id, String password) {
        return userMapper.checkPassword(id, password);
    }

    @Override
    public User updPwd(String id, String newPassword) {
        int i = userMapper.updPwd(id, newPassword);
        if (i > 0) {
            return userMapper.selUserInfo(id);
        } else {
            return null;
        }
    }

    @Override
    public PageInfo userManager(int pageSizeInit, int pageNumberInit) {
        PageInfo pi = new PageInfo();
        pi.setPageSize(pageSizeInit);
        pi.setPageNumber(pageNumberInit);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("pageStart", pageSizeInit * (pageNumberInit - 1));
        map.put("pageSize", pageSizeInit);
        pi.setList(userMapper.selectAllUser(map));
        // 总条数
        long count = userMapper.selectUserCount();
        pi.setTotal(count % pageSizeInit == 0 ? count / pageSizeInit : count / pageSizeInit + 1);
        return pi;
    }

    @Override
    public int delUserByIdList(List<String> delLeave_ids) {
        return userMapper.delUserByIdList(delLeave_ids);
    }

    @Override
    public int delUserById(String parseInt) {
        return userMapper.delUserById(parseInt);
    }

}
