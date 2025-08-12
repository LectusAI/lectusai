#!/bin/bash

# AWS CLI completion
if command -v aws_completer >/dev/null 2>&1; then
  complete -C "$(command -v aws_completer)" aws
fi

# AWS profile completion
_awsprofile_completer() {
  local cur profiles
  cur="${COMP_WORDS[COMP_CWORD]}"
  profiles=$(grep '^\[profile' ~/.aws/config | sed -E 's/^\[profile (.*)\]/\1/')
  COMPREPLY=($(compgen -W "${profiles}" -- "$cur"))
}
complete -F _awsprofile_completer lectusAWSLogin
complete -F _awsprofile_completer lectusAWSProfile 

# GitHub CLI completion
if command -v gh >/dev/null 2>&1; then
  if [[ -n "$ZSH_VERSION" ]]; then
    eval "$(gh completion -s zsh)"
  else
    eval "$(gh completion -s bash)"
  fi
fi