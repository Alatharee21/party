// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Party {
    uint deposit;
    address[] members;
    mapping(address => bool) paid;

	constructor(uint _deposit) {
        deposit = _deposit;
    }

    function rsvp() external payable {
        require(!paid[msg.sender]);
        require(msg.value == deposit);
        members.push(msg.sender);
        paid[msg.sender] = true;
    }

    function payBill(address venue, uint256 theCost) external {

        (bool success, ) = venue.call{value: theCost}("");
        require(success);

        uint256 theRemenant = address(this).balance/members.length;

        for(uint256 i = 0; i < members.length; i++){
        (bool sucess, ) = members[i].call{value: theRemenant}("");
        require(sucess);
        }
    }
}