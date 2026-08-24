"""Make Skills Network notebooks reproducible in the local course project.

The course notebooks were authored for a hosted Skills Network runtime.  This
small utility keeps the notebook content intact while disabling hosted
package/data download commands and replacing known remote data variables with
portable local-data lookups.
"""

from __future__ import annotations

import argparse
import json
import re
from pathlib import Path
from typing import Iterable


BOOTSTRAP_MARKER = "# local-ml-bootstrap"


def _bootstrap_cell(module_data_path: str) -> dict[str, object]:
    source = f'''{BOOTSTRAP_MARKER}
from pathlib import Path

_MODULE_DATA_RELATIVE = Path({module_data_path!r})


def _resolve_local_data(filename: str) -> Path:
    """Find a module dataset whether Jupyter starts in the repo or notebook dir."""
    current = Path.cwd()
    roots: list[Path] = []
    for base in (current, *current.parents):
        roots.extend(
            [
                base / "data",
                base / _MODULE_DATA_RELATIVE,
                base / "Python For Machine Learning IBM" / _MODULE_DATA_RELATIVE,
            ]
        )

    for root in roots:
        candidate = root / filename
        if candidate.is_file():
            return candidate

    searched = "\\n".join(str(root / filename) for root in roots)
    raise FileNotFoundError(
        f"Could not find {{filename!r}} in the local course data directories:\\n{{searched}}"
    )
'''
    return {
        "cell_type": "code",
        "execution_count": None,
        "metadata": {},
        "outputs": [],
        "source": source.splitlines(keepends=True),
    }


def _disable_hosted_commands(source: str) -> str:
    disabled_prefixes = ("!pip install", "%pip install", "!conda install", "!wget ", "!curl ")
    lines: list[str] = []
    changed = False
    for line in source.splitlines(keepends=True):
        stripped = line.lstrip()
        if stripped.startswith(disabled_prefixes) and not stripped.startswith("#"):
            indent = line[: len(line) - len(stripped)]
            newline = "" if not line.endswith("\n") else "\n"
            lines.append(f"{indent}# Disabled for local execution: {stripped.rstrip()}" + newline)
            changed = True
        else:
            lines.append(line)
    return "".join(lines) if changed else source


def _replace_remote_data(source: str, replacements: Iterable[tuple[str, str]]) -> str:
    for old, new in replacements:
        source = source.replace(old, new)
    return source


def _replace_remote_data_variables(source: str, basenames: Iterable[str]) -> str:
    """Replace ``url = https://.../filename`` assignments with local paths."""
    basename_list = tuple(basenames)
    if not basename_list:
        return source

    lines: list[str] = []
    for line in source.splitlines(keepends=True):
        if "http" in line and re.match(r"^\s*url\s*=", line):
            matched = next((name for name in basename_list if name in line), None)
            if matched:
                newline = "\n" if line.endswith("\n") else ""
                lines.append(f"url = _resolve_local_data({matched!r})" + newline)
                continue
        lines.append(line)
    return "".join(lines)


def _replace_local_data_reads(source: str, basenames: Iterable[str]) -> str:
    """Route direct ``pd.read_csv('file.csv')`` calls through the local resolver."""
    for basename in basenames:
        pattern = rf"pd\.read_csv\(\s*(['\"]){re.escape(basename)}\1"
        replacement = f"pd.read_csv(_resolve_local_data({basename!r})"
        source = re.sub(pattern, replacement, source)
    return source


def _replace_remote_data_reads(source: str, basenames: Iterable[str]) -> str:
    """Route direct remote ``pd.read_csv('https://.../file.csv')`` calls locally."""
    for basename in basenames:
        pattern = (
            rf"pd\.read_csv\(\s*(['\"])https?://[^'\"]*/"
            rf"{re.escape(basename)}(?:[?#][^'\"]*)?\1\s*\)"
        )
        replacement = f"pd.read_csv(_resolve_local_data({basename!r}))"
        source = re.sub(pattern, replacement, source)
    return source


def normalize_notebook(
    notebook_path: Path,
    *,
    module_data_path: str,
    replacements: Iterable[tuple[str, str]],
    data_basenames: Iterable[str],
) -> bool:
    notebook = json.loads(notebook_path.read_text(encoding="utf-8"))
    changed = False

    for cell in notebook.get("cells", []):
        source = "".join(cell.get("source", []))
        if cell.get("cell_type") == "code":
            updated = _disable_hosted_commands(source)
            updated = _replace_remote_data(updated, replacements)
            updated = _replace_remote_data_variables(updated, data_basenames)
            updated = _replace_local_data_reads(updated, data_basenames)
            updated = _replace_remote_data_reads(updated, data_basenames)
            if updated != source:
                cell["source"] = updated.splitlines(keepends=True)
                changed = True

    cells = notebook.setdefault("cells", [])
    if not cells or BOOTSTRAP_MARKER not in "".join(cells[0].get("source", [])):
        cells.insert(0, _bootstrap_cell(module_data_path))
        changed = True

    if changed:
        notebook_path.write_text(
            json.dumps(notebook, ensure_ascii=False, indent=1) + "\n",
            encoding="utf-8",
        )
    return changed


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--module-data-path", required=True)
    parser.add_argument("--notebook", action="append", type=Path, required=True)
    parser.add_argument(
        "--replace",
        action="append",
        nargs=2,
        metavar=("OLD", "NEW"),
        default=[],
    )
    parser.add_argument("--data-basename", action="append", default=[])
    args = parser.parse_args()

    changed_count = 0
    for notebook in args.notebook:
        if normalize_notebook(
            notebook,
            module_data_path=args.module_data_path,
            replacements=args.replace,
            data_basenames=args.data_basename,
        ):
            changed_count += 1
            print(f"normalized: {notebook}")
    print(f"changed_notebooks={changed_count}")


if __name__ == "__main__":
    main()
