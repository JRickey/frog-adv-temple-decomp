# Missing extraction inputs after integration

Run `python3 docs/experiments/missing-extracted-data/verify.py`. The reproduction uses a temporary C input and the custom preprocessor; it demonstrates that an absent INCBIN file produces a warning and an empty initializer. This behavior is deliberate because this pass runs before C conditional preprocessing. It should not be changed to unconditional failure without addressing excluded branches.

During integration of `f0560022` as `f3dc4a66`, main had not regenerated four new raw gaps after the database split. A clean compile succeeded but `make check` rejected 1101 differing bytes in the data region, starting at ROM offset `0x313548` and ending at `0x314067`. Function bytes were unchanged. Running extraction and repeating the clean build restored the expected whole-ROM SHA1.

The durable correction is in `docs/matching-workflow.md`: run `make extract` after changing or integrating `database.json`, before the clean build. The whole-ROM gate remains mandatory; successful compilation or individual function oracles cannot validate surrounding data.
