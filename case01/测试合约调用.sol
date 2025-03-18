// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

// 在合约中调用另一个合约
contract CallTestContract {
    // way1 合约类型传入 地址
    function setX(address _address, uint256 _x) external {
        TestContract(_address).setX(_x);
    }

    // way2
    // function setx(TestContract test, uint256 _x) external {
    //     test.setX(_x);
    // }

    function getX(TestContract _test) external view returns (uint256) {
        return _test.getX();
    }

    function setXAndSendEther(address _address, uint256 _x) external payable {
        TestContract(_address).setAndReceiveEther{value: msg.value}(_x);
    }

    function getXAndValue(address _address)
        external
        view
        returns (uint256 x, uint256 val)
    {
        (x, val) = TestContract(_address).getXAndValue();
    }
}

contract TestContract {
    uint256 public x;
    uint256 public value = 123;

    function setX(uint256 _x) external {
        x = _x;
    }

    function getX() external view returns (uint256) {
        return x;
    }

    function setAndReceiveEther(uint256 _x) external payable {
        x = _x;
        value = msg.value;
    }

    function getXAndValue() external view returns (uint256, uint256) {
        return (x, value);
    }
}
