## Why Keep JupyterLab in the Workflow

Neovim is where I write and maintain my project code. JupyterLab has a different role: it is my interactive workspace for notebook notes, experiments, rendered tables and plots, and explanations of results. A notebook can document what I tried and show its output while the reusable code itself stays in the project’s Python package, edited in Neovim.

That makes notebooks useful as living technical documents. They can combine Markdown explanations, code that runs against the project, and visible results in one place. Linters and language servers are still useful for notebook cells, but JupyterLab is not meant to replace Neovim as my main coding environment.

## Quick Navigation

- [Why Keep JupyterLab in the Workflow](#why-keep-jupyterlab-in-the-workflow)
- [Apply Tokyo Night Styling](#apply-tokyo-night-styling)
- [Create a Conda Environment for a Project](#create-a-conda-environment-for-a-project)
- [Add JupyterLab Language Servers](#add-jupyterlab-language-servers)
- [Use a Rust Kernel](#use-a-rust-kernel)
- [Import and Reload Project Code](#import-and-reload-project-code)
- [Launch JupyterLab](#launch-jupyterlab)
- [Useful Documentation](#useful-documentation)
## Apply Tokyo Night Styling

JupyterLab has a built-in dark theme, and my custom CSS adds the Tokyo Night colors and the details I want across the interface. The stylesheet changes JupyterLab’s appearance; it does not insert setup code into notebooks.

Keep the source stylesheet in the setup repository at `configs/jupyterlab/custom.css`. To install it for your Jupyter user account, copy it into Jupyter’s custom CSS directory:

```bash
mkdir -p "$HOME/.jupyter/custom"
cp /path/to/linux-dev-setup/configs/jupyterlab/custom.css \
  "$HOME/.jupyter/custom/custom.css"
```

Replace `/path/to/linux-dev-setup` with the location where you cloned the repository. You can check Jupyter’s active configuration paths with:

```bash
jupyter --paths
```

JupyterLab does not load `custom.css` by default. Enable it in `~/.jupyter/jupyter_lab_config.py` by adding:

```python
c.LabApp.custom_css = True
```

If that file does not exist, create it. Restart JupyterLab after changing the stylesheet or configuration. The official JupyterLab instructions describe this `custom.css` path and `LabApp.custom_css` setting.

You can also select the built-in dark theme through **Settings → Theme**. It provides the base appearance; the custom stylesheet applies my Tokyo Night colors and extra styling.

## Create a Conda Environment for a Project

The reusable environment template belongs in the setup repository:

```text
environments/python-data-dev.yml
```

It is a starting point for new projects, not one shared environment that every project uses. Copy it into each project so that project has a record of its own environment setup. The template includes Python, JupyterLab, common data libraries such as NumPy, pandas, Polars, Plotly, and Dash, along with notebook utilities and Python development tools.

From a new project directory, copy the template and create a separate environment:

```bash
mkdir -p environments
cp /path/to/linux-dev-setup/environments/python-data-dev.yml \
  environments/environment.yml

conda env create -f environments/environment.yml -n my-project
conda activate my-project
```

Replace `/path/to/linux-dev-setup` with your local setup repository path and `my-project` with the environment name. Because this is a project copy, add project-specific dependencies to the project’s files rather than changing the reusable template every time.

If you update the project’s YAML later, apply the changes with:

```bash
conda env update -f environments/environment.yml -n my-project
```

JupyterLab’s extensions and related packages can have version compatibility requirements, so treat each project’s environment file as the record of what that project uses. :chatgpt-content-reference{index="1"}

## Add JupyterLab Language Servers

The Conda template includes the JupyterLab LSP integration and Python language-server packages. The LSP integration does not install every language server by itself: each server needs to be installed separately and available to JupyterLab.

For Node.js-based servers, install Node.js and npm, then install the servers in a shared location outside the Neovim configuration:

```bash
npm install --prefix "$HOME/.local/share/jupyter-lsp-servers" \
  bash-language-server \
  dockerfile-language-server-nodejs \
  sql-language-server \
  typescript-language-server \
  unified-language-server \
  vscode-css-languageserver-bin \
  vscode-html-languageserver-bin \
  vscode-json-languageserver-bin \
  yaml-language-server
```

Add their executable directory to `PATH` before starting JupyterLab:

```bash
export PATH="$HOME/.local/share/jupyter-lsp-servers/node_modules/.bin:$PATH"
```

To load that path in new Zsh sessions, add the export line to `~/.zshrc` and open a new terminal. A JupyterLab message saying that other language servers were skipped is generally informational: it means those optional servers are not installed.

The environment YAML manages Conda and Python packages. npm servers and the Rust kernel have their own installation methods, so keeping them separate makes each part easier to maintain.

## Use a Rust Kernel

A Rust notebook kernel is separate from the Python environment. [Evcxr](https://github.com/evcxr/evcxr) lets Jupyter run Rust cells. With Rust and Cargo installed, install and register its kernel:

```bash
rustup component add rust-src
cargo install --locked evcxr_jupyter
evcxr_jupyter --install
```

Restart JupyterLab, then select **Rust** from the notebook’s kernel menu. The Evcxr project documents these installation and registration steps. :chatgpt-content-reference{index="3"}

Use the Python kernel for Python Polars. Use the Rust kernel and Rust’s Polars crate when you want to experiment with Polars from Rust code.

## Import and Reload Project Code

Keep reusable code in the project package and edit it in Neovim. With the project Conda environment active, install the package in editable mode from the project root:

```bash
conda activate my-project
python -m pip install -e .
```

A notebook can now import the project module:

```python
from my_project.analysis import run_analysis
```

To reload imported Python modules after saving changes in Neovim, create an IPython startup script:

```bash
mkdir -p "$HOME/.ipython/profile_default/startup"

cat > "$HOME/.ipython/profile_default/startup/00-autoreload.py" <<'PY'
ip = get_ipython()
ip.run_line_magic("load_ext", "autoreload")
ip.run_line_magic("autoreload", "2")
PY
```

Restart the notebook kernel after creating the startup file. Autoreload runs when the kernel starts, so there is no setup cell to show in every notebook. The editable install connects the environment to the project source; autoreload helps the running kernel see saved changes when you execute later cells.

## Launch JupyterLab

Start JupyterLab from the project directory with the project environment activated:

```bash
conda activate my-project
jupyter lab
```

Since JupyterLab is included in the template, launching it from the project environment makes that environment’s Python kernel available. If you launch JupyterLab from a different environment, register the project environment as a kernel:

```bash
conda activate my-project
python -m ipykernel install --user \
  --name my-project \
  --display-name "Python (my-project)"
```

Then choose **Python (my-project)** from the notebook’s kernel menu. The selected kernel determines which environment’s Python packages the notebook can import.

## Useful Documentation

- [JupyterLab installation](https://jupyterlab.readthedocs.io/en/stable/getting_started/installation.html)
- [JupyterLab custom CSS](https://jupyterlab.readthedocs.io/en/stable/user/custom_css.html)
- [JupyterLab LSP language servers](https://jupyterlab-lsp.readthedocs.io/en/latest/Language%20Servers.html)
- [Evcxr Rust Jupyter kernel](https://github.com/evcxr/evcxr/blob/main/evcxr_jupyter/README.md)
