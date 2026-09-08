#!/usr/bin/env python3
"""Document why database integrations require make extract before compilation."""
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[3]
with tempfile.TemporaryDirectory(prefix='frog-missing-incbin-') as directory:
    work = Path(directory)
    source = work / 'probe.c'
    source.write_text('const unsigned int data[1] = INCBIN_U32("absent.bin");\n')
    result = subprocess.run([str(ROOT / 'tools/preproc/preproc'), str(source),
                             str(ROOT / 'charmap.txt')], cwd=work,
                            capture_output=True, text=True, check=True)
    assert 'Failed to open' in result.stderr
    assert '{}' in result.stdout.replace(' ', '').replace('\n', '')
print('PASS: missing INCBIN warns and produces an empty initializer; extraction is required')
