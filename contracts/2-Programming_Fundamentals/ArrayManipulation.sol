// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Arrays {
    // sorted groupings
    bytes public dummyArray = "abc";

    function getLength() public view returns (uint256) {
        return dummyArray.length;
    }

    // function pushElement(bytes memory char) public {
    //     dummyArray.push(char);
    // }

    function pushElement(bytes memory myBytes) public {
        require(myBytes.length > 0, "Invalid input: empty bytes array");
        dummyArray.push(myBytes[0]);
    }
}
