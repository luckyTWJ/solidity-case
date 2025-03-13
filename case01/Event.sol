// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;
contract Event{
    //带索引的 有索引的变量最多有3个
    event  Log(address indexed from, uint value);

    event indexedLog(address indexed from,uint val);

    event Message(address indexed _from,address indexed  _to,string message);
    function testLog(uint _value) external {
        emit Log(msg.sender, _value);

        emit indexedLog(msg.sender, _value);
    }
    function sendMessage(address to,string calldata text) external {
        emit Message(msg.sender, to,text);
    }


}