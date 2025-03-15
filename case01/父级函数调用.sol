// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract E {
    event Log(string message);

    function foo() public virtual {
        emit Log("E.foo");
    }

    function bar() public virtual {
        emit Log("E.bar");
    }
}

contract F is E {
    function foo() public override virtual  {
        emit Log("F.foo");
        // 调用父级 方法
        E.foo();
    }

    function bar() public override virtual  {
        emit Log("F.bar");
        super.bar();
    }
}

contract G is E {
    function foo() public override virtual  {
        emit Log("G.foo");
        // 调用父级 方法
        E.foo();
    }

    function bar() public override virtual {
        emit Log("G.bar");
        super.bar();
    }
}

contract H is F,G{
    function foo()public override (F,G){
        F.foo();
    }
    function bar() public override (F,G){
        super.bar();
    }
}