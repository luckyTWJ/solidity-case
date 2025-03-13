// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

// 继承关键字 子类：is 方法：virtual 子方法：override
contract A {
    function foo() public pure virtual  returns (string memory) {
        return "A";
    }

    function bar() public pure virtual returns (string memory) {
        return "A";
    }
    function hello() public pure returns (string memory) {
        return "hello,world!";
    }
}

contract B is A{
    function foo() public pure override returns (string memory) {
        // 直接调用父类函数，实现对父类成员的继承，但是需要使用override来修饰

        return "B";
    }

    function bar() public pure override  returns (string memory) {
        // super.bar();
        return "B";
    }
}
