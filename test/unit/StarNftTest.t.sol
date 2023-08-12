// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployStarNft} from "../../script/DeployStarNft.s.sol";
import {StarNft} from "../../src/StarNft.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
//import {MintBasicNft} from "../script/Interactions.s.sol";

contract MoodNftTest is StdCheats, Test {
    string constant NFT_NAME = "Star NFT";
    string constant NFT_SYMBOL = "SN";
    StarNft public starNft;
    DeployStarNft public deployer;

    address public constant USER = address(1);

    function setUp() public {
        deployer = new DeployStarNft();
        starNft = deployer.run();
    }

    function testInitializedCorrectly() public view {
        assert(keccak256(abi.encodePacked(starNft.name())) == keccak256(abi.encodePacked((NFT_NAME))));
        assert(keccak256(abi.encodePacked(starNft.symbol())) == keccak256(abi.encodePacked((NFT_SYMBOL))));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        starNft.mintNft();
        console.log(starNft.tokenURI(0));

        assert(starNft.balanceOf(USER) == 1);
    }
}
