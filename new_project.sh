#!/usr/bin/env bash
set -e

TEMPLATES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ">>> New Project Creator"

# List available templates
echo "Available templates:"
ls -d "$TEMPLATES_DIR"/*_template | xargs -n1 basename

# Prompt for template and project name
read -p "Choose template name (e.g. app_template): " TEMPLATE_NAME
read -p "Enter new project name: " PROJECT_NAME

SOURCE_DIR="$TEMPLATES_DIR/$TEMPLATE_NAME"
TARGET_DIR="$(dirname "$TEMPLATES_DIR")/$PROJECT_NAME"

# Validate paths
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Template '$TEMPLATE_NAME' not found."
    exit 1
fi

if [ -d "$TARGET_DIR" ]; then
    echo "❌ Project '$PROJECT_NAME' already exists."
    exit 1
fi

# Copy template
echo ">>> Creating project '$PROJECT_NAME' from '$TEMPLATE_NAME'..."
cp -r "$SOURCE_DIR" "$TARGET_DIR"

# Clean up
rm -rf "$TARGET_DIR/.git"

# Replace project name in pyproject.toml
if grep -q "name = " "$TARGET_DIR/pyproject.toml"; then
    sed -i "s/name = \".*\"/name = \"$PROJECT_NAME\"/" "$TARGET_DIR/pyproject.toml"
fi

# Git initialization
read -p "Initialize git repository for $PROJECT_NAME? (y/n): " INIT_GIT
if [[ "$INIT_GIT" =~ ^[Yy]$ ]]; then
    cd "$TARGET_DIR"
    git init
    git add .
    git commit -m "Initial commit for $PROJECT_NAME"

    read -p "Enter your GitHub username (for repo instructions): " GITHUB_USER
    echo ""
    echo ">>> Your local git repo is ready."

    echo ""
    echo "📤 Next steps to push to GitHub:"
    echo ""
    echo "1. Go to: https://github.com/new"
    echo "   - Repository name: $PROJECT_NAME"
    echo "   - Keep it empty (✅ no README, .gitignore, or license)"
    echo ""
    echo "2. Then run:"
    echo ""
    echo "   git remote add origin git@github.com:$GITHUB_USER/$PROJECT_NAME.git"
    echo "   git branch -M main"
    echo "   git push -u origin main"
    echo ""
    cd - > /dev/null
else
    echo ">>> Git initialization skipped."
fi

# Final instructions
echo ""
echo "✅ Project '$PROJECT_NAME' created successfully!"
echo ""
echo "📂 To get started:"
echo "  cd $PROJECT_NAME"
echo "  ./setup.sh"
echo "  make run"
