// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SADCTokenizedBond is ERC20, Ownable {
    struct BondDetails {
        uint256 maturityDate;
        uint256 interestRate; // e.g., 5 represents 5%
        uint256 bidValue;
        uint256 askValue;
    }

    mapping(address => BondDetails) public issuers; // Issuer address mapped to bond details
    mapping(address => mapping(address => uint256)) public lastClaim; // Last claim timestamp per Bond", "SADCBOND") {}

    modifier onlyIssuer(address issuer) {
        require(issuers[issuer].maturityDate != 0, "Not a valid issuer");
        require(msg.sender == issuer, "Only issuer can perform this action");
        _;
    }

    function addIssuer(
        address issuer,
        uint256 _maturityDate,
        uint256 _interestRate,
        uint256 _bidValue,
        uintissuer] = BondDetails({
            maturityDate: _maturityDate,
            interestRate: _interestRate,
            bidValue: _bidValue,
            askValue: _askValue
        });
    }

    function updateIssuer(
        address issuer,
        uint256 _maturityDate,
        uint256 _interestRate,
        uint256 _bidValue,
        uint256 _askValue
    ) external onlyOwner {
        require(issuers[issuer].maturityDate != 0, "Issuer: _interestRate,
            bidValue: _bidValue,
            askValue: _askValue
        });
    }

    function issue(address to, uint256 amount) external onlyIssuer(msg.sender) {
        _mint(to, amount * 10 ** decimals());
        lastClaim[msg.sender][to] = block.timestamp;
    }

    function burn(address from, uint256 amount) external onlyIssuer(msg.sender) {
        _burn(from, amount * 10 ** decimals());
    }

    function claimInterest(address issuer) external {
        BondDetails memory bond = issuers[issuer];
        require(block.timestamp < bond.maturityDate, "Bond has matured");
        uint256 balance = balanceOf(msg.sender);
        require(balance > 0, "No bonds held");

        uint256 last = lastClaim[issuer][msg.sender];
        require(last < block.timestamp, "Already claimed");

        uint256 duration =        payable(msg.sender).transfer }

    function redeem(address issuer) external {
        BondDetails memory bond = issuers[issuer];
        require(block.timestamp >= bond.maturityDate, "Bond not yet matured");
        uint256 balance = balanceOf(msg.sender);
        require(balance > 0, "No bonds to redeem");
        _burn(msg.sender, balance);
        payable(msg.sender).transfer(balance);
    }

    receive() external payable {}
}