# AI Policy

AI/Agents are welcome. I strongly encourage those using AI tools to work with the provided *CLAUDE.MD* and *AGENTS.MD* to avoid common agentic issues and to ensure quality PR's.

# Important
Anyone wanting to contribute *MUST* read the following and adhere to the steps
outlined, in order to not violate any copyright.

This decompile is a [clean room design](https://en.wikipedia.org/wiki/Clean_room_design).
It *MUST NOT* incorporate any code owned by Konami or other third parties.

In order to achieve this, all code has to be written completely fresh, without
reference to any third party code, no matter if leaked or not.

Derived from this there is the following requirement for contributors:

- Contributors or their agents *MUST NOT* study or refer to any code owned by Konami or other
  third parties.

# Submitting a Change
1. Clone this repository and follow the setup instructions if you haven't already
2. For any set of changes you want to submit, create a branch off of `main`
3. When ready to submit your changes, make sure the ROM still compiles (`make`)
4. If the ROM compiles, make sure the ROM still matches the base ROM (`make check`)
   - Recommended: run `./check_roms.sh` to build and check ROMs for every supported region.
5. Open a PR on GitHub with a description that summarizes your changes
