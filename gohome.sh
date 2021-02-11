mkdir -p ~/.vim
rm -f ~/.vim/vimrc
ln -s ~/_/FkVim/vimrc ~/.vim/vimrc

mkdir -p ~/.vim/bundle
rm -f ~/.vim/bundle/javascript
ln -s ~/_/FkVim/vimrc/javascript ~/.vim/bundle/javascript

echo "Welcome home: Vim."

