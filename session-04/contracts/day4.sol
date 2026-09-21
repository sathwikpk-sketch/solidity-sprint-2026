// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title EtherVault
/// @notice Lets users deposit and withdraw their own Ether.
contract EtherVault {
    // How much Ether (in wei) each address has in the vault
    mapping(address => uint256) public balances;

    event Deposited(address indexed user, uint256 amount);
    event Withdrawn(address indexed user, uint256 amount);

    error ZeroDeposit();
    error InsufficientBalance();
    error TransferFailed();

    /// @notice Send Ether to the vault and credit it to your balance.
    function deposit() external payable {
        if (msg.value == 0) revert ZeroDeposit();

        balances[msg.sender] += msg.value;

        emit Deposited(msg.sender, msg.value);
    }

    /// @notice Take out some of your Ether (amount is in wei).
    function withdraw(uint256 amount) external {
        // 1. Checks
        if (balances[msg.sender] < amount) revert InsufficientBalance();

        // 2. Effects (update balance BEFORE sending Ether)
        balances[msg.sender] -= amount;

        // 3. Interactions (send Ether last)
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        if (!success) revert TransferFailed();

        emit Withdrawn(msg.sender, amount);
    }
}