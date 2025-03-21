// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
// 自毁合约 
// 强制发送主币
contract Kill{
    constructor() payable {}

    function kill() external {
        // 强制发送主币
        selfdestruct(payable (msg.sender));
    }

    function TestCall() external pure returns(uint){
        return 123;
    }
}

contract Helper{
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    function kill(Kill _kill) external {
        _kill.kill();
    }
}