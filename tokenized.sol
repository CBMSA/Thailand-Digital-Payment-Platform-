
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
        uint256 amount; // in THB
        uint256 maturity; // in years
        uint256 interestRate; // basis points (e.g., 350 = 3.5%)
        string rateType; // Fixed or Floating
        uint256 yieldRate; // basis points
        uint256 bid; // price
        uint256 ask; // price
        address issuedTo;
        string issueDate;
    }

    mapping(uint256 => BondDetails) public bonds;

    event BondIssued(
        uint256 indexed tokenId,
        address indexed issuedTo,
        string bondNumber,
        uint256 amount,
        uint256 maturity,
        uint256 interestRate,
        string rateType,
        uint256 yieldRate,
        uint256 bid,
        uint256 ask,
        string issueDate
    );

    constructor() ERC721("ThailandTokenizedBond", "THBOND") {}

    function issueBond(
        string memory bondNumber,
        uint256 amount,
        uint256 maturity,
        uint256 interestRate, // in basis points
        string memory rateType,
        uint256 yieldRate, // in basis points
        uint256 bid,
        uint256 ask,
        string memory issueDate,
        string memory tokenURI // optional metadata link
    ) public {
        require(amount > 0, "Amount must be > 0");
        require(maturity > 0, "Maturity must be > 0");

        uint256 tokenId = nextBondId++;
        _mint(msg.sender, tokenId);
        _setTokenURI(tokenId, tokenURI);

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

        emit BondIssued(
            tokenId,
            msg.sender,
            bondNumber,
            amount,
            maturity,
            interestRate,
            rateType,
            yieldRate,
            bid,
            ask,
            issueDate
        );
    }

    function getBond(uint256 tokenId) public view returns (BondDetails memory) {
        require(_exists(tokenId), "Bond does not exist");
        return bonds[tokenId];
    }
}



