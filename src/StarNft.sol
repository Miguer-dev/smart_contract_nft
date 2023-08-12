// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract StarNft is ERC721, Ownable {
    error ERC721Metadata__URI_QueryFor_NonExistentToken();
    error StarNft__CantFlipMoodIfNotOwner();

    uint256 private s_tokenCounter;

    event CreatedNFT(uint256 indexed tokenId);

    constructor() ERC721("Star NFT", "SN") {
        s_tokenCounter = 0;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter = s_tokenCounter + 1;
        emit CreatedNFT(s_tokenCounter);
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        if (!_exists(tokenId)) {
            revert ERC721Metadata__URI_QueryFor_NonExistentToken();
        }

        string memory primary;
        string memory secundary;
        uint256 number = block.number;

        if (number % 6 == 0) {
            primary = "blue";
        } else if (number % 7 == 0) {
            primary = "green";
        } else if (number % 8 == 0) {
            primary = "yellow";
        } else if (number % 9 == 0) {
            primary = "red";
        } else if (number % 10 == 0) {
            primary = "orange";
        } else if (number % 11 == 0) {
            primary = "purple";
        } else if (number % 12 == 0) {
            primary = "silver";
        } else if (number % 13 == 0) {
            primary = "gold";
        } else {
            primary = "black";
        }

        if (number % 2 == 0) {
            secundary = "blue";
        } else if (number % 3 == 0) {
            secundary = "green";
        } else if (number % 5 == 0) {
            secundary = "red";
        } else {
            secundary = "gray";
        }

        string memory image1 =
            '<svg viewBox="0 0 200 200" width="400" height="400" xmlns="http://www.w3.org/2000/svg"> <polygon points="100,10 40,198 190,78 10,78 160,198" style="fill:';
        string memory image2 = ";stroke:";
        string memory image3 =
            ';stroke-width:5;fill-rule:evenodd;"/> Sorry, your browser does not support inline SVG.</svg>';
        string memory imageSvg = string.concat(image1, primary, image2, secundary, image3);

        string memory imageURI = _svgToImageURI(imageSvg);

        return string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            name(), // You can add whatever name here
                            '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                            '"attributes": [{"trait_type": "star", "value": 100}], "image":"',
                            imageURI,
                            '"}'
                        )
                    )
                )
            )
        );
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function _svgToImageURI(string memory svg) internal pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }

    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
}
