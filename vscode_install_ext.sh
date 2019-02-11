#!/bin/bash
function install {
    code --install-extension $1
}

filename="vscode/extensions.txt"
while read -r line
do
    install $line
done < "$filename"