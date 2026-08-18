// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 工厂合约
 *
 */
contract Goods {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
    function getName() external view returns(string memory){
        return name;
    }
}

contract FactorySectionEp15 {
    Goods[] goodList;

    function makeGoods(string memory _name) external returns (Goods) {
        Goods goods = new Goods(_name);
        goodList.push(goods);
        return goods;
    }

    function callGoodName(uint k) external returns(string memory){
        if(k< goodList.length){
            return goodList[k].getName();
        }
        return "";
    }
}
