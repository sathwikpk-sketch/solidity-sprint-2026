# Session 06 — Build & Deploy Your Own NFT Contract

**Name:** Sathwik PK
**Enrolment ID:** AU24UG035
**Date submitted:** 23/09/2026

## 1. What this contract does

This is an ERC-721 collection, Sathwik Collection (SWKN). The owner mints
tokens one by one, each with its own tokenURI pointing at metadata on IPFS.
Token IDs start at 1 and go up. Anyone can look up who owns a given token.

## 2. Design decisions

**ERC721URIStorage over plain ERC721** — needed a separate URI per token,
which is exactly what the URIStorage extension gives you (a mapping from
tokenId to URI string).

**Token IDs start at 1** — kept a `nextTokenId` counter starting at 1 so
there's never a token with ID 0 floating around.

**Set the URI before calling `_safeMint`** — `_safeMint` makes an external
call to the recipient if it's a contract (the `onERC721Received` check), so
I write the token's metadata state first and mint last. That way there's no
window where a re-entrant call could see a minted token with no URI set
yet. This is the Checks-Effects-Interactions pattern applied to minting.

**`_safeMint` instead of `_mint`** — protects against sending an NFT to a
contract address that has no way to handle receiving it.

**Metadata on IPFS, not on-chain** — storing strings directly on Ethereum
is expensive, IPFS is cheap and content-addressed so the link can't be
silently swapped for something else later.

## 3. Deployment

- Network: Sepolia Testnet
- Contract address: <fill in after deploying>
- Transaction hash: <fill in>
- Block explorer link: <fill in>

## 4. How to test it

Deploy from the owner account.

1. `mint(<your address>, "ipfs://.../nft1.json")` → returns `1`
2. `mint(<your address>, "ipfs://.../nft2.json")` → returns `2`
3. `totalMinted()` → `2`
4. `ownerOf(1)` → your address
5. `tokenURI(1)` → the URI you passed in for token 1
6. `tokenURI(2)` → a different URI than token 1
7. Switch to a second account, call `mint(...)` → reverts, not the owner
8. `ownerOf(99)` → reverts, token doesn't exist

For the metadata itself: upload the image to IPFS first, get its CID, put
that CID inside a JSON file (name, description, image field), then upload
the JSON and use its CID/URI in `mint`.

## 5. What I found difficult

Keeping the image upload and the JSON upload in the right order — the JSON
metadata has to reference the image's CID, so the image needs to go up to
IPFS first before you can even write the JSON.

## 6. Acknowledgements

- OpenZeppelin Contracts v5 — ERC721URIStorage, Ownable
- Pinata for IPFS uploads
- This NFT contract was built and documented by me based on the assignment brief.
