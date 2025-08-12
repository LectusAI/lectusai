#------------------------------------------------------------------------------#
# GITHUB HELPERS                                                              #
#------------------------------------------------------------------------------#

# Export GH_TOKEN into the environment
lectusGitHubExport() {
  local token
  local user 

  echo "🟢 Exporting GitHub credentials"

  # fetch github token from github cli. 
  token=$(gh auth token 2>/dev/null) || {
    echo "🔴 Could not retrieve GitHub token, run lectusGitHubLogin"
    return 1
  }

  # export token.
  export GITHUB_TOKEN=$token
  echo "🟢 Exported GITHUB_TOKEN:$GITHUB_TOKEN"

  # get user login from gh cli. 
  user=$(gh api user --jq '.login') || {
    echo "🔴 Could not get GitHub user, run lectusGitHubLogin"
    return 1
  }

  # export token.
  export GITHUB_USER=$user
  echo "🟢 Exported GITHUB_USER:$GITHUB_USER"
}

# Log in to GitHub and set up git config
lectusGitHubLogin() {

  echo "🟢 Authenticating to GitHub"

  # github cli auth.
  gh auth login -h github.com -p https -w \
    -s read:packages,write:packages,delete:packages,workflow || {
      echo "🔴 GitHub auth failed"
      return 1
    }

  # export github cli env vars. 
  lectusGitHubExport

  echo "🟢 Successfully Authenticated to GitHub"
}

# Setup Git for GItHub Cli. 
lectusGitHubSetup() {

  echo "🟢 Configureing Git for GitHub"

  # setup git auth for github cli. 
  gh auth setup-git || {
    echo "🔴 GitHub setup-git command failed"
    return 1
  }

  echo "🟢 Configureing Git User: $(gh api user --jq .name)"
  [ -z "$(git config --global user.name)" ] && \
    git config --global user.name "$(gh api user --jq .name)"
  echo "🟢 Configureing Git Email: $(gh api user --jq .notification_email)"
  [ -z "$(git config --global user.email)" ] && \
    git config --global user.email "$(gh api user --jq .notification_email)"
  echo "🟢 Configureing Git Editor: vim"
  [ -z "$(git config --global core.editor)" ] && \
    git config --global core.editor vim
  echo "🟢 Configureing Git Safe directories: *" 
  git config --global --add safe.directory '*'

  echo "🟢 GitHub configuration complete!"
}

# Update git repo remote for GitHub https pull and push. 
lectusGitHubFixRemote() {

  # update git remote. 
  git remote set-url origin "https://github.com/ajitpdevops/$REPO_NAME.git"
}