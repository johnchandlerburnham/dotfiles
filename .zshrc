source ~/.config/zsh/antigen.zsh

antigen use oh-my-zsh

antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship

antigen bundle git
antigen bundle vi-mode
antigen bundle bower
antigen bundle common-aliases
antigen bundle dirhistory
antigen bundle node
antigen bundle npm
antigen bundle python
antigen bundle pass
antigen bundle ssh-agent
antigen bundle systemd
antigen bundle tmux
antigen bundle web-search
antigen bundle wd 

antigen bundle joel-porquet/zsh-dircolors-solarized.git

antigen apply


#SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_USER_SHOW=always
SPACESHIP_HOST_SHOW=always

SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_DIR_TRUNC=0

SPACESHIP_CHAR_PREFIX="Λ "

SPACESHIP_VI_MODE_SHOW=true
SPACESHIP_VI_MODE_COLOR=blue
SPACESHIP_VI_MODE_INSERT="\033[32;1;1mI\033[0m"
SPACESHIP_VI_MODE_NORMAL="\033[31;1mN\033[0m"
export KEYTIMEOUT=1

SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  exec_time     # Execution time
  vi_mode       # Vi-mode indicator
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
bindkey -v
# End of lines configured by zsh-newuser-install
