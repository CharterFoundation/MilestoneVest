pragma solidity ^0.4.20;

contract Whitelist {
    mapping (address => uint) whitelist;

    
    function addWhiteList (address _user, uint _amount) external {
        whitelist[_user] = _amount;
    }

    function removeWhiteList (address _user) external {
        delete whitelist[_user];
    }

    function isAllowTransfer(address _user) external view returns (bool) {
        return whitelist[_user] == 0 ? false : true;
    }

    function getAllowAmount(address _user) external view returns (uint) {
        return whitelist[_user];
    }
}

