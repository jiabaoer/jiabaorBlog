package com.jiabaoer.service.impl;

import com.jiabaoer.mapper.LeaveMapper;
import com.jiabaoer.pojo.Leave;
import com.jiabaoer.pojo.PageInfo;
import com.jiabaoer.service.LeaveService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class LeaveServiceImpl implements LeaveService {

    @Autowired
    private LeaveMapper leaveMapper;

    public List<Leave> selAllLeave(){
        return leaveMapper.selAllLeave();
    }

    @Override
    public int insertLeave(Leave leave) {
        return leaveMapper.insertLeave(leave);
    }

    @Override
    public PageInfo leaveManager(int pageSizeInit, int pageNumberInit) {
        PageInfo pi = new PageInfo();
        pi.setPageSize(pageSizeInit);
        pi.setPageNumber(pageNumberInit);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("pageStart", pageSizeInit * (pageNumberInit - 1));
        map.put("pageSize", pageSizeInit);
        pi.setList(leaveMapper.selectAllLeave(map));
        // 总条数
        long count = leaveMapper.selectLeaveCount();
        pi.setTotal(count % pageSizeInit == 0 ? count / pageSizeInit : count / pageSizeInit + 1);
        return pi;
    }

    @Override
    public int delLeaveByIdList(List<String> delLeave_ids) {
        return leaveMapper.delLeaveByIdList(delLeave_ids);
    }

    @Override
    public int delLeaveById(String parseInt) {
        return leaveMapper.delLeaveById(parseInt);
    }
}
