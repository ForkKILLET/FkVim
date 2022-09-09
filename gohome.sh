QB='E -n "\033[34m(y/n) \033[0m"; read -k1 Q; if [[ $Q =~ [Yy] ]]; then E;'
QE='else E "\n^"; fi'

indent=$1

[[ -n "GHPROXY" ]] && G="https://ghproxy.com/"

zsh << SHELL

E() {
	[[ -n "$indent" ]] && for i in {1..$indent}; do echo -n "    "; done
	echo \$*
}

EE() {
	echo -n "\033[32m"
	E \$*
    echo -n "\033[0m"
}

EE "# Constructing directories"
mkdir -p ~/.vim

EE "# Linking dotfiles"
E "    * .vim"
rm -f ~/.vim/vimrc
ln -s ~/_/FkVim/vimrc ~/.vim/vimrc

EE "# Installing vim-plug?"
$QB
	git clone "${G}https://github.com/junegunn/vim-plug.git" $VIMFILES/autoload
$QE

EE "# Welcoming Vim."

SHELL

