# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"
export PATH=$HOME/.toolbox/bin:$PATH
# Set up mise for runtime management

eval "$(mise activate zsh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
# Set up mise for runtime management
source /Users/lichpeko/.brazil_completion/zsh_completion

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

alias bb=brazil-build
export ANDROID_HOME="${HOME}/Library/Android/sdk";
export ANDROID_SDK_ROOT=${ANDROID_HOME};
export PATH=${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools;
alias cloud-old="ssh dev-dsk-lichpeko-2b-21af62f0.us-west-2.amazon.com"
alias cloud="ssh dev-dsk-lichpeko-2b-298f6fa9.us-west-2.amazon.com"
alias auth="expect ~/.midway_auth.exp"
alias view="cd /Users/lichpeko/DONOTDELETE/productUIView/src"
source $HOME/.cardcli_profile
autoload -Uz compinit && compinit

export HISTSIZE=5000
export SAVEHIST=5000
export HISTFILE=$HOME/.zsh/zshhistory

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
t() {
    if [[ -f ~/.tmux_auto ]]; then
        rm ~/.tmux_auto
        echo "Tmux auto-connect disabled"
    else
        touch ~/.tmux_auto
        echo "Tmux auto-connect enabled"
    fi
}

if [[ -z "$TMUX" ]] && [[ -f ~/.tmux_auto ]]; then
tmux attach -t main || tmux new -s main
fi


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey "ç" fzf-cd-widget


fzf-and-run-widget() {
fzf-history-widget
zle accept-line
}
zle     -N   fzf-and-run-widget
bindkey '^R' fzf-and-run-widget


fzf-history-insert() {
  fzf-history-widget
}
zle -N fzf-history-insert
bindkey '^P' fzf-history-insert

bindkey -M emacs '\C-e' fzf-cd-widget
bindkey -M vicmd '\C-e' fzf-cd-widget
bindkey -M viins '\C-e' fzf-cd-widget
export FZF_DEFAULT_OPTS='
--preview "tree -L 1 -C {} | fold -s -w 80"
--preview-window=right:50%
'


eval "$(zoxide init zsh)"
zi-widget() {
  zle -I
  zi
}
zle -N zi-widget
bindkey '^F' zi-widget
