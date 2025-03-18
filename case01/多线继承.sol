// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract X {
    function foo() public pure virtual returns (string memory) {
        return "X";
    }

    function bar() public pure virtual returns (string memory) {
        return "X";
    }

    function x() public pure returns (string memory) {
        return "X";
    }
}
// Y 被子类重写 需要加virtual
contract Y is X {
    function foo() public pure override virtual returns (string memory) {
        return "Y";
    }

    function bar() public pure override virtual returns (string memory) {
        return "Y";
    }

    function y() public pure returns (string memory) {
        return "Y";
    }
}

// 顺序： 最基础的放在前面，派生依次放在后面  override(X,Y)表示同时覆盖
contract Z is X, Y {

    function bar() public pure override(X,Y) returns(string memory){
        return "Z";
    }
    function foo() public pure override (X,Y) returns(string memory){
        return "Z";
    }

}
