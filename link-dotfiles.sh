#!/usr/bin/env bash

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
target="$HOME"

mkdir -p "$target"

echo "-> linking $script_dir/dotfiles to $target"

for file in "$script_dir"/dotfiles/*; do
	base=$(basename "$file")

	rm "$target/.$base"
	ln -sfv "$file" "$target/.$base"
done
