#!/usr/bin/env bash
set -e

TEMPLATES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ">>> New Project Creator"
echo "Available templates:"
ls -d $TEMPLATES_DIR/*_template | xargs -n1 basename

read -p "Choose template name (e.g. app_template): " TEMPLATE_NAME
read -p "Enter new project name: " PROJECT_NAME

SOURCE_DIR="$TEMPLATES_DIR/$TEMPLATE_NAME"
TARGET_DIR="$(dirname "$TEMPLATES_DIR")/$PROJECT_NAME"

if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ Template '$TEMPLATE_NAME' not found."
    exit 1
fi

if [ -d "$TARGET_DIR" ]; then
    echo "❌ Project '$PROJECT_NAME' already exists."
    exit 1
fi

echo ">>> Creating project '$PROJECT_NAME' from '$TEMPLATE_NAME'..."
cp -r "$SOURCE_DIR" "$TARGET_DIR"

# Clean up potential .git inside template
rm -rf "$TARGET_DIR/.git"

# Update pyproject.toml name field if exists
if grep -q "name = " "$TARGET_DIR/pyproject.toml"; then
    sed -i "s/name = \".*\"/name = \"$PROJECT_NAME\"/" "$TARGET_DIR/pyproject.toml"
fi

# Ask about git init
read -p "Initialize git repository for $PROJECT_NAME? (y/n): " INIT_GIT
if [[ "$INIT_GIT" =~ ^[Yy]$ ]]; then
    cd "$TARGET_DIR"
    git init
    git add .
    git commit -m "Initial commit for $PROJECT_NAME"
    cd - > /dev/null
fi

echo ">>> Project $PROJECT_NAME created successfully!"
echo "Next steps:"
echo "  cd $PROJECT_NAME"
echo "  ./setup.sh"
echo "  make run"
