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

    function setUp() external {
        deployBasicNft = new DeployBasicNft();
        basicNft = deployBasicNft.run();
        vm.deal(TEST_USER, STARTTING_BALANCE);      
    }

}
