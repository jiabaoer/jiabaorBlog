package com.jiabaoer.service;

import com.jiabaoer.pojo.Friends;

import java.util.List;

public interface FriendsService {

    List<Friends> selectAllFriends();

    int insertFriends(Friends friends);

    int updateFirnds(Friends friends);

    int deleteFriend(String id);
}
