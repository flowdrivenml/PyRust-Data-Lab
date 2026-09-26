## Quick Navigation

- [What `.gitignore` Is For](#what-gitignore-is-for)
- [Reusable Template](#reusable-template)
- [Choose Project-Specific Rules](#choose-project-specific-rules)
- [Important Files to Keep](#important-files-to-keep)
- [Check Your Ignore Rules](#check-your-ignore-rules)

## What `.gitignore` Is For

A `.gitignore` file tells Git which **untracked** files and directories to leave out of version control. It is commonly used for generated files, caches, local environments, personal editor settings, credentials, and data files that are too large or private to store in the repository.

The `.gitignore` file itself is normally committed. That way, everyone working on the project uses the same rules.

This guide keeps a reusable template in Markdown for reference. Copy the rules that apply into a project’s `.gitignore`; don’t blindly use every optional rule. Projects have different needs, and an overbroad rule can hide a file the project actually needs.

## Reusable Template

```gitignore
# ==============================
# Operating system files
# ==============================

.DS_Store
.AppleDouble
.LSOverride
Thumbs.db
Desktop.ini
$RECYCLE.BIN/


# ==============================
# Temporary files, logs, and backups
# ==============================

*.log
*.tmp
*.temp
*.bak
*.swp
*.swo
*~
*.orig
*.rej


# ==============================
# Local secrets and environment files
# ==============================

.env
.env.*
!.env.example
!.env.sample

# Local secret directories and configuration files
secrets/
secrets.*
*.local.env
*.local.toml
*.local.yaml
*.local.yml
*.local.json

# Uncomment if these are local credentials in this project:
# .aws/credentials
# .azure/
# .config/gcloud/
# *.tfstate
# *.tfstate.*
# .terraform/
# *.tfvars
# !*.tfvars.example


# ==============================
# Python
# ==============================

__pycache__/
*.py[cod]
*$py.class
.Python

# Python virtual environments
.venv/
venv/
ENV/

# Python build and packaging output
build/
dist/
*.egg-info/
.eggs/
wheels/
pip-wheel-metadata/

# Python test, type-checker, and linter caches
.pytest_cache/
.tox/
.nox/
.hypothesis/
.mypy_cache/
.dmypy.json
dmypy.json
.pyre/
.pytype/
.pyright/
.ruff_cache/

# Coverage output
.coverage
.coverage.*
htmlcov/


# ==============================
# Conda and local environments
# ==============================

# Uncomment if Conda environments or package caches are created inside this project:
# .conda/
# conda-bld/
# pkgs/


# ==============================
# Jupyter and IPython
# ==============================

.ipynb_checkpoints/
*-checkpoint.ipynb

# Notebook files themselves are not ignored: useful notebooks are project documentation.


# ==============================
# Node.js and frontend tooling
# ==============================

node_modules/
.npm/
.pnpm-store/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
lerna-debug.log*

# Frontend build and tool caches
.next/
.nuxt/
.svelte-kit/
.angular/
.turbo/
.parcel-cache/
.vite/
coverage/

# Yarn-generated files; review these if the project uses Yarn Plug'n'Play
.yarn/unplugged/
.yarn/install-state.gz
.yarn/build-state.yml


# ==============================
# Rust
# ==============================

/target/
**/*.rs.bk

# Keep Cargo.lock for applications and workspaces so builds can be reproduced.


# ==============================
# C, C++, CMake, and native builds
# ==============================

CMakeFiles/
CMakeCache.txt
cmake_install.cmake
compile_commands.json

# Common build directories
cmake-build-*/
build-*/


# ==============================
# Go
# ==============================

*.test
coverage.out

# Uncomment only if vendored dependencies should not be committed:
# vendor/


# ==============================
# Java and Gradle
# ==============================

.gradle/
out/
*.class

# Keep Gradle and Maven wrapper files and dependency lock files when the project uses them.


# ==============================
# .NET
# ==============================

bin/
obj/
.vs/
TestResults/
*.user
*.suo


# ==============================
# R
# ==============================

.Rhistory
.RData
.Ruserdata
.Rproj.user/
*.Rcheck/

# renv.lock is project metadata and should normally be committed.
# Ignore the local renv package library if it is stored inside the project:
renv/library/


# ==============================
# Generated documentation and site output
# ==============================

# Uncomment the output folder used by your documentation or site generator:
# site/
# public/
# _site/


# ==============================
# Data science and machine learning output
# ==============================

# Uncomment directories if they contain generated or private data in this project:
# data/raw/
# data/interim/
# data/processed/
# data/external/
# outputs/
# artifacts/
# checkpoints/
# models/
# runs/
# mlruns/
# mlartifacts/
# wandb/
# tensorboard/
# lightning_logs/
# .dvc/cache/

# Uncomment model formats if model files are generated and should never be committed:
# *.pt
# *.pth
# *.ckpt
# *.safetensors
# *.onnx


# ==============================
# Large data files
# ==============================

# Uncomment only if every file with that extension should be ignored.
# These rules also hide small examples and test fixtures.
# *.csv
# *.tsv
# *.parquet
# *.feather
# *.arrow
# *.orc


# ==============================
# Local databases
# ==============================

# Uncomment if these are generated local databases, not project fixtures:
# *.db
# *.sqlite
# *.sqlite3


# ==============================
# Editors and IDEs
# ==============================

.idea/
*.iml
*.sublime-workspace

# VS Code can contain shared project settings.
# Ignore it only if this project does not commit shared settings:
# .vscode/


# ==============================
# Other generated output
# ==============================

.cache/
.tmp/
temp/
```

## Choose Project-Specific Rules

The template covers several languages and workflows, but a project should only use the relevant sections. A Python project may need Python and Jupyter rules; a Rust application may need `/target/`; a data project may need rules for local datasets and generated model output.

### Large CSV and Parquet files

It is tempting to ignore every `*.csv` or `*.parquet` file. That can keep large datasets out of Git, but it can also hide small sample data used by tests or examples. The broad extension rules in the template are commented out for this reason.

A directory-based rule is often safer when only certain data folders should stay local:

```gitignore
/data/raw/
/data/processed/
```

Keep small, intentional test fixtures in a tracked location. For large datasets that must be shared, use a storage system designed for data or large files, such as Git LFS, and document how to obtain them.

### Generated machine-learning files

Model weights, checkpoints, experiment runs, and tracking output can become very large. Ignore their specific output directories when the project regenerates them. Keep a model or dataset in version control only when it is a deliberate, manageable project asset.

### Secrets and local configuration

Ignore real `.env` files and local credentials. Commit a safe example such as `.env.example` with placeholder values so other developers know which settings are required. Before committing, check that the example contains no working passwords, tokens, or private connection strings.

### Editor settings

Some editor settings are personal; others help a team share formatting or recommended extensions. Ignore editor folders only after deciding whether the project should share those settings. For example, a team may want to commit `.vscode/extensions.json` while keeping personal workspace state out of Git.

## Important Files to Keep

Do not ignore project files just because they are configuration files. These are normally important to commit:

- `pyproject.toml` describes Python package metadata, dependencies, and tool settings.
- `environment.yml` records a Conda environment recipe for a project.
- `Cargo.toml` describes a Rust package and its dependencies.
- `Cargo.lock` records resolved Rust dependency versions for applications and workspaces.
- `uv.lock`, `poetry.lock`, `Pipfile.lock`, and JavaScript lock files record resolved dependencies for their package managers.
- Source code, useful notebooks, tests, documentation, and small example datasets belong in Git when they are part of the project.

Lock-file conventions can depend on the kind of project and its tooling, but a broad ignore rule such as `*.lock`, `*.toml`, or `*.csv` is usually too aggressive.

## Check Your Ignore Rules

Use `git check-ignore` to see which rule ignores a particular path:

```bash
git check-ignore -v path/to/file
```

Show untracked files, including ignored ones, with:

```bash
git status --short --ignored
```

Ignore rules apply to untracked files. If Git already tracks a file, adding it to `.gitignore` does not remove it from the repository. To stop tracking it while keeping the local copy, remove it from the Git index:

```bash
git rm --cached path/to/file
```

For a directory:

```bash
git rm -r --cached path/to/directory
```

Review the result before committing:

```bash
git status
git diff --cached
```

A good `.gitignore` excludes disposable, generated, local, or private files while keeping the files needed to understand, reproduce, and maintain the project.