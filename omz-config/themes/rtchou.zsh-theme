autoload -U colors && colors

WHITE="%F{white}"
BLUE="%F{blue}"
CYAN="%F{cyan}"
MAGENTA="%F{magenta}"
YELLOW="%F{yellow}"
RED="%F{red}"
GREEN="%F{green}"


# Git Prompt Variables
GIT_PREFIX="[%B%F{green}±%f%F{white}"
GIT_SUFFIX="%f]"
GIT_CLEAN="%F{green}✓%f"
GIT_AHEAD="%F{cyan}▴%f"
GIT_BEHIND="%F{magenta}▾%f"
GIT_STAGED="%F{green}●%f"
GIT_UNSTAGED="%F{yellow}●%f"
GIT_UNTRACKED="%F{red}●%f"
GIT_STASHED="(%F{blue}✹%f)"
GIT_CONFLICTED="%F{red}✖%f"

# 无颜色版本的变量 (Non-Color)
GIT_PREFIX_NC="[±"
GIT_SUFFIX_NC="]"
GIT_CLEAN_NC="✓"
GIT_AHEAD_NC="▴"
GIT_BEHIND_NC="▾"
GIT_STAGED_NC="●"
GIT_UNSTAGED_NC="●"
GIT_UNTRACKED_NC="●"
GIT_STASHED_NC="(✹)"
GIT_CONFLICTED_NC="✖"

# Function to display Git information
# Accepts one argument: 'no-color' to return a non-colored string
my_git_prompt() {
  # Check if we're in a Git repository
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    return
  fi

  local branch_name=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null)
  local status_info=""

  local prefix="$GIT_PREFIX"
  local suffix="$GIT_SUFFIX"
  local clean="$GIT_CLEAN"
  local ahead="$GIT_AHEAD"
  local behind="$GIT_BEHIND"
  local staged="$GIT_STAGED"
  local unstaged="$GIT_UNSTAGED"
  local untracked="$GIT_UNTRACKED"
  local stashed="$GIT_STASHED"
  local conflicted="$GIT_CONFLICTED"

  # Check if the function was called with 'no-color' argument
  if [[ "$1" == "no-color" ]]; then
    prefix="$GIT_PREFIX_NC"
    suffix="$GIT_SUFFIX_NC"
    clean="$GIT_CLEAN_NC"
    ahead="$GIT_AHEAD_NC"
    behind="$GIT_BEHIND_NC"
    staged="$GIT_STAGED_NC"
    unstaged="$GIT_UNSTAGED_NC"
    untracked="$GIT_UNTRACKED_NC"
    stashed="$GIT_STASHED_NC"
    conflicted="$GIT_CONFLICTED_NC"
  fi

  # Check for conflicted files
  if [[ -n $(git status --porcelain | grep '^UU') ]]; then
    status_info+="$conflicted"
  fi

  # Check for staged, unstaged, and untracked files
  if [[ -n $(git diff --staged --quiet) ]]; then
    status_info+="$staged"
  fi
  if [[ -n $(git diff --quiet) ]]; then
    status_info+="$unstaged"
  fi
  if [[ -n $(git ls-files --others --exclude-standard) ]]; then
    status_info+="$untracked"
  fi

  # Check for stashed changes
  if git rev-parse --verify refs/stash >/dev/null 2>&1; then
    status_info+="$stashed"
  fi

  # Check if there are no pending changes
  if [[ -z "$status_info" ]]; then
    status_info+="$clean"
  fi

  # Check branch status (ahead/behind)
  local remote_status=$(git status -uno --porcelain -b | grep '^##')
  if [[ "$remote_status" =~ 'ahead' ]]; then
    status_info+="$ahead"
  fi
  if [[ "$remote_status" =~ 'behind' ]]; then
    status_info+="$behind"
  fi

  echo "${prefix}${branch_name} ${status_info}${suffix}"
}

Dynamic_prompt(){
  local PROMPT_1L="┌─[${MAGENTA}conda:${CONDA_DEFAULT_ENV}${WHITE}][${BLUE}%n${WHITE}@${CYAN}%m${WHITE}]"
  local PROMPT_1L_NC="┌─[conda:${CONDA_DEFAULT_ENV}][%n@%m]"
  local PROMPT_1L_NC=$(print -P "$PROMPT_1L_NC")
  local LENGTH_1L=${#PROMPT_1L_NC}

  local PROMPT_1R=$(date +"%Y-%b-%d %a %H:%M:%S")
  local PROMPT_1R_NC=$(date +"%Y-%b-%d %a %H:%M:%S")
  local LENGTH_1R=${#PROMPT_1R_NC}
  local SPACES_1R=$((COLUMNS - LENGTH_1L - LENGTH_1R))

  local PROMPT_1="${PROMPT_1L}%{$reset_color%}%{$(printf '%*s' $SPACES_1R)%}${PROMPT_1R}"

  local PROMPT_2L="├─[${YELLOW}%~${WHITE}]"
  local PROMPT_2L_NC="├─[%~]"
  local PROMPT_2L_NC=$(print -P "$PROMPT_2L_NC")
  local LENGTH_2L=${#PROMPT_2L_NC}

  local PROMPT_2R="$(my_git_prompt)"
  local PROMPT_2R_NC="$(my_git_prompt no-color)"
  local LENGTH_2R=${#PROMPT_2R_NC}
  local SPACES_2R=$((COLUMNS - LENGTH_2L - LENGTH_2R))

  local PROMPT_2="${PROMPT_2L}%{$reset_color%}%{$(printf '%*s' $SPACES_2R)%}${PROMPT_2R}"
  local PROMPT_3="└─>"
  PROMPT="${PROMPT_1}
${PROMPT_2}
${PROMPT_3}"
}

autoload -U add-zsh-hook
add-zsh-hook precmd Dynamic_prompt