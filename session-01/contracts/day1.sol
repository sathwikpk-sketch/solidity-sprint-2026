// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StorageContract {
    string private message;
    address private lastEditor;
   

    // Read the current message
    function getMessage() public view returns (string memory) {
        return message;
    }

    // Read who last updated it
    function getLastEditor() public view returns (address) {
        return lastEditor;
    }

    // Update the message, and record who did it
    function updateMessage(string memory _newMessage) public {
        message = _newMessage;
        lastEditor = msg.sender;
    }
}