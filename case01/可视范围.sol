// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// visibility
// private -only inside contract
// internal -only inside and child contract
// external -outside contract
// public - inside and outside contract

contract VisibilityBase {
    uint256 private x = 0;
    uint256 internal y = 1;
    uint256 public z = 2;

    function privateFunc() private pure returns (uint256) {
        return 0;
    }

    function internalFunc() internal pure returns (uint256) {
        return 100;
    }

    function externalFunc() external pure returns (uint256) {
        return 200;
    }

    function publicFunc() public pure returns (uint256) {
        return 300;
    }

    function examples() external view {
        x + y + z;
        privateFunc();
        internalFunc();
        publicFunc();
        // externalFunc();
        // 外部函数访问方式
        this.externalFunc();
    }
}

contract VisibilityChild is VisibilityBase {
    function examples2() external view {
        
        y;
        z;
        // x 无法访问到   私有函数
        // x;
        internalFunc();
        publicFunc();
        // 访问父类外部函数
        this.externalFunc();
        // externalF

    }
}
