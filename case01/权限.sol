pragma solidity ^0.8.0;

contract AccessControl{
//

    function aa() internal returns(int){
        return 2;
    }

    function setX(address _address, uint256 _x) external {
        TestContract(_address).setX(_x);
    }
    //
}