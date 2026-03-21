#!/usr/bin/env python3
"""
Обёртка: реализация лежит в backend/scripts/seed_demo_cards_and_interests.py

Из корня репозитория:
  python3 scripts/seed_demo_cards_and_interests.py
"""

from __future__ import annotations

import runpy
from pathlib import Path

_target = (
    Path(__file__).resolve().parent.parent
    / "backend"
    / "scripts"
    / "seed_demo_cards_and_interests.py"
)
if not _target.is_file():
    raise SystemExit(f"Не найден скрипт: {_target}")

runpy.run_path(str(_target), run_name="__main__")
