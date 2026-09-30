# Session 01 — Simple Storage Contract

**Name:** Sathwik PK
**Enrolment ID:** AU24UG035
**Date submitted:** 15/09/2026

## 1. What this contract does

This contract stores a single text message on-chain along with the address of
the account that last updated it. It exposes two read-only functions to
retrieve the current message and the last editor's address, and one write
function that lets any account overwrite the message, automatically
recording the caller as the new last editor.

## 2. Design decisions

The message is stored as a `string` and the last editor as an `address`,
both declared `private` since they are only meant to be accessed through the
dedicated getter functions rather than directly. Using two separate state
variables keeps the contract simple and readable at this scale; a `struct`
would be unnecessary for just two loosely related fields. The
`updateMessage` function deliberately has no access restriction, because the
assignment describes the “last person who updated it,” which implies that
any account should be able to write to it.

## 3. Deployment

- Network: Remix VM
- Contract address: 0x...
- Transaction hash: 0x...

## 4. How to test it

1. Deploy the contract — `getMessage()` returns an empty string and
   `getLastEditor()` returns the zero address by default.
2. Call `updateMessage("Hello Blockchain")` from Account 1 → succeeds.
3. Call `getMessage()` → returns `"Hello Blockchain"`.
4. Call `getLastEditor()` → returns Account 1's address.
5. Switch to Account 2 in Remix and call `updateMessage("Second update")` →
   succeeds, since there is no restriction on who can write.
6. Call `getMessage()` → returns `"Second update"`.
7. Call `getLastEditor()` → returns Account 2's address, confirming the
   last editor updates correctly on each transaction.

## 5. What I found difficult

Understanding how `msg.sender` flows into state updates was the key learning
point here. It was also useful to think about why the last editor is stored
separately from the message and why the contract does not enforce any access
control in this design.

## 6. Acknowledgements

No external code or libraries were used; the contract and README were written
by me based on the assignment brief.
