// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Account {
    //   role => address=>bool
    mapping(bytes32 => mapping(address => bool)) public roles;
    // 加索引  链外查询方便
    event GrantRole(bytes32 indexed role, address indexed account);
    // 撤销权限事件
    event RevokeRole(bytes32 indexed role, address indexed account);
    // 用哈希值作为角色名称，消耗的gas少点 不用字符串
    bytes32 private constant _ROLE_DEFAULT = "default";
    // 0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private  constant _ROLE_USER = keccak256(abi.encodePacked("USER"));
    //0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private  constant _ROLE_ADMIN = keccak256(abi.encodePacked("ADMIN"));
    // account 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    constructor() {
        // 添加管理员角色
        //roles[_ROLE_ADMIN][msg.sender] = true;
        //内部升级权限
        _grantRole(_ROLE_ADMIN, msg.sender);
    }

    // 升级权限  内部调用加_
    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        // 修改值后 得发送事件
        emit GrantRole(_role, _account);
    }

    // 撤销权限
    function _revokeRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = false;
        // 修改值后 得发送事件
        emit RevokeRole(_role, _account);
    }

    modifier onlyByRole(bytes32 _role) {
        require(roles[_role][msg.sender], "not authorized");
        _;
    }

    // 升级权限  外部调用  管理员可调用 加函数修改器
    function grantRole(bytes32 _role, address _account)
    external
    onlyByRole(_ROLE_ADMIN)
    {
        _grantRole(_role, _account);
    }

    // 撤销权限  外部调用  管理员可调用 加函数修改器
    function revokeRole(bytes32 _role, address _account)
    external
    onlyByRole(_ROLE_ADMIN)
    {
        _revokeRole(_role, _account);
    }
}
