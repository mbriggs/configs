#!/usr/bin/env bash

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
target="$HOME/.local/bin"

mkdir -p "$target"

echo "-> linking $script_dir/bin to $target"

for file in "$script_dir"/bin/*; do
	base=$(basename "$file")

	# echo "$file -> $target/$base"

	chmod -v +x "$file"
	ln -sfv "$file" "$target/$base"
done
