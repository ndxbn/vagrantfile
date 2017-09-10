#!/bin/bash -eu
git clone https://github.com/riywo/anyenv ~/.anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

anyenv install goenv
anyenv install nodenv
anyenv install phpenv
anyenv install rbenv
eval "$(anyenv init -)"
