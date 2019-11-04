package com.jiabaoer.mapper;


import com.jiabaoer.pojo.User;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;
import java.util.Set;

public interface UserMapper {

    @Select("select count(*) from user where email=#{0}")
    int checkEmail(String email);

    @Insert("insert into user values(#{id},#{email},#{password},#{nickname},#{headPictrue},#{userType},#{roleId},null)")
    int userRegister(User user);

    User userLogin(String email);

    @Update("update user set password=#{password} where email=#{email}")
    int updPassword(@Param("email") String email, @Param("password") String password);

    @Select("select r.role_name from user u,role r where u.role_id=r.id and u.email=#{0}")
    Set<String> getRoles(String email);

    @Select("select p.permission_name from user u,role r,permission p where u.role_id=r.id and p.role_id=r.id and u.email=#{0}")
    Set<String> getPermissions(String email);

    @Select("select * from user where id = #{0}")
    User selUserInfo(String id);

    @Update("update user set nickname=#{nickname},headPictrue=#{headPictrue} where id = #{id}")
    int updUserInfo(User user);

    @Select("select count(*) from user where id=#{id} and password=#{password}")
    int checkPassword(@Param("id") String id, @Param("password") String password);

    @Update("update user set password = #{newPassword} where id = #{id}")
    int updPwd(@Param("id") String id, @Param("newPassword") String newPassword);

    List<User> selectAllUser(Map<String, Object> map);

    @Select("select count(*) from user")
    long selectUserCount();

    int delUserByIdList(List<String> delLeave_ids);

    @Delete("delete user,leaveword,comments from user left outer join leaveword on user.id=leaveword.user_id left outer join comments on leaveword.user_id=comments.user_id where user.id=#{0}")
    int delUserById(String parseInt);
}