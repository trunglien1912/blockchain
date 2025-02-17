// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.5.16;

library Utils {

    function equal(string memory _a, string memory _b) internal pure returns (bool)  {
        return keccak256(abi.encodePacked(_a)) == keccak256(abi.encodePacked(_b));
    }

}
