
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title Thailand Government Token Wallet - Smart Contract for managing THB CBDC
contract ThailandCBDCWallet {
    address public centralBank;
    uint256 public totalTHBIssued;

    enum TransferType { Salary, Business, Pension }

    struct Transaction {
        address from;
        address to;
        uint256 amount;
        TransferType txType;
        uint256 timestamp;
    }

    mapping(address => uint256) public balances;
    Transaction[] public transactions;

    event THBIssued(address indexed to, uint256 amount);
    event THBTransferred(address indexed from, address indexed to, uint256 amount, TransferType txType);

    modifier onlyCentralBank() {
        require(msg.sender == centralBank, "Only central bank can perform this action");
        _;
    }

    constructor() {
        centralBank = msg.sender;
    }

    /// @notice Issue THB CBDC to a recipient
    function issueTHB(address to, uint256 amount) external onlyCentralBank {
        balances[to] += amount;
        totalTHBIssued += amount;
        emit THBIssued(to, amount);
    }

    /// @notice Transfer THB CBDC from sender to receiver
    function transferTHB(address to, uint256 amount, uint8 txTypeIndex) external {
        require(amount > 0, "Amount must be greater than 0");
        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(txTypeIndex <= uint8(TransferType.Pension), "Invalid transfer type");

        balances[msg.sender] -= amount;
        balances[to] += amount;

        transactions.push(Transaction({
            from: msg.sender,
            to: to,
            amount: amount,
            txType: TransferType(txTypeIndex),
            timestamp: block.timestamp
        }));

        emit THBTransferred(msg.sender, to, amount, TransferType(txTypeIndex));
    }

    /// @notice View user balance
    function getBalance(address user) external view returns (uint256) {
        return balances[user];
    }

    /// @notice Get total number of transactions
    function getTransactionCount() external view returns (uint256) {
        return transactions.length;
    }

    /// @notice Get details of a specific transaction
    function getTransaction(uint index) external view returns (
        address from,
        address to,
        uint256 amount,
        TransferType txType,
        uint256 timestamp
    ) {
        Transaction memory txn = transactions[index];
        return (txn.from, txn.to, txn.amount, txn.txType, txn.timestamp);
    }
}
