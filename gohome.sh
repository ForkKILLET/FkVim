QB='read -k1 "Q?(y/n) "; if [[ $Q =~ [Yy] ]]; then E;'
QE='else E "\n^"; fi'
indent=$1

zsh << SHELL

E() {
	for i in {0..$indent}; do echo -n "    "; done
	echo "\$1"
}

E "# Constructing directories"
mkdir -p ~/.vim
mkdir -p ~/.vim/bundle
rm -rf ~/.vim/bundle/FkVim

E "# Linking dotfiles * .vim"
rm -f ~/.vim/vimrc
ln -s ~/_/FkVim/vimrc ~/.vim/vimrc

E "# Installing vim-plug?"
$QB
	git clone https://github.com/junegunn/vim-plug.git $VIMFILES/autoload
$QE

E "# Welcoming Vim."

SHELL

