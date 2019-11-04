package com.jiabaoer.mapper;

import com.jiabaoer.pojo.Friends;
import org.apache.ibatis.annotations.Delete;

import java.util.List;

public interface FriendsMapper {

    List<Friends> selectAllFriends();

    int insertFriends(Friends friends);

    int updateFirnds(Friends friends);

    @Delete("delete from friends where id = #{0}")
    int deleteFriend(String id);
}
