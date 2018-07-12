pragma solidity ^0.4.20;

contract ESOP{
    event issueEvent(uint issueKey);

    // 授予记录数据
    enum IssueState { Close, Open }

    struct IssueStruct {
        //授予数量
        uint issueAmount;
        //行权单价
        uint32 exercisePrice;
        //授予日期
        uint32 issueDate;
        //成熟计划
        uint32 scheduleKey;
        //成熟期算日
        uint32 vestingStartDate;
        //状态
        IssueState issueState;
        // 每个证书领取Option的数量
        uint receiveAmount;
    }


    mapping (address => mapping (uint32 => IssueStruct)) public issueList;

    // 授予
    function issue (
        address _issueAddress, uint _issueAmount, uint32 _exercisePrice,
        uint32 _issueDate, uint32 _schedulekey, uint32 _vestingStartDate
    ) 
        external 
    {
        uint32 issueKey = 1;
        // 授予
        issueList[_issueAddress][issueKey] = IssueStruct({
            issueAmount: _issueAmount,
            exercisePrice: _exercisePrice,
            issueDate: _issueDate,
            scheduleKey: _schedulekey,
            vestingStartDate: _vestingStartDate,
            issueState: IssueState.Open,
            receiveAmount: 0
        });

        emit issueEvent(issueKey);
    }

    // 根据address、key 查看授予详情
    function showIssueDetail ( address _issueAddress) 
        public 
        view 
        returns ( uint issueAmount, uint32 exercisePrice, uint32 issueDate, uint32 scheduleKey, uint32 vestingStartDate ) 
    {
        IssueStruct storage issueDetail = issueList[_issueAddress][1];
        return ( 
            issueDetail.issueAmount, issueDetail.exercisePrice, issueDetail.issueDate, 
            issueDetail.scheduleKey, issueDetail.vestingStartDate
        );
    }
    
    // 查看某地址授予总数
    function getAddressIssueAmount(address _issueAddress) external view returns (uint){
        return issueList[_issueAddress][1].issueAmount;
    }
    // 查看某地址已领取Option总数
    function getAddressOptionAmount(address _issueAddress) external view returns (uint) {
        return issueList[_issueAddress][1].receiveAmount;
    }
}


// 0xca35b7d915458ef540ade6068dfe2f44e8fa733c,10000,1,20180712,1,20180712