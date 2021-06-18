indent=$1
E() {
	for i in {0..$indent}; do echo -n "    "; done
	echo "$1"
}

E "# Constructing directories"
mkdir -p ~/.vim
mkdir -p ~/.vim/bundle
rm -rf ~/.vim/bundle/FkVim

E "# Linking dotfiles * .vim"
rm -f ~/.vim/vimrc
ln -s ~/_/FkVim/vimrc ~/.vim/vimrc

E "# Installing Vundle?"
read Q; if [[ Q = Y ]]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else E ^; fi

E "# Welcoming Vim."

