// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// 小猪存钱罐
contract PigPay{

    address public owner = msg.sender;

    event Withdraw(address indexed _from, uint256 _value);
    // 存款事件
    event Deposit(address indexed _to, uint256 _value);

    receive() external payable {
        // 收到钱了 发送个事件通知一下
        emit Deposit(msg.sender, msg.value);
    }
    function withdraw() external payable{
        require(owner==msg.sender,"not owner!!");
        emit Withdraw(owner, owner.balance);
        // 把钱取了 打碎存钱罐！！
        selfdestruct(payable (owner));
    }


}