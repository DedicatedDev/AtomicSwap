pragma solidity >= 0.6.0;
pragma experimental ABIEncoderV2;
pragma AbiHeader expire;


contract NativeHTLC {
    uint public contractNonce;

    address target;
    address backup;
    address platform;

    uint128 feeAmount;
    uint128 amount;
    uint hashedSecret;
    uint[2] rawSecret;
    uint timeLock;

    bool withdrawn;
    bool refunded;

    modifier fundsSent() {
        require(address(this).balance >= amount);
        _;
    }

    modifier withdrawable() {
        require(withdrawn == false);
        _;
    }

    modifier onlyAfterWithdraw() {
        require(withdrawn == true);
        _;
    }

    modifier refundable() {
        require(refunded == false);
        require(withdrawn == false);
        require(timeLock <= now);
        _;
    }

    // Modifier-like functions
    function futureTimeLock(uint _time) internal view {
        require(_time > now);
    }

    function secretHashMatches(uint[2] _rawSecret) internal view {
        require(hashedSecret == uint(sha256(abi.encodePacked(_rawSecret[0], _rawSecret[1]))));
    }

    constructor(
        address _target,
        address _backup,
        address _platform,
        uint128 _feeAmount,
        uint128 _amount,
        uint _timeLock,
        uint _hashedSecret
    )
    public
    {
        tvm.accept();
        futureTimeLock(_timeLock);

        target = _target;
        backup = _backup;

        platform = _platform;

        feeAmount = _feeAmount;
        amount = _amount;
        timeLock = _timeLock;
        hashedSecret = _hashedSecret;
    }

    receive() external {}
    function withdraw(uint[2] _rawSecret)
        public
        fundsSent
        withdrawable
        returns (bool)
    {
        secretHashMatches(_rawSecret);
        tvm.accept();

        rawSecret = _rawSecret;
        withdrawn = true;

        target.transfer(amount - feeAmount, false, 1);

        return true;
    }

    function withdrawFee() public onlyAfterWithdraw {
        tvm.accept();

        platform.transfer(0, false, 128);
    }

    function refund()
        external
        fundsSent
        refundable
        returns (bool)
    {
        tvm.accept();
        refunded = true;

        backup.transfer(0, false, 128);

        return true;
    }

    function getBalance() public pure returns(uint) {
        return address(this).balance;
    }

    function getAmount() external view returns(uint) {
        return amount;
    }

    function getFeeAmount() external view returns(uint) {
        return feeAmount;
    }

    function getHashedSecret() external view returns(uint) {
        return hashedSecret;
    }

    function getTimeLock() external view returns(uint) {
        return timeLock;
    }

    function getWithdrawn() external view returns(bool) {
        return withdrawn;
    }

    function getRefunded() external view returns(bool) {
        return refunded;
    }

    function getRawSecret() external view returns(uint[2]) {
        return rawSecret;
    }

    function getTarget() external view returns(address) {
        return target;
    }

    function getBackup() external view returns(address) {
        return backup;
    }

    function getPlatform() external view returns(address) {
        return platform;
    }
}
