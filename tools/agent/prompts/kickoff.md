<!--
  Adapted from Mizuchi (https://github.com/macabeus/mizuchi),
  mizuchi.example.yaml :: plugins.claude-runner.kickoffMessage
  Copyright (c) 2025 macabeus, MIT License. See ATTRIBUTION.md.
-->

Decompile the function described in the system prompt. Read the existing code in the destination C file before writing, run `tools/agent/compile_and_view_assembly.py <FunctionName>` after every edit, and only stop when `diff_count == 0` OR you've exhausted reasonable attempts (in which case revert your changes to that file and report what you tried).
