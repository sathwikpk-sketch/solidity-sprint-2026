# Session 04 — Secure Ether Vault

**Name:** Sathwik PK
**Enrolment ID:** AU24UG035
**Date submitted:** 20/09/2026

## 1. What this contract does

This contract is a simple vault where users can deposit Ether and withdraw it later. Each address has its own balance, so nobody can take another person's Ether. Deposits and withdrawals emit events.

## 2. Design decisions

- Used a `mapping(address => uint256)` to store each user's balance. It is `public`, so I didn't need a separate getter function.
- Zero deposits are rejected with the custom error `ZeroDeposit`.
- In `withdraw`, I followed Checks-Effects-Interactions: check the balance, reduce it, then send the Ether. This stops reentrancy attacks.
- Used `call` to send Ether and checked if it succeeded.

## 3. Deployment

- Network: Remix VM
- Contract address: 0x...
- Transaction hash: 0x...

## 4. How to test it

1. `deposit()` with Value = 0 from account 1 → reverts with `ZeroDeposit`
2. `deposit()` with Value = 1 ether from account 1 → succeeds, emits `Deposited`
3. `balances(<account 1>)` → returns `1000000000000000000`
4. `withdraw(500000000000000000)` from account 1 → succeeds, emits `Withdrawn`
5. `balances(<account 1>)` → returns `500000000000000000`
6. `withdraw(5000000000000000000)` from account 1 → reverts with `InsufficientBalance`

## 5. What I found difficult

Understanding why the balance must be reduced before sending the Ether.

## 6. Acknowledgements

Used Claude (AI assistant) to help draft the contract and README. No external libraries used.