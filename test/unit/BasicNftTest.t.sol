// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test {
    BasicNft basicNft;
    DeployBasicNft deployBasicNft;

    address TEST_USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTTING_BALANCE = 10 ether;
    uint8 constant GAS_PRICE = 1;
    string constant TOKEN_URI =
        "https://ipfs.io/ipfs/QmTfABTffcgvqKjUv1pK4LULLykwWGPgEJdm167yRwzQwg?filename=shiba-inu.json";

    function setUp() external {
        deployBasicNft = new DeployBasicNft();
        basicNft = deployBasicNft.run();
        vm.deal(TEST_USER, STARTTING_BALANCE);
    }

    function testName() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testSymbol() public view {
        string memory expecteSymbol = "DOG";
        string memory actualSymbol = basicNft.symbol();
        assert(keccak256(abi.encodePacked(expecteSymbol)) == keccak256(abi.encodePacked(actualSymbol)));
    }

    function testCanMintAndHasBalance() public {
        uint256 beforeMintTokenCounter = basicNft.getTokenCounter();
        uint256 afterMintTokenCounter;

        vm.prank(TEST_USER);
        basicNft.mintNft(TOKEN_URI);
        afterMintTokenCounter = basicNft.getTokenCounter();

        assert(basicNft.balanceOf(TEST_USER) == 1);
        assert(keccak256(abi.encodePacked(basicNft.tokenURI(0))) == keccak256(abi.encodePacked(TOKEN_URI)));
        assert(beforeMintTokenCounter + 1 == afterMintTokenCounter);
    }
}
