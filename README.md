# NFT whitelisting project

# Requirement

To Create upgradable contract for EIP 1155 and Implement NFT whitelisting

# Implementation

1. Fist create a upgradable contract using openzepplin libraries. 
2. For proxy pattern, we can get reference from this doc https://blog.logrocket.com/using-uups-proxy-pattern-upgrade-smart-contracts/ 
3. we used UUPS because it's most gas efficient proxy pattern.
4. For whitelisting we used merkle tree validation logic which is explained here https://medium.com/crypto-0-nite/merkle-proofs-explained-6dd429623dc5
5. We created a merkle root after building a merkle tree from all the whitelisted addresses and then deploy the contract. After that if any of the whitelisted addresses is used, then merkle proof gives the VALID PROOF otherwise it gives the INVALID PROOF.






