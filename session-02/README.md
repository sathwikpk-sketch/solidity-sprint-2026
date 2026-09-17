# Session 02 — Build a Student Record Contract

**Name:** Sathwik PK
**Enrolment ID:** AU24UG035
**Date submitted:** 16/09/2026

## 1. What this contract does
This contract manages student records on-chain. A wallet address can register
itself once with a name and age, update its own status (Active, Inactive,
Graduated), and anyone can look up a stored record by address. It blocks a
second registration from the same address and blocks lookups for addresses
that never registered.

## 2. Design decisions
I used a `struct` to bundle each student's name, age, status, and registration
flag together, since these fields always belong to one person. I used an
`enum` for status instead of a plain number or string so only three valid
values can ever be stored. I used a `mapping(address => Student)` because
wallet addresses are unique, making lookup direct with no need to loop through
a list. I added an `isRegistered` flag rather than checking a default value,
because a default `age` of 0 or empty `name` could be mistaken for "no record"
otherwise. I used `require` with string messages rather than custom errors,
since it's clearer to read while learning.

## 3. Deployment
- Contract address: 0x...
- Transaction hash: 0x...

## 4. How to test it
1. `registerStudent("Asha", 20)` from Account 1 → succeeds
2. `registerStudent("Asha", 20)` from Account 1 again → reverts with
   "Student already registered"
3. `updateStatus(2)` from Account 1 → succeeds (2 = Graduated)
4. `getStudent(Account 1)` → returns `("Asha", 20, 2)`
5. `getStudent(Account 2)` (an address that never registered) → reverts with
   "No record found for this address"

## 5. What I found difficult
Deciding how to detect "no record exists" took a couple of tries before I
settled on an `isRegistered` flag instead of relying on default values.

## 6. Acknowledgements
Used Claude to review the contract structure and explain structs, enums, and
mappings before writing and testing it myself.
