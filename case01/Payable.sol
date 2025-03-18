// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
contract Payable{
    address payable public owner;

    constructor(){
        owner = payable (msg.sender);
    }

// 可以接受主币支付
    function deposit() external payable {

    }

    function getBanlance() external view returns(uint){
        return address(this).balance;
    }
}