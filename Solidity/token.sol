// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MyToken is ERC20, ERC20Permit {
    struct Order {
        address userID;
        address deliveryID;
        uint orderValue;
        string orderID;
    }
    constructor() ERC20("MyToken", "MTK") ERC20Permit("MyToken") {
        _mint(address(this),100000000);
    }
    Order[] internal orders;
    function StartOrder(address buyer,address medium,uint val,string memory orderID) public {
        orders.push(Order(buyer,medium,val,orderID));
        _transfer(medium, buyer, val);
    }
    function completeDelivery(address user,uint val) public {
        _transfer(address(this), user, val);

    }
}