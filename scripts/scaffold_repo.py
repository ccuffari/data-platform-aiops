#!/usr/bin/env python3
"""
Scaffold idempotente per il repository data-platform-aiops.

Uso:
    python scripts/scaffold_repo.py --root .
    python scripts/scaffold_repo.py --root . --force

Comportamento:
    - Crea tutte le directory mancanti
    - Aggiunge .gitkeep nelle directory vuote
    - Crea file placeholder (main.tf, variables.tf, outputs.tf, README.md)
      solo se non esistono, a meno che --force sia specificato
"""
from __future__ import annotations

import argparse
import sys
from pathlib import Path

DIRECTORIES = [
    "infra/modules/network",
    "infra/modules/monitoring",
    "infra/modules/keyvault",
    "infra/modules/storage",
    "infra/modules/sql",
    "infra/modules/data-factory",
    "infra/modules/function-aiops",
    "infra/modules/logic-apps",
    "infra/modules/deepseek-proxy",
    "infra/modules/rbac",
    "infra/environments/dev",
    "infra/environments/test",
    "infra/environments/prod",
    "infra/shared/backend-bootstrap",
    "adf/pipeline",
    "adf/dataset",
    "adf/linkedService",
    "adf/trigger",
    "src/aiops-function",
    "docs/adr",
    "docs/diagrams",
    ".github/workflows",
    ".github/ISSUE_TEMPLATE",
]

MODULE_FILES = {
    "main.tf": "# Modulo {module}\n",
    "variables.tf": "# Variabili del modulo {module}\n",
    "outputs.tf": "# Output del modulo {module}\n",
    "README.md": "# Modulo {module}\n\nGenerato da scaffold. Verra' sovrascritto da terraform-docs.\n",
}


def ensure_dir(path: Path) -> None:
    path.mkdir(parents=True, exist_ok=True)


def touch_placeholder(path: Path, content: str, force: bool) -> bool:
    if path.exists() and not force:
        return False
    path.write_text(content, encoding="utf-8")
    return True


def ensure_gitkeep(path: Path) -> None:
    gitkeep = path / ".gitkeep"
    try:
        empty = not any(path.iterdir())
    except StopIteration:
        empty = True
    if empty:
        gitkeep.touch()


def scaffold_module(module_dir: Path, force: bool) -> tuple[int, int]:
    module_name = module_dir.name
    created = 0
    skipped = 0
    for filename, template in MODULE_FILES.items():
        target = module_dir / filename
        content = template.format(module=module_name)
        if touch_placeholder(target, content, force):
            created += 1
        else:
            skipped += 1
    return created, skipped


def main() -> int:
    parser = argparse.ArgumentParser(description="Scaffold repo data-platform-aiops")
    parser.add_argument("--root", default=".", help="Root del repository (default: .)")
    parser.add_argument("--force", action="store_true", help="Sovrascrive i placeholder esistenti")
    args = parser.parse_args()

    root = Path(args.root).resolve()
    if not root.is_dir():
        print(f"ERRORE: root non valida: {root}", file=sys.stderr)
        return 1

    print(f"Root: {root}")
    print(f"Force: {args.force}")

    total_created = 0
    total_skipped = 0

    for rel in DIRECTORIES:
        d = root / rel
        ensure_dir(d)
        print(f"  [dir] {rel}")

    for rel in DIRECTORIES:
        if "/modules/" not in rel.replace("\\", "/"):
            continue
        created, skipped = scaffold_module(root / rel, args.force)
        total_created += created
        total_skipped += skipped
        print(f"  [module] {rel}: creati={created}, saltati={skipped}")

    for rel in DIRECTORIES:
        ensure_gitkeep(root / rel)

    print(f"\nTotale file creati: {total_created}, saltati: {total_skipped}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
