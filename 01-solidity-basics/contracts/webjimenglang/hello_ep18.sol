// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第十八节：不可变量
 *  
 */
contract ImmutableSectionEp18{
    uint public constant v1=1;
    uint public immutable v2=2;
    uint public v3=1;
}