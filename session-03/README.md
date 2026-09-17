# Session 03 — Make Your Contract Observable & Controlled

**Name:** Sathwik PK
**Enrolment ID:** AU24UG035
**Date submitted:** 17/09/2026

## 1. What this contract does
This contract extends the Session 2 Student Record Contract by making it
observable and access-controlled. It emits events whenever a student is
registered or their status is updated, restricts registration and status
updates to the contract owner using a modifier, and exposes its read function
through an `IStudentRecord` interface.

## 2. Design decisions
I added an `onlyOwner` modifier instead of repeating the same `require`
check inside every restricted function, since a modifier keeps the access
rule in one place and makes each function's intent clear at a glance. I set
`owner` in the constructor to whoever deploys the contract, rather than a
hardcoded address, so the contract works correctly no matter who deploys it.
I emitted an event after every state change (`StudentRegistered`,
`StatusUpdated`) so registrations and status changes can be tracked from
outside the contract without re-reading storage. I pulled `getStudent` and
the `Status` enum into an `IStudentRecord` interface so the read-only part of
the contract has a clearly defined, separate "public promise" from the
owner-only write functions.

## 3. Deployment
- Network: Remix VM / Sepolia   <!-- delete whichever doesn't apply -->
- Contract address: 0x...
- Transaction hash: 0x...
- Block explorer link: <only for a public testnet deployment>

## 4. How to test it
1. Deploy from Account 1 → Account 1 becomes `owner`
2. `registerStudent(Account 2, "Asha", 20)` from Account 1 (owner) → succeeds,
   `StudentRegistered` event fires
3. `registerStudent(Account 3, "Ravi", 21)` from Account 2 (not owner) →
   reverts with "Only the owner can do this"
4. `updateStatus(Account 2, 2)` from Account 1 (owner) → succeeds (2 =
   Graduated), `StatusUpdated` event fires
5. `getStudent(Account 2)` → returns `("Asha", 20, 2)` — callable by anyone,
   not just the owner

## 5. What I found difficult
Understanding why the `Status` enum had to be declared inside the interface
rather than the main contract, and that `StudentRecord` inherits it through
`is IStudentRecord` instead of redefining it, took a bit of re-reading.
Working out that the modifier's `_;` marks exactly where the rest of the
function body runs was also not obvious at first.

## 6. Acknowledgements
Used Claude to explain events, modifiers, and interfaces with analogies, and
to review the contract structure before writing and testing it myself.