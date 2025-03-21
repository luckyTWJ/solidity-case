// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
// 1.当前文件夹下
// import "./Account.sol";
// 2.引用某一个合约
import {Account} from "./权限.sol";

// 3.引用github链接 合约

contract AccountFactory {
    Account account;

    Account[] accounts;

    function createAccount() public returns (Account) {
        account = new Account();
        accounts.push(account);
        return account;
    }

    function getAccountByIndex(uint256 _index) public view returns (Account) {
        return accounts[_index];
    }

    function callGrantRole(
        uint256 _index,
        bytes32 _role,
        address _account
    ) public  {
        accounts[_index].grantRole(_role, _account);
    }
}
