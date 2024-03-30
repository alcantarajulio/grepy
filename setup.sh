#!/bin/bash

WORK_DIR="$(pwd)/haskell/grepy"

# Ensure ~/.local/bin is in PATH
if [[ ! $(echo $PATH | grep "/.local/bin") ]]; then
	echo "O diretório ~/.local/bin não está no seu PATH. Por favor, coloque-o."
	exit 1
fi

cd $WORK_DIR
stack build --copy-bins
mv ~/.local/bin/grepy-exe ~/.local/bin/grepy
chmod +x ~/.local/bin/grepy
