// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第十二节：枚举与常量
 *
 */
contract EnumAndConstantSectionEp12{

    enum State{
        DEFAULT,
        PENDING,
        FALLBACK,
        SUCCESS
    }
    State public state;

    uint8 public id ;
    uint8 public constant sex= 0;
    function setState(State _state) public returns(State){
    state =_state;
    return state;
    }

    function resetState()public returns(State) {
        delete state;
        return state;
    }

    function getStatsMin() public pure returns(uint8){
        return uint8(type(State).min);
    }

        function getStatsMax() public pure returns(uint8){
        return uint8(type(State).max);
    }
}