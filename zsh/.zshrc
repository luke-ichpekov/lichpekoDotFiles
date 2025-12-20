
# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zshrc.pre.zsh"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh
export BRAZIL_WORKSPACE_DEFAULT_LAYOUT=short

export AUTO_TITLE_SCREENS="NO"


# if you wish to use IMDS set AWS_EC2_METADATA_DISABLED=false
export AWS_EC2_METADATA_DISABLED=true

export PROMPT="
%{$fg[white]%}(%D %*) <%?> [%~] $program %{$fg[default]%}
%{$fg[cyan]%}%m %#%{$fg[default]%} "

export RPROMPT=

set-title() {
echo -e "\e]0;$*\007"
}

ssh() {
	set-title $*;
	/usr/bin/ssh -2 $*;
	set-title $HOST;
}

alias e=emacs
alias bb=brazil-build

alias bba='brazil-build apollo-pkg'
alias bre='brazil-runtime-exec'
alias brc='brazil-recursive-cmd'
alias bws='brazil ws'
alias bwsuse='bws use -p'
alias bwscreate='bws create -n'
alias brc=brazil-recursive-cmd
alias bbr='brc brazil-build'
alias bball='brc --allPackages'
alias bbb='brc --allPackages brazil-build'
alias bbra='bbr apollo-pkg'
alias auth='expect ~/.midway_auth.exp'
alias ops='cd /workplace/lichpeko/ProductUIService/src/ProductUIOpsTools'
#alias tmux='/apollo/env/envImprovement/bin/tmux'
#alias a='/apollo/env/envImprovement/bin/tmux attach'
export PATH=$HOME/.local/bin:$HOME/.toolbox/bin:$PATH
autoload -Uz compinit && compinit

# Set up mise for runtime management
eval "$(/home/lichpeko/.local/bin/mise activate zsh)"
source ~/.local/share/mise/completions.zsh
source /home/lichpeko/.brazil_completion/zsh_completion
alias finch='sudo HOME=/home/lichpeko DOCKER_CONFIG=/home/lichpeko/.docker finch'
alias pui="source $HOME/working_scripts/new-pui-workspace"


export HISTSIZE=5000
export SAVEHIST=5000
export HISTFILE=$HOME/.zsh/zshhistory

# Auto-start tmux on SSH login
t() {
	if [[ -f ~/.tmux_auto ]]; then
		rm ~/.tmux_auto
		echo "Tmux auto-connect disabled"
	else
		touch ~/.tmux_auto
		echo "Tmux auto-connect enabled"
	fi
}

if [[ -n "$SSH_CONNECTION" ]] && [[ -z "$TMUX" ]] && [[ -f ~/.tmux_auto ]]; then
	/usr/local/bin/tmux attach-session -t default || /usr/local/bin/tmux new-session -s default
fi
# File-based clipboard aliases
alias tcopy='tee ~/.clipboard'
alias tpaste='cat ~/.clipboard'


# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/.local/share/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/.local/share/kiro-cli/shell/zshrc.post.zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey "ç" fzf-cd-widget

fzf-and-run-widget() {
fzf-history-widget
zle accept-line
}
zle     -N   fzf-and-run-widget
bindkey '^R' fzf-and-run-widget
bindkey -M emacs '\C-e' fzf-cd-widget
bindkey -M vicmd '\C-e' fzf-cd-widget
bindkey -M viins '\C-e' fzf-cd-widget
export FZF_DEFAULT_OPTS='
--preview "tree -L 1 -C {} | head -200"
--preview-window=right:50%
'

cd_up_fzf() {
  local parts dir
  parts=()
  dir="/"
  for p in ${(s:/:)PWD}; do
    [[ -n "$p" ]] || continue
    dir="$dir$p"
    parts+=("$dir")
    dir="$dir/"
  done

  dir=$(printf "%s\n" "${parts[@]}" | fzf) || return
  cd "$dir"
  zle reset-prompt
}

zle -N cd_up_fzf
bindkey '^F' cd_up_fzf

