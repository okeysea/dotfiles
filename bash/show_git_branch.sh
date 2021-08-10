function parse_git_branch {
  # git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [ᚠ \1]/'
}

function promps_bash {
  local BLUE="\[\e[1;34m\]"
  local RED="\[\e[1;31m\]"
  local GREEN="\[\e[1;32m\]"
  local WHITE="\[\e[00m\]"
  local GRAY="\[\e[1;37m\]"

  local BRANCH="\[\e[1;35m\]"

  case $TERM in
    xterm*) TITLEBAR='\[\e]0;\W\007\]';;
    *)      TITLEBAR="";;
  esac
  local BASE="\u@\h"
  PS1="${TITLEBAR}${GREEN}${BASE}${WHITE}:${BLUE}\w${BRANCH}\$(parse_git_branch)${BLUE}\$${WHITE} "
}

function promps_zsh {
  local BLUE=$'%{\e[1;34m%}'
  local RED=$'%{\e[1;31m%}'
  local GREEN=$'%{\e[1;32m%}'
  local WHITE=$'%{\e[00m%}'
  local GRAY=$'%{\e[1;37m%}'

  local BRANCH=$'%{\e[1;35m%}'

  case $TERM in
    xterm*) TITLEBAR=$'%{\e]0;\W\007%}';;
    *)      TITLEBAR="";;
  esac
  local BASE="%n@%m"

  DISABLE_AUTO_TITLE=true
  setopt PROMPT_SUBST
  PROMPT="${TITLEBAR}${GREEN}${BASE}${WHITE}:${BLUE}%c${BRANCH}\$(parse_git_branch)${BLUE}\$${WHITE} "
}

if [ -n "${BASH_VERSION-}" ]; then
  promps_bash
elif [ -n "${ZSH_VERSION-}" ]; then
  promps_zsh
fi
