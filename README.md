Sure! Here's the **entire README.md** for your `templates/` repo, in a single, easy-to-copy Markdown block:

````markdown
# Python Project Templates

This repository contains reusable **project templates** for Python apps and other projects.  
Each template is designed to be:

- **Reproducible**: Uses [uv](https://github.com/astral-sh/uv) with `pyproject.toml` + `uv.lock`.
- **Modern**: Includes `.env` handling, Makefile shortcuts, and Docker support.
- **Portable**: Can generate standalone projects with or without Git.
- **Portfolio-friendly**: Clear structure and professional best practices.

---

## 🚀 Quickstart: How to Use This Repository

### 1. Clone this repository

```bash
git clone git@github.com:yourusername/templates.git
cd templates
```

> Replace `yourusername` with your GitHub username if using SSH. Or use HTTPS:
> `git clone https://github.com/yourusername/templates.git`

---

### 2. Generate a new project

```bash
./new_project.sh
```

You’ll be prompted to:
- Choose a template (`app_template`, etc.)
- Enter the new project name
- Choose whether to initialize a git repo

The new project will be created **outside this folder**, in a sibling directory:
```
.
├─ templates/
├─ your_new_project/  ← generated here
```

---

### 3. Run the generated project

```bash
cd ../your_new_project
./setup.sh          # installs deps, creates .env
make run            # or ./run.sh
```

You can also run:

```bash
make docker         # builds and runs Docker container
make test           # runs pytest (if tests exist)
make clean          # cleans up cache/venv
```

---

## 📂 Repo Structure

```
templates/
├─ app_template/         # Example template for Python apps
│  ├─ app/               # Application code lives here
│  ├─ tests/             # Unit tests
│  ├─ setup.sh           # Project setup
│  ├─ run.sh             # Local run script
│  ├─ Makefile           # Developer commands
│  ├─ Dockerfile         # Container build
│  ├─ .env.example       # Env var template
│  ├─ pyproject.toml     # uv-managed deps
│  └─ README.md          # Generated project instructions
│
├─ new_project.sh        # Generic generator script
├─ .gitignore            # Ignore caches, venvs, etc.
└─ README.md             # You are here
```

---

## 📤 Publishing Generated Projects to GitHub

After generating a project, you can initialize Git and push to GitHub like so:

```bash
cd ../your_new_project
git init
git add .
git commit -m "Initial commit"
git remote add origin git@github.com:yourusername/your_new_project.git
git branch -M main
git push -u origin main
```

---

## 🛠️ Template Features

Each template is:

- ✅ **uv-based** (`pyproject.toml`, no virtualenv needed)
- ✅ Has `.env.example` for safe secret handling
- ✅ Uses `Makefile` for local dev (run, docker, test, clean)
- ✅ Includes `Dockerfile` for container use
- ✅ Structured for clarity (separates `app/` and `tests/`)
- ✅ Perfect for showcasing clean code in portfolios

---

## 📦 Available Templates

- `app_template/`: Starter for building Python applications (APIs, Gradio apps, CLI tools, etc.)

---

## 🧪 Testing the Template Repo Itself

If you want to test that `new_project.sh` works end-to-end:

```bash
cd templates
chmod +x new_project.sh # give the right permissions
./new_project.sh    # create dummy project
cd ../dummy_project
./setup.sh
make run
```

---

## 📄 License

MIT License. Free to use, fork, and adapt.
```
````