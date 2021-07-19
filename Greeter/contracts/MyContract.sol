//SPDX-License-Identifier: Unlicense
pragma solidity 0.8.5;

contract MyContract {
    string public hello;

    constructor()
    {
        hello = "Hello World!";
    }

    function setHello(string memory _hello) public {
        hello = _hello;
    }
}