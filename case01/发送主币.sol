// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract sendETH {
    // 有3中方法 发送eth
    // transfer 2300 gas  reverts
    // send 2300 return bool
    // call  all gas returns bool and data

    // 2种方法传入主币
    constructor() payable {}

    receive() external payable {}

    function sendVarTansfer(address payable _to) external payable {
        //gas 2260
        _to.transfer(123);
    }

    function sendVarSend(address payable _to) external payable {
        //gas 2260
       bool sent = _to.send(123);
       require(sent,"send fail!!");
    }

    function sendVarCall(address payable _to) external payable {
        //gas 6510
        (bool success,)=_to.call{value:123}("");
        require(success,"call fail!!");
    }
}

contract EthReceiver{
    event Log(uint amount,uint gas);

    receive() external payable { 
        emit Log(msg.value,gasleft());
    }
}