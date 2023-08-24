// SPDX-License-Identifier: MIT
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract NftWhitelistContract is Initializable, UUPSUpgradeable, ERC1155Upgradeable, OwnableUpgradeable {

    mapping(uint256 => string) public tokenURI;
    uint256 public tokenId;

    /**
    * @notice Merkle root hash for whitelist addresses
    */
    bytes32 public merkleRoot;

    constructor() {
        _disableInitializers();
    }

    function initialize() initializer public{
        __ERC1155_init("");
        __Ownable_init();
        __UUPSUpgradeable_init();
    }


    /**
     * @notice set merkle root hash
     */
    function setMerkleRoot(bytes32 merkleRootHash) external onlyOwner
    {
        merkleRoot = merkleRootHash;
    }

    /**
     * @notice Verify merkle proof of the address
     */
    function verifyAddress(bytes32[] calldata _merkleProof) private view returns (bool) {
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender));
        return MerkleProof.verify(_merkleProof, merkleRoot, leaf);
    }

    /**
     * @notice Mint function
     */
    function mint(bytes32[] calldata _merkleProof, uint256 amount, string memory _tokenURI, bytes memory data)
        public
        returns(uint256)
    {
        require(verifyAddress(_merkleProof), "INVALID_PROOF");
        uint256 _tokenId = tokenId;
        tokenURI[_tokenId] = _tokenURI;
        _mint(msg.sender, _tokenId, amount, data);
        tokenId++;
        return _tokenId;
    }

     /**
     * @notice Get the token URI
     */
    function uri(bytes32[] calldata _merkleProof, uint256 _tokenId) public view returns(string memory) {
        require(verifyAddress(_merkleProof), "INVALID_PROOF");
	    return tokenURI[_tokenId];
    }



    function _authorizeUpgrade(address _newImplementation) internal override onlyOwner {}
}

