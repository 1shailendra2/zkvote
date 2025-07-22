# 🗳️ zkVoting

A simple zero-knowledge voting system built with Circom.

Voters prove they are part of a valid Merkle tree of voter IDs without revealing their identity. Each vote is private, unique (via nullifier), and verifiable.

### 💡 How it works
- User provides:
  - `leaf`: hashed voter ID
  - `pathElements` & `pathIndices`: Merkle proof
  - `voteOption`: their vote
  - `nullifier`: to prevent double voting
- Circuit:
  - Verifies Merkle proof
  - Hashes nullifier with root to generate `nullifierHash`

### 📁 Files
- `vote.circom` — main circuit
- `MerkleProof20.circom` — Merkle proof logic
- `poseidon.circom` — zk-friendly hash

### 🛠️ Commands
```bash
circom vote.circom --r1cs --wasm -o build/
