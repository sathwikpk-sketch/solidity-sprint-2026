# Session 05 — Build & Deploy Your Own Token

**Name:** Sathwik PK
**Enrolment ID:** AU24UG035
**Date submitted:** 22/09/2026

## 1. What this contract does

This is a custom ERC-20 token, Sathwik Token (SWK), built on top of
OpenZeppelin's ERC20 and ERC20Burnable contracts. Whoever deploys the
contract gets the full initial supply. After that, only the owner can mint
more tokens, but anyone holding SWK can burn their own balance.

## 2. Design decisions

**Used OpenZeppelin instead of writing ERC-20 from scratch** — no reason to
reinvent transfer/approve/allowance logic that's already been audited.
`ERC20Burnable` gives `burn()` and `burnFrom()` for free.

**`onlyOwner` from OZ's Ownable** — didn't see the point in writing a custom
modifier when `mint` is the only function that needs gating.

**Multiplying by `10 ** decimals()`** — ERC-20 balances are stored in the
smallest unit, so passing `1000` as supply without this would mint a
fraction of one token instead of 1000 whole tokens. Applied it in both the
constructor and `mint`.

**Emitting `TokensMinted` on mint** — OZ's base `_mint` doesn't emit
anything beyond the standard `Transfer` event, so I added one to make new
supply easy to track off-chain.

## 3. Deployment

- Network: Sepolia Testnet
- Contract address: <fill in after deploying>
- Transaction hash: <fill in>
- Block explorer link: <fill in>

## 4. How to test it

In Remix (Remix VM, before touching Sepolia):

1. Deploy with `initialSupply = 1000`. The deploying account should show
   1000 SWK.
2. `totalSupply()` → `1000000000000000000000` (1000 × 10^18).
3. `balanceOf(<your account>)` → same number.
4. Switch to a second account and call `mint(<any address>, 100)` → should
   revert (not the owner). Expected failure.
5. Switch back to the owner account, call `mint(<second account>, 100)` →
   should succeed, `balanceOf` on that account shows `100000000000000000000`.
6. From the second account, call `burn(50)` → balance drops by 50 tokens
   and `totalSupply()` goes down too.

On Sepolia:

7. Repeat the deploy + mint flow with real transactions, note the hashes
   above.
8. Send some SWK to another wallet (classmate, second MetaMask account,
   whatever) and record that transaction hash too.

## 5. What I found difficult

Getting the decimals right took a second — it's easy to forget the
`10 ** decimals()` multiplier and end up minting almost nothing. Worth
double-checking `balanceOf` after every mint in Remix before trusting the
numbers.

## 6. Acknowledgements

- OpenZeppelin Contracts v5 — ERC20, ERC20Burnable, Ownable
- This token was built and documented by me based on the assignment brief.
