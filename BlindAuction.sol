// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

// TO-DO
// 1. List of bidders.
// 2. HighestBiddAmount;
// 3. HighestBidder.
// 4. The beneficiary person.
// 5. The Bid action End time.
// 6. Check is bid ended with Bool

contract BlindAuction {
    address payable public beneficiary;

    uint256 public highestBid;
    address public highestBidder;

    mapping(address => uint256) pendingReturns;
    uint256 public auctionEndTime;
    bool ended;

    event HighestBidIncreased(address bidder, uint256 amount);
    event AuctionEnded(address winner, uint256 amount);

    error ActionAlreadyEnded();
    error BidNotHighEnough(uint256 highestBid);
    error AuctionNotYetEnded();
    error AuctionEndAlreadyCalled();

    constructor(uint256 auctionTime, address payable beneficiaryAddress) {
        beneficiary = beneficiaryAddress;
        auctionEndTime = block.timestamp + auctionTime;
    }

    function bid() external payable {
        if (auctionEndTime > block.timestamp) revert ActionAlreadyEnded();
        if (msg.value <= highestBid) revert BidNotHighEnough(highestBid);
        if (highestBid != 0) {
            pendingReturns[highestBidder] = highestBid;
        }
        highestBid = msg.value;
        highestBidder = msg.sender;

        emit HighestBidIncreased(msg.sender, msg.value);
    }

    function withdraw() external {
        uint256 amount = pendingReturns[msg.sender];
        if (amount > 0) {
            pendingReturns[msg.sender] = 0;
            payable(msg.sender).transfer(amount);
        }
    }

    function auctionEnd() external {
        if (auctionEndTime > block.timestamp) revert AuctionNotYetEnded();
        if (ended) revert AuctionEndAlreadyCalled();
        ended = true;

        emit AuctionEnded(highestBidder, highestBid);
        beneficiary.transfer(highestBid);
    }
}
