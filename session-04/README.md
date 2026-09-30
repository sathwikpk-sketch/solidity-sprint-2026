# Session 04 — Secure Ether Vault

**Name:** Sathwik PK
**Enrolment ID:** AU24UG035
**Date submitted:** 20/09/2026

## 1. What this contract does

This contract is a simple vault where users can deposit Ether and withdraw it
later. Each address has its own balance, so nobody can take another
person's Ether. Deposits and withdrawals emit events.

## 2. Design decisions

- Used a `mapping(address => uint256)` to store each user's balance. It is
  `public`, so I did not need a separate getter function.
- Zero deposits are rejected with the custom error `ZeroDeposit`.
- In `withdraw`, I followed the Checks-Effects-Interactions pattern: check the
  balance, reduce it, then send the Ether. This helps prevent reentrancy
  attacks.
- Used `call` to send Ether and checked whether the call succeeded.

## 3. Deployment

- Network: Remix VM
- Contract address: 0x...
- Transaction hash: 0x...

## 4. How to test it

1. `deposit()` with value = 0 from Account 1 → reverts with `ZeroDeposit`.
2. `deposit()` with value = 1 ether from Account 1 → succeeds and emits
   `Deposited`.
3. `balances(<account 1>)` → returns `1000000000000000000`.
4. `withdraw(500000000000000000)` from Account 1 → succeeds and emits
   `Withdrawn`.
5. `balances(<account 1>)` → returns `500000000000000000`.
6. `withdraw(5000000000000000000)` from Account 1 → reverts with
   `InsufficientBalance`.

## 5. What I found difficult

Understanding why the balance must be reduced before sending the Ether was
the key idea in this contract. Once that ordering was clear, the reentrancy
risk became much easier to reason about.

## 6. Acknowledgements

No external libraries were used; this contract and README were written by me.
