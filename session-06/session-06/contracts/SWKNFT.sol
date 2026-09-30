// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

// ERC-721 collection for the Session 06 assignment.
// Owner mints NFTs one at a time, each with its own metadata URI on IPFS.
contract SWKNFT is ERC721URIStorage, Ownable {

    uint256 public nextTokenId;

    constructor() ERC721("Sathwik Collection", "SWKN") Ownable(msg.sender) {
        nextTokenId = 1;
    }

    function mint(address to, string memory uri) external onlyOwner returns (uint256) {
        uint256 tokenId = nextTokenId;
        nextTokenId++;

        // set state before the external call in _safeMint
        _setTokenURI(tokenId, uri);
        _safeMint(to, tokenId);

        return tokenId;
    }

    function totalMinted() external view returns (uint256) {
        return nextTokenId - 1;
    }
}
