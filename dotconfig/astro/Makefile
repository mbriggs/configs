install: dependencies clean clone

clone:
	git clone https://github.com/AstroNvim/AstroNvim.git $$HOME/.config/nvim

link:
	ln -sf $$HOME/.config/astro $$HOME/.config/nvim/lua/user

run: 
	nvim  --headless -c 'quitall'

clean:
	rm -rf $$HOME/.cache/nvim
	rm -rf $$HOME/.local/share/nvim
	rm -rf $$HOME/.local/state/nvim

dependencies:
	brew install rust || exit 1
	brew install borkdude/brew/clj-kondo || exit 1
	brew install --cask cljstyle || exit 1
	brew install ripgrep || exit 1
	brew install codespell || exit 1
	brew install shfmt || exit 1
	brew install sqlparse || exit 1
	brew install shellcheck || exit 1
	brew install stylua || exit 1
	brew install hadolint || exit 1
	pip3 install cmakelang || exit 1
	pip3 install tiktoken || exit 1
	brew install sad || exit 1
	brew install fd || exit 1
	brew install git-delta || exit 1
	brew install fzf || exit 1
	CARGO_NET_GIT_FETCH_WITH_CLI=true cargo install tree-sitter-cli || exit 1
	brew install -f gdu || brew link --overwrite gdu
	brew install bottom || exit 1
	npm install -g prettier || exit 1
	npm install -g lua-fmt || exit 1
	npm install -g eslint_d || exit 1
	npm install -g @fsouza/prettierd || exit 1
	npm install -g @unibeautify/beautifier-sqlformat || exit 1
	npm install -g stylelint || exit 1
