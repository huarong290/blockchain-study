// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

/**
 *  Solidity 第三十四节：多签钱包
 *
 *
 */
// @notice 签名状态枚举
    enum State {
        Pending,  // 待处理
        Approved, // 已通过并执行
        Rejected  // 已拒绝
    }
// @notice 签名者记录结构体
    struct Signer {
        address account;  // 签名者地址
        State state;      // 签名态度 (Approved / Rejected)
        uint256 signedAt; // 签名时间戳
    }
/**
 * @title SignerArray
 * @dev 针对 Signer 数组的查找扩展工具库
 */
library SignerArray {
    /**
     * @notice 在 Signer 数组中查找指定地址
     * @param _signer 签名者数组
     * @param addr 目标查找地址
     * @return 存在返回数组索引，不存在返回 -1
     */
    function find(Signer[] storage _signer,address addr) internal view returns(int){
        for(uint n;n<_signer.length;n++){
            if(_signer[n].account == addr){
                return int(n);
            }
        }
        return -1;
    }
}
contract MultSignEp34 {
    using SignerArray for Signer[];
    event Commited(uint indexed txId, address indexed creator ,string title ,uint timeAt);
    event Approved(uint indexed txId, address indexed signer ,uint timeAt);
    event Rejected(uint indexed txId, address indexed signer ,uint timeAt);


    receive() external payable{}
    fallback() external payable{}
    constructor(address[] memory _owner){
        owner = _owner;
    }
    modifier onlyOwner(){
        bool ok ;
        for(uint n;n<owner.length;n++){
            if(owner[n] == msg.sender){
                ok = true ;
                break;
            }
        }
        require(ok,"Permission denied");
        _;
    }
   modifier checkBefore(uint _txId) {
        require(_txId>0 &&_txId <= txId,"Trx does not exists");
        require(transactions[_txId -1].state == State.Pending,"Trx was finishe");
       require(transationSigner[_txId].find(msg.sender)== -1,"Try was signed");
       _;
    }
    struct Transaction {
        uint id;
        string title;
        address to;
        uint value;
        bytes data;
        State state;
        uint[3] timeAt; //approvedAt.rejectedAt,createdAt
    }

    mapping(uint => Signer[]) public transationSigner;
    Transaction[] transactions;
    address[] public owner;
    uint public txId;


    function commit(string memory title,address to,uint value,bytes calldata data) external onlyOwner{
        Transaction memory trx;
        trx.id = ++txId;
        trx.title = title;
        trx.to = to;
        trx.value = value;
        trx.data = data;
        trx.state = State.Pending;
        trx.timeAt[2] = block.timestamp;

        transactions.push(trx);
        transationSigner[txId].push(
            Signer({
                account: msg.sender,
                state: State.Approved,
                signedAt: block.timestamp
            })
        );
        emit Commited(trx.id,msg.sender,trx.title,block.timestamp);
    }
    function approved(uint _txId) external onlyOwner checkBefore(_txId) {

        transationSigner[_txId].push(
            Signer({
                account: msg.sender,
                state: State.Approved,
                signedAt: block.timestamp
            })
        );
        if(transationSigner[_txId].length == owner.length){
            Transaction memory trx = transactions[_txId-1];
            trx.state = State.Approved;
            trx.timeAt[0] = block.timestamp;

          (bool ok,) =  address(trx.to).call{
                value: trx.value
                }(trx.data);
          
          require(ok,"execure failed");
        }
        emit Approved(_txId,msg.sender,block.timestamp);
    }
    function rejected(uint _txId) external onlyOwner  checkBefore(_txId) {
        transactions[_txId-1].state = State.Rejected;
        transactions[_txId-1].timeAt[1] = block.timestamp;
                transationSigner[_txId].push(
            Signer({
                account: msg.sender,
                state: State.Rejected,
                signedAt: block.timestamp
            })
        );
    emit Rejected(_txId,msg.sender,block.timestamp);
    }
    //state
    function getTransationList(State state,uint pageNum,uint pageSize) external view returns(Transaction[] memory){
        Transaction[] memory result = new Transaction[](pageSize);
        uint offset = pageNum<=1?0:pageNum*pageSize;
        uint i ;
        for(uint n=offset; n< transactions.length;n++){
            if(transactions[n].state == state){
                result[i] = transactions[n];
            }
            if(++i>= pageSize){
                break;
            }
            
        }
        Transaction[] memory resultFilter = new Transaction[](i);
        for(uint k ;k<i;k++){
             resultFilter[k] = result[k];
        }
        return resultFilter;
    }
}
