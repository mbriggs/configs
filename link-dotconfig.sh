#!/usr/bin/env bash

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
target="$HOME/.config"

mkdir -p "$target"

echo "-> linking $script_dir/dotconfig to $target"

for file in "$script_dir"/dotconfig/*; do
	base=$(basename "$file")

	ln -sfv "$file" "$target/$base"
done
