#!/bin/bash

# Check if zplug is installed, if not, install it.
if [ ! -d ~/.zplug ]; then
    echo "Installing zplug..."
    git clone https://github.com/zplug/zplug ~/.zplug
fi

# Create or overwrite the .zshrc file.
cat > ~/.zshrc <<EOF
# >>> Z-plug >>>
source ~/.zplug/init.zsh

zplug 'romkatv/powerlevel10k', as:theme, depth:1
zplug 'zsh-users/zsh-autosuggestions'
zplug 'zsh-users/zsh-history-substring-search'
zplug 'marlonrichert/zsh-autocomplete'
zplug 'hlissner/zsh-autopair'

# plugins
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo
        zplug install
    fi
fi

zplug load
# <<< Z plug <<<

# >>> Other setting >>>
bindkey "\$terminfo[kcuu1]" history-substring-search-up
bindkey "\$terminfo[kcud1]" history-substring-search-down
SAVEHIST=1000
export HISTFILE=~/.zsh_history
setopt share_history
# case sensitive
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# zsh-autocomplete configure
# Down arrow:
bindkey '\e[B' down-line-or-select
bindkey '\eOB' down-line-or-select
# down-line-or-select:  Open completion menu.
# down-line-or-history: Cycle to next history line.
alias rm='rm -r'
alias cp='cp -r'
alias ls='ls -hlF --color=auto'
alias ..='cd ../'
alias tree="tree -alI 'node_modules|.git'"
alias grep='grep --color=always'
alias grepFind='grep --exclude-dir=node_modules -nr . -e'
alias mkdir='mkdir -p'

# <<< Other setting <<<

# >>> Powerlevel10k >>>
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh" ]]; then
  source "\${XDG_CACHE_HOME:-\$HOME/.cache}/p10k-instant-prompt-\${(%):-%n}.zsh"
fi
# To customize prompt, run \`p10k configure\` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# <<< Powerlevel10k <<<
EOF

echo "Zsh configuration and dependencies installed. Please restart your shell."
