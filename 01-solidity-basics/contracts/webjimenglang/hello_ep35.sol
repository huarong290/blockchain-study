// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第三十五节：web3合约交互
 *  众筹合约 vue3+web3.js 智能合约交互
 *
 */
library AddressArray{

    function find(address[] memory addr,address search) internal pure returns(int){
        for(uint i;i<addr.length;i++){
            if(addr[i] == search){
                return int(i);
            }
        }
        return -1;
    }
}
contract web3InteractEp35{
    using AddressArray for address[];
    enum State{
        Pending,
        Success,
        Fail
    }
    struct Activity{
        uint id ;
        address creator;
        string title;
        string description;
        uint value;
        uint receiveAmount;
        uint deadline;
        uint minValue;
        uint minValuePercent;
        State state;
        uint finishAt;
        uint failAt;
        uint updatedAt;
    }
    event payLog(uint activityId,address sender,uint value,uint timeAt);
    modifier formValidate(uint value,uint deadline,uint minValue,uint minValuePercent){
        require(value >0,"value Must greater than 0");
        require(deadline >(block.timestamp+15),"Deadline is invalid");
        require(minValue >0,"minValue is invalid");
        require(minValuePercent >=50,"min value  percent is invalid");
        _;
    }

    receive() external payable{}

    fallback() external payable{}
    uint public activityId;

    Activity[] activityArr;

    mapping(uint=>address[])activitySender;

    mapping(uint=> mapping(address =>uint)) activitySenderValue;

    function createActivity(string[2]memory attr,uint value,uint deadline,uint minValue,uint minValuePercent) external formValidate(value,deadline,minValue,minValuePercent){
        Activity memory  _activity;
        _activity.id= ++activityId;
        _activity.title=attr[0];
        _activity.description=attr[1];
        _activity.creator = msg.sender;
        _activity.value = value;
        _activity.deadline = deadline;
        _activity.minValue= minValue;
        _activity.minValuePercent= minValuePercent;
        _activity.finishAt = block.timestamp;
        activityArr.push(_activity);
    }

    function pay(uint _activityId) external payable{
        require(_activityId <=activityId,"activityId is invalid ");
        require(activityArr[_activityId-1].state== State.Pending,"activity is finish ");
        require(msg.value >= activityArr[_activityId-1].minValue,"min value is valid");
        require(activityArr[_activityId-1].deadline > block.timestamp,"min value is valid");

        activityArr[_activityId-1].receiveAmount += msg.value;
        if(activitySender[_activityId].find(msg.sender) == -1){
            activitySender[_activityId].push(msg.sender);
        }
        emit payLog(_activityId,msg.sender,msg.value,block.timestamp);
    }
    function finish(uint _activityId) external{
    require(_activityId <=activityId,"activityId is invalid ");
    require(activityArr[_activityId-1].state== State.Pending,"activity is finish ");
    require(activityArr[_activityId-1].creator== msg.sender,"permission denied ");

     if(activityArr[_activityId-1].receiveAmount >= activityArr[_activityId-1].value){
        uint transAmount = activityArr[_activityId-1].receiveAmount;

        payable(activityArr[_activityId-1].creator).transfer(transAmount);
        activityArr[_activityId-1].state= State.Success;
        activityArr[_activityId-1].finishAt= block.timestamp;

            // finish
     }else{
        if( block.timestamp >=activityArr[_activityId-1].deadline ){
            // fail
            for( uint n;n<activitySender[_activityId].length;n++){
                address sender = activitySender[_activityId][n];

                uint payValue = activitySenderValue[_activityId][sender];
                payable(sender).transfer(payValue);
            }
            
        activityArr[_activityId-1].state= State.Fail;
        activityArr[_activityId-1].failAt= block.timestamp;
        }else{
            //ignore
        }
     }
    }


    function getActivity(uint _activityId) external view returns(bool ,Activity memory){
        Activity memory  _activity;
        if(_activityId>activityId || _activityId==0){
            return (false,_activity);
        }else{
            return (true,activityArr[_activityId -1]);
        }
        

    }

}