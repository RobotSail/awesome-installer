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

    echo 'export GIT_EDITOR=vim' >> ~/.bashrc
    echo 'export GIT_EDITOR=vim' >> ~/.zshrc

    # set visual mode
    echo 'export VISUAL=vim' >> ~/.bashrc
    echo 'export EDITOR="${VISUAL}"'  >> ~/.bashrc
    echo 'export VISUAL=vim' >> ~/.zshrc
    echo 'export EDITOR="${VISUAL}"'  >> ~/.zshrc



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



########################################
# Installs VSCode as a CLI - specific
# to Fedora currently.
########################################
function install_vscode() {
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc -y
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
    dnf check-update -y
    sudo dnf install -y code # or code-insiders
    # setup vscode server
}

function main() {
    install_fun_editors
    install_tmux
    install_gh
    install_zsh
    enable_vim
    install_fzf

    printf '✅ Finished installing awesome stuff.\nRestart your shell for it to take effect\n'
}

main

