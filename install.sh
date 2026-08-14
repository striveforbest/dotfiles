#!/bin/bash
# install.sh -- symlink tracked dotfiles into $HOME. Idempotent.
set -euo pipefail
REPO="$(cd "$(dirname "$0")" && pwd)"
STAMP=$(date +%Y%m%d-%H%M%S)

for f in .zshrc .aliases .functions .gitconfig .gitignore_global .vimrc .gnupg; do
  src="$REPO/$f"; dst="$HOME/$f"
  [ -e "$src" ] || { printf '%-20s skip (not in repo)\n' "$f"; continue; }

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    printf '%-20s ok\n' "$f"; continue
  fi

  # Never move a real ~/.gnupg aside -- it may hold live private keys.
  if [ "$f" = ".gnupg" ] && [ -d "$dst" ] && [ ! -L "$dst" ]; then
    printf '%-20s SKIPPED: real directory, resolve by hand\n' "$f"; continue
  fi

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.bak-$STAMP"
    printf '%-20s moved aside -> %s.bak-%s\n' "$f" "$f" "$STAMP"
  fi
  ln -sfn "$src" "$dst"
  printf '%-20s linked\n' "$f"
done
