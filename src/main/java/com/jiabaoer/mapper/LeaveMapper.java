package com.jiabaoer.mapper;

import com.jiabaoer.pojo.Leave;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;
import java.util.Map;

public interface LeaveMapper {

    List<Leave> selAllLeave();

    @Insert("insert into leaveword values(#{id},#{leaveText},#{leaveTime},#{userId})")
    int insertLeave(Leave leave);

    List<Leave> selectAllLeave(Map<String, Object> map);

    @Select("select count(*) from leaveword")
    long selectLeaveCount();

    int delLeaveByIdList(List<String> delLeave_ids);

    @Delete("delete from leaveword where id=#{0}")
    int delLeaveById(String parseInt);
}
