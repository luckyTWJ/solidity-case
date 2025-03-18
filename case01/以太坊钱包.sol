// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract EtherWallet {
    address payable public   owner;

    constructor() {
        // 将部署者的身份传给owner
        owner = payable (msg.sender);
    }

    receive() external payable {}

    function withdraw(uint _amount) external {
        // 只能由合约的拥有者调用
        require(owner == msg.sender, "caller is not owner");
        //向合约的拥有者发送主币
        owner.transfer(_amount);

    //    payable ( msg.sender).transfer(_amount);
    }
// 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    function getBalance() external view returns(uint){
        return address(this).balance;
    }
}
