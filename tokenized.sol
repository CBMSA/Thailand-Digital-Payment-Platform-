
Smart Contract (Solidity - ThailandBond.sol)

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ThailandBond is ERC721URIStorage, Ownable {
    uint256 public nextBondId;

    struct BondDetails {
        string bondNumber;
        string country;
        string currency;
        uint256 amount;
        uint256 maturity;
        uint256 interestRate; // multiplied by 100 (e.g. 350 = 3.5%)
        string rateType;
        uint256 yieldRate;
        uint256 bid;
        uint256 ask;
        address issuedTo;
        string issueDate;
    }

    mapping(uint256 => BondDetails) public bonds;

    constructor() ERC721("ThailandTokenizedBond", "THBOND") {}

    function issueBond(
        string memory bondNumber,
        uint256 amount,
        uint256 maturity,
        uint256 interestRate,
        string memory rateType,
        uint256 yieldRate,
        uint256 bid,
        uint256 ask,
        string memory issueDate
    ) public {
        uint256 tokenId = nextBondId++;
        _mint(msg.sender, tokenId);

        bonds[tokenId] = BondDetails({
            bondNumber: bondNumber,
            country: "Thailand",
            currency: "THB",
            amount: amount,
            maturity: maturity,
            interestRate: interestRate,
            rateType: rateType,
            yieldRate: yieldRate,
            bid: bid,
            ask: ask,
            issuedTo: msg.sender,
            issueDate: issueDate
        });
    }

    function getBond(uint256 tokenId) public view returns (BondDetails memory) {
        require(_exists(tokenId), "Bond does not exist");
        return bonds[tokenId];
    }
}


---

Deployment & Integration

Deploy the Solidity contract on Ethereum testnet (e.g., Goerli or Sepolia).

Use Web3.js to connect the HTML to the deployed contract (issueBond()).

Replace dummy transaction with contract.methods.issueBond(...).send({ from: currentAccount }).




