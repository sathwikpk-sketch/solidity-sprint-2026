# Session 01 — Simple Storage Contract

**Name:** <SATHWIK PK>
**Enrolment ID:** <AU24UG035>
**Date submitted:** <15/09/2026>

## 1. What this contract does

This contract stores a single text message on-chain along with the address of
the account that last updated it. It exposes two read-only functions to
retrieve the current message and the last editor's address, and one write
function that lets any account overwrite the message, automatically
recording the caller as the new last editor.

## 2. Design decisions

The message is stored as a `string` and the last editor as an `address`,
both declared `private` since they're only meant to be accessed through the
dedicated getter functions rather than directly. Using two separate state
variables (instead of, say, a `struct`) keeps the contract simple and
readable for this scale of data — a struct would be overkill for just two
loosely related fields. `updateMessage` deliberately has no access
restriction (no `onlyOwner` modifier), since the assignment describes any
"last person who updated it," implying any account should be able to write
to it.

## 3. Deployment

- Network: Remix VM 
- Contract address: 0x...
- Transaction hash: 0x...

## 4. How to test it

1. Deploy the contract — `getMessage()` returns `""` and `getLastEditor()`
   returns `0x0000000000000000000000000000000000000000` by default.
2. Call `updateMessage("Hello Blockchain")` from Account 1 → succeeds.
3. Call `getMessage()` → returns `"Hello Blockchain"`.
4. Call `getLastEditor()` → returns Account 1's address.
5. Switch to Account 2 in Remix and call `updateMessage("Second update")` →
   succeeds (no restriction on who can write).
6. Call `getMessage()` → returns `"Second update"`.
7. Call `getLastEditor()` → returns Account 2's address, confirming the
   last editor updates correctly with each transaction.

*(This contract has no functions that are designed to revert, since there's
no access control or validation required by the brief — if you'd like a
failing test case for the marking rubric, consider adding a check such as
requiring the new message to be non-empty, and document the revert here.)*

## 5. What I found difficult

<Be honest — one or two things you found tricky, e.g. understanding
`msg.sender`, deciding on visibility for state variables, deploying to
Sepolia, etc.>

## 6. Acknowledgements

Used Claude (Anthropic AI assistant) to review my contract logic and help
structure this README. No external code or libraries used — the contract
is written by me.
