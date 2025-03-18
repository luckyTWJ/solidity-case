// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

/**
A call B, sends 1000 wei
      B calls C, sends 50 wei
A-->B-->C
*/

contract TestDelegateCall {
    // 被调用合约的 参数 类型 顺序 与委托函数的参数 类型顺序保持一致
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(uint256 _num) external payable {
        num = _num * 2;
        sender = msg.sender;
        value = msg.value;
    }
}

contract DelegateCall {
    // 委托  参数顺序 一样
    // 委托调用不会改变被委托的值，  但可以用委托的最新逻辑
    uint256 public num;
    address public sender;
    uint256 public value;

    function setVars(address _test, uint256 _num) external payable {
        // _test.delegatecall(
        //     abi.encodeWithSignature("setVars(uint )", _num);
        // );
        (bool success, bytes memory data) = _test.delegatecall(
            abi.encodeWithSelector(TestDelegateCall.setVars.selector, _num)
        );

        require(success, " delegatecall failed");
    }
}
