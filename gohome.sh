QB='E -n "(y/n) "; read -k1 Q; if [[ $Q =~ [Yy] ]]; then E;'
QE='else E "\n^"; fi'
indent=$1

[[ -n "GHPROXY" ]] && G="https://ghproxy.com/"

zsh << SHELL

E() {
	for i in {0..$indent}; do echo -n "    "; done
	echo \$*
}

EE() {
	echo -n "\033[32m"
	E \$*
    echo -n "\033[0m"
}

EE "# Constructing directories"
mkdir -p ~/.vim
mkdir -p ~/.vim/bundle
rm -rf ~/.vim/bundle/FkVim

EE -n "# Linking dotfiles"
E "* .vim"
rm -f ~/.vim/vimrc
ln -s ~/_/FkVim/vimrc ~/.vim/vimrc

EE "# Installing vim-plug?"
$QB
	git clone "${G}https://github.com/junegunn/vim-plug.git" $VIMFILES/autoload
$QE

EE "# Welcoming Vim."

SHELL

