#!/usr/bin/env python3
"""Reproduce the mask constant-propagation control without touching ROM artifacts."""
import hashlib
from pathlib import Path
import shutil
import subprocess
import tempfile

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
COMPILER = ROOT / 'tools/agbcc/bin/old_agbcc'
EXPECTED = '5041c5dd57875aad111b8e239bac9dedfda95729430b65aa271fd54400c08dcf'
assert hashlib.sha256(COMPILER.read_bytes()).hexdigest() == EXPECTED, 'compiler identity changed'
with tempfile.TemporaryDirectory(prefix='frog-mask-gcse-') as directory:
    work = Path(directory)
    shutil.copyfile(HERE / 'probe.c', work / 'probe.c')
    subprocess.run([str(COMPILER), '-O2', '-mthumb-interwork', '-fhex-asm', '-da',
                    '-o', 'probe.s', 'probe.c'], cwd=work, check=True)
    assembly = (work / 'probe.s').read_text()
    ordinary, narrow_control = assembly.split('exact:', 1)
    assert '.word\t0x7fff' in ordinary, 'ordinary bit builder no longer folds decrement'
    assert '.word\t0x7fff' not in narrow_control, 'narrow control now folds decrement'
    assert '\tsub\tr1, r1, #0x1' in narrow_control, 'narrow control no longer preserves mask'
print('PASS: ordinary bit builder folds mask decrement; diagnostic narrow control preserves it')
