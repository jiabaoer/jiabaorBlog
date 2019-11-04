package com.jiabaoer.realm;

import com.jiabaoer.pojo.User;
import com.jiabaoer.service.UserService;
import com.jiabaoer.utils.EmailUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class UserRealm extends AuthorizingRealm {

    @Autowired
    private UserService userServiceImpl;

    /**
     * 授权
     *
     * @param principals
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {

        /**
         * 注意principals.getPrimaryPrincipal()对应
         * new SimpleAuthenticationInfo(user.getUserName(), user.getPassword(), getName())的第一个参数
         */
        //获取当前身份
        String email = (String) principals.getPrimaryPrincipal();
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();

        //从数据库中查找该用户有何角色和权限
        Set<String> roles = userServiceImpl.getRoles(email);
        Set<String> permissions = userServiceImpl.getPermissions(email);

        //为当前用户赋予对应角色和权限
        info.setRoles(roles);
        info.setStringPermissions(permissions);

        return info;
    }

    /**
     * 认证
     *
     * @param authcToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
        //获取用户名
        String email = (String) authcToken.getPrincipal();
        //查询用户信息
        User user = userServiceImpl.userLogin(email);
        if (user == null) {//能查询到数据则将查询到的数据封装到info中与token比较
            return null;
        }
        SecurityUtils.getSubject().getSession().setAttribute("userId", user.getId());
        String realmName = this.getName();
        // 存入用户信息
        List<Object> principals = new ArrayList<>();
        principals.add(user.getEmail());
        principals.add(user);
        AuthenticationInfo info = new SimpleAuthenticationInfo(principals, user.getPassword(), realmName);

        return info;
    }
}
