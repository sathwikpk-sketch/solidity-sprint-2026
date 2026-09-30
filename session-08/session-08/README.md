# Session 08 — Project Spec and Project Scope

**Name:** Sathwik PK
**Enrolment ID:** AU24UG035
**Date submitted:** 25/09/2026

## Project idea

I want to build a lightweight reward and tracking dApp for classroom or project-based activities, where users earn SWK tokens for completing tasks and can check their balance in a simple interface.

## Problem it solves

Students and small project teams often struggle to keep track of completed tasks, participation, or rewards in a transparent and verifiable way. Most existing tools are centralized, not easily auditable, and do not let users own or track on-chain progress in a simple manner.

## Scope for this sprint

- Token-based rewards for completed tasks
- Basic user balance and transfer flow
- Simple UI or dashboard for viewing the token state
- Minimal deploy and testing workflow on Sepolia

## Out of scope (for now)

- Full marketplace or trading features
- Advanced staking or lending mechanics
- Complex governance or multi-user admin system
- Large-scale frontend design work beyond the demo

## Tech stack

- Contracts: Solidity, OpenZeppelin
- Dev environment: Hardhat
- Network: Sepolia Testnet
- Frontend (if any): React + MetaMask + ethers.js

## Milestones

| Milestone | Target date |
| --- | --- |
| Contract design finalised | 26/09/2026 |
| Core contract written + tested | 27/09/2026 |
| Deployed to Sepolia | 28/09/2026 |
| Frontend / demo ready | 29/09/2026 |

## Risks / open questions

- Ensuring the wallet and deployment flow works smoothly on Sepolia
- Deciding how much on-chain logic should stay in the smart contract versus the frontend
- Keeping the demo simple enough to finish reliably within the sprint timeframe
