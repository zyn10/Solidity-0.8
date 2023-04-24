pragma solidity ^0.8.0;

contract MultiSigWallet {
    uint256 public nonce;
    mapping(address => bool) public isOwner;
    address[] public owners;
    uint256 public threshold;

    constructor(address[] memory _owners, uint256 _threshold) {
        require(_threshold > 0 && _owners.length >= _threshold, "Invalid parameters");
        for (uint256 i = 0; i < _owners.length; i++) {
            require(!isOwner[_owners[i]], "Duplicate owner");
            isOwner[_owners[i]] = true;
            owners.push(_owners[i]);
        }
        threshold = _threshold;
    }

    function execute(address to, uint256 value, bytes memory data, uint8[] memory sigV, bytes32[] memory sigR, bytes32[] memory sigS) public {
        require(sigR.length >= threshold, "Not enough signatures provided");

        bytes32 txHash = getTransactionHash(to, value, data, nonce);
        address lastSigner = address(0);
        uint256 validSignatures = 0;

        for (uint256 i = 0; i < sigR.length; i++) {
            address signer = ecrecover(txHash, sigV[i], sigR[i], sigS[i]);
            require(isOwner[signer], "Invalid signer");

            require(signer > lastSigner, "Signers must be unique and in ascending order");
            lastSigner = signer;

            validSignatures++;
            if (validSignatures == threshold) {
                break;
            }
        }

        require(validSignatures == threshold, "Not enough valid signatures provided");

        nonce++;
        (bool success, ) = to.call{value: value}(data);
        require(success, "Execution failed");
    }  

    function getTransactionHash(address to, uint256 value, bytes memory data, uint256 nonce) private pure returns (bytes32) {
        return keccak256(abi.encodePacked(to, value, data, nonce));
    }
}
