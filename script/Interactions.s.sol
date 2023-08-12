// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

import {Script} from "forge-std/Script.sol";
import {DeployBasicNft} from "./DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployStarNft} from "./DeployStarNft.s.sol";
import {StarNft} from "../../src/StarNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintPuppyNft is Script {
    string private constant TOKEN_URI =
        "ipfs://bafybeicpba3h4herwwg2ofcbovzmez4nyilb42ct3oiiox7y25dxhlfx44/?filename=shiba-inu.json";

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

contract MintStarNft is Script {
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("StarNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployed);
    }

    function mintNftOnContract(address mostRecentlyDeployed) public {
        vm.startBroadcast();
        StarNft(mostRecentlyDeployed).mintNft();
        vm.stopBroadcast();
    }
}
