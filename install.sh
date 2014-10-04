#! /bin/zsh

set -e

SRC=asdfasdf

if [ -d "/vagrant" ]; then
  SRC=/vagrant
fi

if [ ! -n "$ZSH" ]; then
  ZSH=~/.shellstuff
fi

if [ -d "$ZSH" ]; then
	echo "Alread installed..."
	exit
fi

echo "Cloning..."
hash git >/dev/null 2>&1 && env git clone $SRC $ZSH --recursive || {
  echo "git not installed"
  exit
}

ln -s "${ZDOTDIR:-$HOME}"/.shellstuff/ext/prezto "${ZDOTDIR:-$HOME}"/.zprezto

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^(README.md|zshrc|zpreztorc)(.N); do
  	ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

for rcfile in "${ZDOTDIR:-$HOME}"/.shellstuff/conf; do
	ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done


if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Time to change your default shell to zsh!"
    chsh -s `which zsh`
fi