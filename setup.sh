#!/bin/bash

set -e -o pipefail

## This script is to install all of the stuff that makes development awesome

function install_zsh() {
    local user
    sudo dnf install -y zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

function enable_vim() {
    echo 'set -o vi' >> ~/.bash_profile
    echo 'bindkey -v' >> ~/.zshrc
}

function install_fun_editors() {
    sudo dnf install -y neovim
    if ! command -v vim &> /dev/null; then
        sudo ln -s $(which nvim) /usr/local/bin/vim
    fi
    if ! command -v nano &> /dev/null; then
        sudo ln -s $(which nvim) /usr/local/bin/nano
    fi
}

function install_tmux() {
    sudo dnf install -y tmux tmate
}

function install_gh() {
    sudo dnf install 'dnf-command(config-manager)' -y
    sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo -y
    sudo dnf install gh --repo gh-cli -y
}

function install_fzf() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all 
}

function main() {
    # install_fun_editors
    # install_tmux
    # install_gh
    # install_zsh
    enable_vim
    install_fzf

    printf '✅ Finished installing awesome stuff.\nRestart your shell for it to take effect\n'
}

main

