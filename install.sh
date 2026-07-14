#!/usr/bin/env sh
set -eu

PET_ID="shrimpy-keys"
INSTALL_ROOT="${CODEX_HOME:-"$HOME/.codex"}/pets"
INSTALL_DIR="$INSTALL_ROOT/$PET_ID"

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

for required in pet.json spritesheet.webp; do
  if [ ! -f "$SCRIPT_DIR/$required" ]; then
    echo "Missing required file: $SCRIPT_DIR/$required" >&2
    exit 1
  fi
done

mkdir -p "$INSTALL_DIR"

install_file() {
  src="$1"
  dst="$2"
  if [ "$src" = "$dst" ]; then
    return 0
  fi
  cp "$src" "$dst"
}

install_file "$SCRIPT_DIR/pet.json" "$INSTALL_DIR/pet.json"
install_file "$SCRIPT_DIR/spritesheet.webp" "$INSTALL_DIR/spritesheet.webp"

if [ -f "$SCRIPT_DIR/README.md" ]; then
  install_file "$SCRIPT_DIR/README.md" "$INSTALL_DIR/README.md"
fi

if [ -f "$SCRIPT_DIR/preview.png" ]; then
  install_file "$SCRIPT_DIR/preview.png" "$INSTALL_DIR/preview.png"
fi

if [ -f "$SCRIPT_DIR/preview.gif" ]; then
  install_file "$SCRIPT_DIR/preview.gif" "$INSTALL_DIR/preview.gif"
fi

if [ -f "$SCRIPT_DIR/sample-info.json" ]; then
  install_file "$SCRIPT_DIR/sample-info.json" "$INSTALL_DIR/sample-info.json"
fi

if [ -f "$SCRIPT_DIR/install.sh" ]; then
  install_file "$SCRIPT_DIR/install.sh" "$INSTALL_DIR/install.sh"
  chmod +x "$INSTALL_DIR/install.sh"
fi

echo "Installed Shrimpy Keys to $INSTALL_DIR"
