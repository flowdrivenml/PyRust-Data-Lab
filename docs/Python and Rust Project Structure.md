## Quick Navigation

- [Project Design](#project-design)
- [What Each Configuration File Does](#what-each-configuration-file-does)
- [Python-Only Projects](#python-only-projects)
- [Rust-Only Projects](#rust-only-projects)
- [Projects That Use Both Python and Rust](#projects-that-use-both-python-and-rust)
- [Create a Python Project Environment](#create-a-python-project-environment)
- [Install and Work on the Project](#install-and-work-on-the-project)
- [Use the Project from JupyterLab](#use-the-project-from-jupyterlab)

## Project Design

Keep code, tests, documentation, notebooks, and the files that describe how to build the project together in its repository. Use Python for the parts where its libraries and interactive workflow are useful, and Rust for Rust applications or components where you want Rust’s performance and type system.

When a project uses both languages, keep a clear boundary between them. If Python only needs to run a Rust program or process its output, keep them as separate components. If Python must import Rust functions directly—for example, to accelerate a Python data-processing library—build a Python extension with PyO3 and Maturin. Maturin supports mixed Python/Rust layouts and installs the Rust extension into the Python package. 

## What Each Configuration File Does

A project may use several configuration files because each describes a different part of its setup:

- `environment.yml` creates the Conda environment: the Python version, JupyterLab, and shared development or data tools.
- `pyproject.toml` describes the Python package, its Python dependencies, and Python tools such as Ruff or pytest.
- `Cargo.toml` describes a Rust package or workspace and its Rust dependencies.
- `Cargo.lock` records the resolved Rust dependencies for an application or workspace.

`pyproject.toml` is the conventional place for Python package metadata and Python-tool settings. It does not replace `Cargo.toml`; Cargo remains the Rust package manager. 

## Python-Only Projects

A useful default layout for a Python package is:

```text
my-project/
├── README.md
├── environment.yml
├── pyproject.toml
├── src/
│   └── my_project/
│       ├── __init__.py
│       └── analysis.py
├── notebooks/
│   └── exploration.ipynb
├── tests/
│   └── test_analysis.py
└── data/
```

The `src/` directory contains importable project code. Notebooks contain interactive notes, experiments, and rendered results. Tests check the package behavior. Keep large datasets out of Git unless the project specifically needs them tracked.

The distribution name in `pyproject.toml` is often hyphenated, such as `my-project`, while the Python import name uses underscores, such as `my_project`.

## Rust-Only Projects

For a standalone Rust application or library, Cargo’s standard structure is a good starting point:

```text
my-rust-project/
├── Cargo.toml
├── Cargo.lock
├── README.md
├── src/
│   ├── main.rs
│   └── lib.rs
└── tests/
```

A binary application typically starts from `src/main.rs`; reusable Rust library code usually lives in `src/lib.rs`. Cargo manages the Rust dependencies and build. A Python `pyproject.toml` is not required unless the repository also contains a Python package or Python tooling that uses it.

## Projects That Use Both Python and Rust

There are two common ways to combine them.

### Keep the Python and Rust programs as separate components

Choose this when each program can communicate through files, a command-line interface, a local API, or another clear interface. This keeps each language’s build and dependencies separate:

```text
my-project/
├── README.md
├── python/
│   ├── pyproject.toml
│   ├── src/
│   │   └── my_project/
│   ├── notebooks/
│   └── tests/
└── rust/
    ├── Cargo.toml
    ├── Cargo.lock
    ├── src/
    └── tests/
```

This is often the simplest choice when Python handles research, analysis, or orchestration and Rust runs as its own application or service.

### Make Rust code importable from Python

Choose this when Python should call Rust functions directly, such as when a Python package has a performance-critical component. PyO3 supplies the Python bindings; Maturin builds and installs the extension. The Python code remains a normal package, and the compiled Rust module becomes part of that package. 

```text
my-project/
├── README.md
├── environment.yml
├── pyproject.toml
├── Cargo.lock
├── src/
│   └── my_project/
│       ├── __init__.py
│       ├── analysis.py
│       └── ...
├── rust/
│   ├── Cargo.toml
│   └── src/
│       └── lib.rs
├── notebooks/
└── tests/
```

Here `pyproject.toml` configures the Python package and Maturin. `rust/Cargo.toml` owns the Rust package and its Rust dependencies. Maturin’s documentation supports this Python `src` layout with the Rust crate under `rust/`. 

For a project using this layout, the core of `pyproject.toml` can look like this:

```toml
[build-system]
requires = ["maturin>=1.0,<2.0"]
build-backend = "maturin"

[project]
name = "my-project"
version = "0.1.0"
requires-python = ">=3.12"
dependencies = [
    "polars",
    "plotly",
]

[project.optional-dependencies]
dev = [
    "maturin>=1.0,<2.0",
    "pytest",
    "ruff",
    "mypy",
]

[tool.maturin]
manifest-path = "rust/Cargo.toml"
python-source = "src"
module-name = "my_project._native"
```

The values `my-project`, `my_project`, and `_native` are example names. The Rust extension’s module name must match the name configured in the Rust crate and its PyO3 module declaration. Maturin documents the `manifest-path`, `python-source`, and dotted `module-name` settings. :chatgpt-content-reference{index="4"}

## Create a Python Project Environment

I keep the reusable Conda template in the general development-setup repository, separate from Neovim—for example:

```text
~/projects/linux-dev-setup/environments/python-data-dev.yml
```

Adjust that path if the repository is stored somewhere else. From a new project directory, copy the template into the project and create an environment named after the project folder:

```bash
cp "$HOME/projects/linux-dev-setup/environments/python-data-dev.yml" \
  ./environment.yml

PROJECT_ENV="$(basename "$PWD")"
conda env create -f environment.yml -n "$PROJECT_ENV"
conda activate "$PROJECT_ENV"
```

The project copy of `environment.yml` records the environment setup for this project. Change it when the project needs different Python, JupyterLab, or Conda-managed tools. The reusable template stays in the development-setup repository; it does not live inside the Neovim configuration.

## Install and Work on the Project

For a Python-only project, add the project’s runtime dependencies under `[project].dependencies` in `pyproject.toml`. Put optional development tools under `[project.optional-dependencies]`, for example in the `dev` group.

From the project root, install the package and its development dependencies into the active environment:

```bash
python -m pip install -e ".[dev]"
```

Editable mode links the installed package to the code in the working tree, so imports use the project code you edit in Neovim. Run this when setting up each new environment and again after changing the project’s dependencies. You do not need to repeat it every time you open JupyterLab.

For a Python/Rust extension using the Maturin configuration above, build and install it into the active Python environment with:

```bash
maturin develop --extras dev
```

Maturin’s `develop` command builds the Rust extension in development mode and installs it into the active environment. Re-run it after changing Rust code so the Python package uses the newly built extension. Changes to Python files in the mixed layout can be used directly from the source tree in an editable install. :chatgpt-content-reference{index="5"}

Rust dependencies belong in `rust/Cargo.toml`. For an application or workspace, keep the resulting `Cargo.lock` in Git so other developers can resolve the same dependency versions.

## Use the Project from JupyterLab

Start JupyterLab from the project directory after activating the project environment:

```bash
conda activate "$PROJECT_ENV"
jupyter lab
```

A notebook can import the same Python package you edit in Neovim:

```python
from my_project.analysis import run_analysis
```

For Rust functionality exposed through PyO3, import the Python-facing functions or classes from the package’s public API. Keep notebook cells focused on explanation, experiments, and rendered output; put reusable implementation in the Python package or Rust crate.

For a standalone Rust program that is not exposed as a Python extension, the Python notebook can still run the Rust program or examine its output, but it cannot import Rust functions directly as Python functions.