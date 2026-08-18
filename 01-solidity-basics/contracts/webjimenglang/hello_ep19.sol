// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第十九节：支付与收款
 *  
 */
contract ImmutableSectionEp19{
    mapping (address => uint) public balances;

    receive() external payable{
        depostit();
    }

    function depostit () public payable{
        balances[msg.sender] += msg .value;
    }
    function withdraw(uint v) public {
        require(balances[msg.sender] >= v,"Out of funds");
         balances[msg.sender] -= v;

         //
         payable(msg.sender).transfer(v);
    }
}