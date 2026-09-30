# Session 07 — Build, Deploy & Test Your Own dApp

**Name:** Sathwik PK
**Enrolment ID:** AU24UG035
**Date submitted:** 24/09/2026

## 1. What this contract does

This session moves the Session 05 token (SWKToken) out of Remix and into a
proper Hardhat project. The contract itself is unchanged — same
owner-mintable, holder-burnable ERC-20 from before. What's new is an
automated test suite covering the core behaviours, plus a Hardhat Ignition
module to deploy to Sepolia.

## 2. Design decisions

**Hardhat Ignition instead of a manual deploy script** — Ignition keeps
track of what's already been deployed, so if a deploy gets interrupted
halfway it can pick up where it left off instead of redeploying from
scratch.

**TypeScript for the tests** — matches the default Hardhat template, and
catching typos at compile time beats finding them mid-test-run.

**Initial supply passed as a parameter** — kept it as a constructor
argument (set to 1000 in the Ignition module) rather than hardcoding it, so
it's a one-line change if that ever needs to be different.

**Private key via environment variable** — the RPC URL is public so it's
just sitting in `hardhat.config.ts`, but the private key is read from
`process.env.PRIVATE_KEY` at deploy time and never written to a file that
gets committed.

## 3. Deployment

- Network: Sepolia Testnet
- Contract address: <fill in after deploying>
- Block explorer link: <fill in>

## 4. How to test it

```bash
cd Hardhat
npm install
npx hardhat test
```

Expected output:

```
SWKToken
  ✔ should transfer tokens between accounts
  ✔ should revert transfer if balance is insufficient
  ✔ should revert mint if caller is not owner
  ✔ should allow owner to mint tokens

4 passing
```

Test breakdown:

1. **transfer between accounts** — owner sends 100 SWK to a second account,
   its balance is checked afterward.
2. **revert on insufficient balance** — an account with 0 SWK tries to send
   100 SWK, should revert with `ERC20InsufficientBalance`. Expected failure.
3. **revert mint from non-owner** — a non-owner account calls `mint`, should
   revert with `OwnableUnauthorizedAccount`. Expected failure.
4. **owner can mint** — owner mints to a second account, balance confirmed.

To deploy to Sepolia:

```bash
$env:PRIVATE_KEY="your-key-here"   # PowerShell
npm run deploy:sepolia
```

## 5. What I found difficult

Getting the environment variable to actually reach Hardhat took a couple of
tries — easy to set it in one terminal session and then run the deploy
command in a different one where it's not set.

## 6. Acknowledgements

- OpenZeppelin Contracts v5 — ERC20, ERC20Burnable, Ownable
- SWKToken contract carried over from Session 05
- Hardhat's default project template as the base structure
- This project was set up and documented by me while working through the assignment.
