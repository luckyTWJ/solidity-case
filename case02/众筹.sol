// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// 1.创建收款函数
// 2.记录投资人并且查看
// 3.在锁定期内，达到目标值，生产商可以提款
// 4.在锁定期内，没达到目标值，投资人在锁定期以后可以退款

contract FundMe {
    // 记录投资人
    mapping(address => uint256) public fundersToAmount;
    // 设置最小的交易值
    // uint256 public minVal = 1 * (10**18); //wei
    uint256 public minVal = 100 * (10**18); //USD 美元
    // 目标值
    uint256 public constant TARGET = 1000 * (10**18);

    address owner;

    // 0x694AA1769357215DE4FAC081bf1f309aDC325306
    //预言机
    AggregatorV3Interface internal dataFeed;

    constructor() {
        // sepolia 测试网
        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        owner = msg.sender;
    }

    // 收款函数
    function fund() external payable {
        require(convertETH2USD(msg.value) > minVal, "Send More ETH");
        fundersToAmount[msg.sender] = msg.value;
    }

    // 提款
    function getFund() external {
        require(
            convertETH2USD(address(this).balance) >= TARGET,
            "target is not reached"
        );
        require(owner == msg.sender, "Not the owner!!");
        // 三种转账方式：
        //1. transfer
        // payable(msg.sender).transfer(address(this).balance);

        //2. send  return bool
        // bool success = payable(msg.sender).send(this(address).balance);
        // require(success, "getFund failed ");

        //3. call transfer ETH with data return value of function and bool
        bool succ;
        (succ, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(succ, "getFund failed");

        //账户清零
        fundersToAmount[msg.sender] = 0;
    }

    // 退款
    function refund() public {
        // 众筹款小于目标值  退款
        require(
            convertETH2USD(address(this).balance) < TARGET,
            "target is reached"
        );
        uint256 amount = fundersToAmount[msg.sender];
        require(amount > 0, "there is no fund for you");
        // require(condition);
        (bool succ, ) = payable(msg.sender).call{value: amount}("");
        require(succ, "refund failed");
        //账户清零
        fundersToAmount[msg.sender] = 0;
    }

    function convertETH2USD(uint256 ethCount) internal view returns (uint256) {
        // 数据类型显式转换
        uint256 ethPrice = uint256(getChainlinkDataFeedLatestAnswer());
        //  ethValue = ethAmouont*eth price
        // ETH /USD precision =10**8
        return (ethCount * ethPrice) / (10**8);
    }

    function transferOwnerShip(address newOwner) external {
        require(owner == msg.sender, "only owner can call this method!!");
        owner = newOwner;
    }

    /**
     * Returns the latest answer.
     */
    function getChainlinkDataFeedLatestAnswer() public view returns (int256) {
        // prettier-ignore
        (
        /* uint80 roundID */,
        int answer,
        /*uint startedAt*/,
        /*uint timeStamp*/,
        /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }
}
