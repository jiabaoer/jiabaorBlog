package com.jiabaoer.service;

import com.jiabaoer.pojo.Leave;
import com.jiabaoer.pojo.PageInfo;

import java.util.List;

public interface LeaveService {
    List<Leave> selAllLeave();

    int insertLeave(Leave leave);

    PageInfo leaveManager(int pageSizeInit, int pageNumberInit);

    int delLeaveByIdList(List<String> delLeave_ids);

    int delLeaveById(String parseInt);
}
