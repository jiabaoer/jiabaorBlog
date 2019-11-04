package com.jiabaoer.service.impl;

import com.jiabaoer.mapper.FriendsMapper;
import com.jiabaoer.pojo.Friends;
import com.jiabaoer.service.FriendsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FriendsServiceImpl implements FriendsService {

    @Autowired
    private FriendsMapper friendsMapper;

    @Override
    public List<Friends> selectAllFriends() {
        return friendsMapper.selectAllFriends();
    }

    @Override
    public int insertFriends(Friends friends) {
        return friendsMapper.insertFriends(friends);
    }

    @Override
    public int updateFirnds(Friends friends) {
        return friendsMapper.updateFirnds(friends);
    }

    @Override
    public int deleteFriend(String id) {
        return friendsMapper.deleteFriend(id);
    }
}
