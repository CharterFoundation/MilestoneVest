pragma solidity ^0.4.20;

contract VestingSchedule {
    // 自定义/非匀速

    // event addScheduleEvent(uint32 _maturePeriod, uint32 _scheduleLength, uint32 _matureLockupPeriod, uint32 _matureProportion);
    event addScheduleEvent(uint32 _scheduleKey);
    event updateScheduleEvent(uint32 _scheduleKey);
    event deleteScheduleEvent(uint32 _scheduleKey);

    struct Schedule {
        // 成熟周期，单位月
        uint32 maturePeriod;
        // 成熟计划长度，单位月
        uint32 scheduleLength;
        // 成熟锁定期,单位月
        uint32 matureLockupPeriod;
        // 立即成熟比例
        uint32 matureProportion;
        // 使用次数
        uint32 useCount;
    }

    uint32 scheduleKey = 1;
    // 成熟计划mapping数据
    mapping (uint32 => Schedule) scheduleList;

    // 添加成熟计划
    function addSchedule( uint32 _maturePeriod, uint32 _scheduleLength, uint32 _matureLockupPeriod, uint32 _matureProportion) 
        external 
    {
        createSchedule(_maturePeriod, _scheduleLength, _matureLockupPeriod, _matureProportion);
        emit addScheduleEvent(scheduleKey);
        scheduleKey++;
    }

    //查看成熟计划详情
    function showSchedule( uint32 _scheduleKey ) 
        external 
        view 
    returns (uint32 maturePeriod, uint32 scheduleLength, uint32 matureLockupPeriod, uint32 matureProportion) {
        Schedule storage schedule = scheduleList[_scheduleKey];
        return (schedule.maturePeriod, schedule.scheduleLength, schedule.matureLockupPeriod, schedule.matureProportion);
    }

    //修改成熟计划
    //ESOP是否使用过该成熟计划
    function updateSchedule( 
        uint32 _scheduleKey, uint32 _maturePeriod, uint32 _scheduleLength, 
        uint32 _matureLockupPeriod, uint32 _matureProportion
    ) 
        external 
    {
        delete scheduleList[_scheduleKey];
        createSchedule(_maturePeriod, _scheduleLength, _matureLockupPeriod, _matureProportion);
        emit updateScheduleEvent(scheduleKey);
    }

    //删除成熟计划
    function deleteSchedule( uint32 _scheduleKey ) 
        external 
    {
        delete scheduleList[_scheduleKey];
        emit deleteScheduleEvent(_scheduleKey);
    }

    function createSchedule( uint32 _maturePeriod, uint32 _scheduleLength, uint32 _matureLockupPeriod, uint32 _matureProportion )
        internal
    {   
        scheduleList[scheduleKey] = Schedule({
            maturePeriod: _maturePeriod,
            scheduleLength: _scheduleLength,
            matureLockupPeriod: _matureLockupPeriod,
            matureProportion: _matureProportion,
            useCount: 0
        });
    }
}