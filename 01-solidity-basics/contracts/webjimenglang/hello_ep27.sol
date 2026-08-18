// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第二十七节：委托调用
 *
 *  - address.delegateCall(...)       : 可修改状态变量，或附带 ETH 发送 (写操作)
 */
contract Executor{
    string name ;
    function setName(string memory _name)external{
        name = string(abi.encodePacked("Executor->",_name));
    }
}
contract DelegateCallSectionEp27{

    string public name;

    function makeExecutor() external returns(Executor){
        return new Executor();
    }
    function setName(address addr,string memory _name)external returns(bool,bytes memory){
      return  addr.delegatecall(abi.encodeWithSignature("setName(string)",_name));
    }

}