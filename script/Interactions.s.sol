// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

import {Script} from "forge-std/Script.sol";
import {DeployBasicNft} from "./DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintNft is Script {
    string private constant TOKEN_URI =
        "https://ipfs.io/ipfs/QmTfABTffcgvqKjUv1pK4LULLykwWGPgEJdm167yRwzQwg?filename=shiba-inu.json";

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("BasicNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        BasicNft(mostRecentlyDeployed).mintNft(TOKEN_URI);
        vm.stopBroadcast();
    }
}
