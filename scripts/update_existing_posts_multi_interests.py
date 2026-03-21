#!/usr/bin/env python3
"""См. backend/scripts/update_existing_posts_multi_interests.py"""

from __future__ import annotations

import runpy
from pathlib import Path

_target = (
    Path(__file__).resolve().parent.parent
    / "backend"
    / "scripts"
    / "update_existing_posts_multi_interests.py"
)
if not _target.is_file():
    raise SystemExit(f"Не найден скрипт: {_target}")

runpy.run_path(str(_target), run_name="__main__")
