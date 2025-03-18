// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Immutable {
    // 不可变量  部署时/构造函数 ->初始化值  
    //  address public immutable owner = msg.sender;
    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }

    uint256 public x = 1;
// 28549   ->26417
    function foo() external  {
        require(msg.sender == owner);
        x ++;
    }
}
