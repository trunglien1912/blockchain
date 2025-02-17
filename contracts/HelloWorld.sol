pragma solidity ^0.5.16;

contract HelloWorld {
   string private message = "Hello World!";

    function getMessage() public view returns (string memory) {
        return message;
    }
}
