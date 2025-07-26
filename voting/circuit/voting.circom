pragma circom 2.0.0;
include "circomlib/circuits/poseidon.circom";
include "circomlib/circuits/MerkleProof20.circom";


template Vote() {
    signal input voterID;               
    signal input pathElements[20];       
    signal input pathIndices[20];      
    signal input voteOption;             
    signal input nullifier;              

    signal output root;
    signal output vote;
    signal output nullifierHash;

    component idHasher = Poseidon(1);
    idHasher.inputs[0] <== voterID;
    signal leaf;
    leaf <== idHasher.out;

    component mp = MerkleProof20();
    mp.leaf <== leaf;
    for (var i = 0; i < 20; i++) {
        mp.pathElements[i] <== pathElements[i];
        mp.pathIndices[i] <== pathIndices[i];
    }

    root <== mp.root;
    vote <== voteOption;

    component hasher = Poseidon(2);
    hasher.inputs[0] <== nullifier;
    hasher.inputs[1] <== root;

    nullifierHash <== hasher.out;
}

component main = Vote();
