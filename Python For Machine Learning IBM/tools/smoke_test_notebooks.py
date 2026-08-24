"""Execute notebook code cells in a headless local Python process.

This is intentionally a lightweight smoke test.  It skips notebook-only
magics and shell commands, then reports the first failing cell for each file.
Use Jupyter/VS Code for the full rendered notebook experience.
"""

from __future__ import annotations

import argparse
import json
import os
from pathlib import Path

os.environ.setdefault("MPLBACKEND", "Agg")


def _clean_source(source: str) -> str:
    lines: list[str] = []
    for line in source.splitlines():
        stripped = line.lstrip()
        # A continuation line such as ``% np.mean(...)`` is Python's modulo
        # operator, not a Jupyter magic.  Only treat a percent sign followed
        # immediately by a magic name as notebook syntax.
        is_magic = stripped.startswith("%") and (
            len(stripped) == 1 or not stripped[1].isspace()
        )
        if is_magic or stripped.startswith("!"):
            lines.append(f"# skipped notebook command: {line}")
        else:
            lines.append(line)
    return "\n".join(lines)


def smoke_test(path: Path) -> None:
    notebook = json.loads(path.read_text(encoding="utf-8"))
    namespace: dict[str, object] = {"display": lambda *args, **kwargs: None}
    cells = [cell for cell in notebook.get("cells", []) if cell.get("cell_type") == "code"]
    placeholder_was_skipped = False
    for index, cell in enumerate(cells, start=1):
        source = _clean_source("".join(cell.get("source", [])))
        if any(
            marker in source
            for marker in (
                "# write your code here",
                "# Enter your code here",
                "# ADD CODE",
                "#ADD CODE",
                "# YOUR CODE",
            )
        ):
            print(f"SKIP {path.name}: code cell {index} contains a learner placeholder")
            placeholder_was_skipped = True
            continue
        try:
            exec(compile(source, str(path), "exec"), namespace)
        except NameError as exc:
            if placeholder_was_skipped:
                print(
                    f"SKIP {path.name}: code cell {index} depends on a skipped learner answer ({exc})"
                )
                continue
            raise RuntimeError(f"{path.name}: code cell {index} failed: {exc}") from exc
        except Exception as exc:  # pragma: no cover - CLI diagnostic path
            raise RuntimeError(f"{path.name}: code cell {index} failed: {exc}") from exc
    print(f"PASS {path}")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("notebook", nargs="+", type=Path)
    args = parser.parse_args()
    for notebook in args.notebook:
        smoke_test(notebook)


if __name__ == "__main__":
    main()
