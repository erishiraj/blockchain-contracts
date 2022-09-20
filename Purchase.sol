// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// TO-DO
// 1. Seller
// 2. Buyer
contract Purchase {
    uint256 public value;
    address payable public seller;
    address payable public buyer;

    enum State {
        Created,
        Locked,
        Release,
        Inactive
    }
    State public state;

    event Aborted();
    event PurchaseConfirmed();
    event ItemReceived();
    event SellerRefunded();

    error ValueNotEven();
    error InvalidState();

    modifier onlySeller() {
        require(msg.sender == seller, "You are not seller!");
        _;
    }
    modifier onlyBuyer() {
        require(msg.sender == buyer, "You are not buyer!");
        _;
    }
    modifier initState(State state_) {
        if (state != state_) revert InvalidState();
        _;
    }
    modifier condition(bool condition_) {
        require(condition_);
        _;
    }

    constructor() payable {
        seller = payable(msg.sender);
        value = msg.value / 2;
        if ((2 * value) != msg.value) revert ValueNotEven();
    }

    function abort() public onlySeller initState(State.Created) {
        emit Aborted();
        state = State.Inactive;
        seller.transfer(address(this).balance);
    }

    function confirmPurchase()
        external
        payable
        initState(State.Created)
        condition(msg.value == (2 * value))
    {
        emit PurchaseConfirmed();
        buyer = payable(msg.sender);
        state = State.Locked;
    }

    function confirmReceived() external onlyBuyer initState(State.Locked) {
        emit ItemReceived();
        state = State.Release;
        buyer.transfer(value);
    }

    function refundSeller() external onlySeller initState(State.Release) {
        emit SellerRefunded();
        state = State.Inactive;
        seller.transfer(3 * value);
    }
}
