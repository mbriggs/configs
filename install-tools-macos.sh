#!/usr/bin/env bash

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
mkdir -p "$HOME/.config"

echo "-- installing xcode toolchain"
xcode-select --install

echo "-- installing brew"
curl -fsSL -o install.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh || exit 1

echo "-- installing fonts"
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono

echo "-- installing tools"
brew install --cask 1password/tap/1password-cli
brew install ripgrep || exit 1
brew install git || exit 1
brew install make || exit 1
brew install git-delta || exit 1

echo "-- installing rust"
brew install rust || exit 1

echo "-- installing java"
brew install java || exit 1

echo "-- installing clojure"
brew install clojure/tools/clojure || exit 1
brew install borkdude/brew/babashka || exit 1
clojure -Ttools install io.github.seancorfield/deps-new '{:git/tag "v0.4.13"}' :as new

echo "-- installing python"
brew install python || exit 1

echo "-- installing gh"
brew install gh || exit 1

echo "-- installing ruby"
brew install chruby || exit 1
brew install ruby-install || exit 1
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
ruby-install -L || exit 1
ruby-install 3 -- --with-openssl-dir=/opt/homebrew/opt/openssl@1.1 || exit 1
ruby-install 2.7 -- --with-openssl-dir=/opt/homebrew/opt/openssl@1.1 || exit 1

echo "-- installing js"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash || exit 1
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install --lts || exit 1
nvm use --lts || exit 1

echo "-- installing alacritty"
brew install alacritty || exit 1

echo "-- installing tmux"
brew install tmux || exit 1
pushd "$script_dir/terminfo" || exit 1
cd tmux || exit 1
tic -x terminfo.src
popd || exit 1

echo "-- installing neovim"
brew install neovim
pushd "$HOME/.config" || exit 1
rm -rf nvim
git clone https://github.com/AstroNvim/AstroNvim.git "$HOME/.config/nvim"
ln -s "$HOME/.config/astro" "$HOME/.config/nvim/lua/user"
cd "$HOME/.config/nvim/lua/user" || exit 1
make dependencies
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
popd || exit 1

# echo "--installing emacs"
# brew tap d12frosted/emacs-plus
# brew install emacs-plus --with-imagemagick --with-native-comp --with-modern-doom3-icon
# git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
# ~/.config/emacs/bin/doom install
# git clone https://github.com/eraserhd/parinfer-rust.git
# cd parinfer-rust || exit 1
# cargo build --release --features emacs
# mkdir -p ~/.config/emacs/.local/etc/parinfer-rust
# cp target/release/libparinfer_rust.dylib ~/.config/emacs/.local/etc/parinfer-rust/parinfer-rust-darwin.so
# cd .. || exit 1
# rm -rf parinfer-rust
