// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
//回退函数
contract Fallback{
    /**
    fallback() or receive()?
    Ether is sent to contract
                |
        is msg.data empty?
               / \
            yes   no
            /       \
receive() exist?   fallback()
        /   \
    yes     no
    /         \
receive()     fallback()    
    */

    event Log(string func,address sender,uint value,bytes data);

// 当合约中不存在的函数的调用 会回调
    fallback() external payable { 
        emit Log("fallback...", msg.sender, msg.value, msg.data);
    }

    // receive() external payable {
    //      emit Log("receive...", msg.sender, msg.value, "");
    //  }
}