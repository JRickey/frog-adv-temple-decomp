# Status-mask constant propagation

Run `python3 docs/experiments/status-mask-gcse/verify.py` from the repository. The test checks the installed compiler's SHA256, compiles the preserved two-function input in a temporary directory, and checks the distinct emitted mask operations. It leaves ROM build artifacts untouched.

With stock old_agbcc, `bitmask` loads `0x7fff`; the diagnostic `exact` control retains `0x8000` and subtracts one. The latter uses a constant-return narrow inline solely as an experimental control. It is not an acceptable proposed game helper or a matched game function.

The full `sub_08028858` candidate's initial CSE retains a PLUS of the mask and -1 (insns 88 and 429). GCSE replaces the known mask register with 32768 and folds the decrement to 32767 before allocation. In the control, the narrow return produces a SUBREG destination, which is excluded from GCSE's register-set hash. The decrement survives; later combine removes the redundant extension. A normal generic bit constructor does not create that protection.

This explains why ordinary local-variable and block changes failed. It does not prove that matching readable C is impossible. The next discriminating evidence would be a legitimate sibling helper with the same narrow producer, or a control-flow difference affecting constant availability. The full immutable source, RTL dumps and fingerprints remain in ignored `nonmatchings/large-five/sub_08028858/diagnosis/`. No compiler binary or ROM flag was changed.
