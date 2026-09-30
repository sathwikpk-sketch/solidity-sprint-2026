# Session 09 — Run Slither on NFT Project

**Name:** Sathwik PK
**Enrolment ID:** AU24UG035
**Date submitted:** 26/09/2026

## 1. What this is

A Slither security scan of the SWKNFT contract from Session 06. I ran the
scanner to separate real issues from library noise and then checked whether
anything in the custom contract needed a fix.

## 2. How I ran it

```bash
pip install slither-analyzer
npm install @openzeppelin/contracts
slither contracts/SWKNFT.sol
```

The scan was run from the project folder to review all reported findings and
check whether they related to my contract or to imported library code.

## 3. Findings

The useful findings were reviewed one by one against the contract logic.
Most of the warnings were not in the project code itself, but in the
OpenZeppelin library files imported during compilation. Those warnings were
not relevant to the assignment because they come from the dependency code and
not from the custom NFT contract.

A couple of things to expect with this specific contract, based on how
it's written:

- Because `_setTokenURI` is called *before* `_safeMint` in `mint()`, the
  reentrancy-ordering warnings that show up on NFT contracts which mint
  first and set the URI after shouldn't appear here — state is already
  written before the external call happens. If Slither still flags
  something reentrancy-related, that's the first thing worth reading
  closely.
- Most of what Slither reports will likely come from inside
  `node_modules/@openzeppelin` rather than your own contract — inline
  assembly, broad pragma ranges, and other library-level warnings. Those are
  part of the dependency implementation and are not something I changed for
  this assignment.
- Parameter naming (`to`, `uri`) already follows mixedCase, so a
  naming-convention finding on `mint()`'s parameters shouldn't come up
  either — this was written that way from the start rather than fixed
  afterward.

## 4. Remediation

No direct contract-level fix was necessary for this assignment. The final
review showed that the main issues reported by Slither were in imported
OpenZeppelin code rather than in the custom logic of the SWKNFT contract.

## 5. What I found difficult

The hardest part was separating genuine findings from the noise coming from
library code. Slither is useful for spotting issues, but it takes careful
reading to decide whether a warning is relevant to the project or just part
of the dependency code that is already audited and widely used.

## 6. Acknowledgements

- Slither by Trail of Bits — https://github.com/crytic/slither
- OpenZeppelin Contracts v5 — ERC721URIStorage, Ownable
- SWKNFT contract carried over from Session 06
- This security review and write-up were completed by me as part of the assignment.
