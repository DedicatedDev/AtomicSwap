pragma solidity ^0.5.4;

import './utils/SafeMath.sol';

contract AtomicSwapETH {
    using SafeMath for uint256;

    address payable public target;
    address payable public backup;
    address payable public platform;

    uint public feeAmount;
    uint public amount;
    uint public hashedSecret;
    uint[2] public rawSecret;
    uint public timeLock;

    bool public withdrawn;
    bool public refunded;

    function contractBalance() view public returns(uint) {
        return address(this).balance;
    }

    modifier fundsSent() {
        require(contractBalance() >= amount, "Balance is less than the required");
        _;
    }

    modifier futureTimeLock(uint _time) {
        require(_time > now, "Timelock is not in the future");
        _;
    }

    modifier secretHashMatches(uint[2] memory _rawSecret) {
        require(hashedSecret == uint(sha256(abi.encodePacked(_rawSecret[0], _rawSecret[1]))), "Secret not matches the hash");
        _;
    }

    modifier withdrawable() {
        require(withdrawn == false, "Contract already withdrawed");
        _;
    }

    modifier refundable() {
        require(refunded == false, "Contract already refunded");
        require(withdrawn == false, "Contract already withdrawed");
        require(timeLock <= now, "Too early to call the refund");
        _;
    }

    constructor(
        address payable _target,
        address payable _backup,
        address payable _platform,
        uint _feeAmount,
        uint _amount,
        uint _timeLock,
        uint _hashedSecret
    )
    public
    futureTimeLock(_timeLock)
    {
        target = _target;
        backup = _backup;
        platform = _platform;
        feeAmount = _feeAmount;

        amount = _amount;
        timeLock = _timeLock;
        hashedSecret = _hashedSecret;
    }

    function () external payable {}

    function withdraw(uint[2] memory _rawSecret)
    public
    fundsSent
    secretHashMatches(_rawSecret)
    withdrawable
    returns (bool)
    {
        rawSecret = _rawSecret;
        withdrawn = true;

        // Calculate the platform fee before the withdraw
        uint platformFee = contractBalance().sub(amount).add(feeAmount);

        target.transfer(amount.sub(feeAmount));

        if (platformFee > 0) {
            platform.transfer(platformFee);
        }

        return true;
    }
    
    function refund()
    external
    fundsSent
    refundable
    returns (bool)
    {
        refunded = true;
        backup.transfer(address(this).balance);

        return true;
    }
}
