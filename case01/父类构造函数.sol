// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _txt) {
        text = _txt;
    }
}
// 第一种 硬编码方式 传参给构造函数
contract U is S("s"), T("t") {

}

// 按继承顺序 初始化  S->T->V
// 第二种 动态传参 分别传入
contract V is S, T{
    
    constructor(string memory name,string memory text) S(name) T(text){

    }
}
// 第三种 混合1，2模式
contract W is S("s"),T{
    constructor(string memory text) T(text){

    }
}

