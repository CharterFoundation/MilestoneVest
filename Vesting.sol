pragma solidity ^0.4.20;
import "./VestingSchedule.sol";
import "./Issue.sol";

contract Vesting is ESOP, VestingSchedule {

    event getOptionCoinEvent(address, uint);

    struct VestingStruct {
        uint32 vestingDate;
        uint vestingAmount;
    }
    //查看某地址、某ESOP、某个时间点的成熟数量
    function showVestingDetailByDate ( address _issueAddress, uint32 _issuekey, uint32 _date ) public view returns (uint vestedAmount) {

        VestingStruct[] memory VestingStructs = calculateVesting(_issueAddress,_issuekey);
        uint amount = 0;
        for (uint i = 0; i < VestingStructs.length; i++) {
            if(_date > VestingStructs[i].vestingDate) {
                amount += VestingStructs[i].vestingAmount;
            }
        }
        return amount;
    }
    //查看某个地址、某ESOP的成熟详情
    function showVestingDetail ( address _issueAddress, uint32 _issuekey ) external view returns (uint32[2],uint32[2],uint32[2],uint32[2]) {
        uint32[2] memory uints1 = [20190712,2500];
        uint32[2] memory uints2 = [20200712,5000];
        uint32[2] memory uints3 = [20210712,7500];
        uint32[2] memory uints4 = [20220712,10000];
        return (uints1,uints2,uints3,uints4);
    }

    //查看某个地址、截止到某一时间点的成熟总数
    // function showTotalVested ( address _issueAddress, uint32 _issuekey, uint32 _date ) public view returns () {

    //     return calculateVesting();
    // }

    // 公司设置员工是否可以提取OptionCoin
    function changeIssueStatus ( address _issueAddress, uint32 _issuekey ) external {
        require(issueList[_issueAddress][_issuekey].issueState == IssueState.Open);
        issueList[_issueAddress][_issuekey].issueState = IssueState.Close;
    }

    //issue address 根据成熟情况获取Option Coin
    function getVestedOptionCoin( address _issueAddress, uint32 _issuekey, uint _amount ) public {
        //数量是否超过已成熟数量、数量是否超过持有Option的数量
        // transfer(_issueAddress, _amount);

        // emit getOptionCoinEvent(issueAddress, _amount);
    }

    //内部调用方法，计算成熟详情
    function calculateVesting ( address _issueAddress, uint32 _issuekey ) internal returns ( VestingStruct[] ) {
        VestingStruct[] VestingStructs;

        // IssueStruct issue = issueList[_issueAddress][_issuekey];
        // Schedule schedule = scheduleList[issue.scheduleKey];

        VestingStructs.push(VestingStruct({
            vestingDate: 20190712,
            vestingAmount: 2500
        }));
        VestingStructs.push(VestingStruct({
            vestingDate: 20200712,
            vestingAmount: 2500
        }));
        VestingStructs.push(VestingStruct({
            vestingDate: 20210712,
            vestingAmount: 2500
        }));
        VestingStructs.push(VestingStruct({
            vestingDate: 20220712,
            vestingAmount: 2500
        }));

        return VestingStructs;
    }

}