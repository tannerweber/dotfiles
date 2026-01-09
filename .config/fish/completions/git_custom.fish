# Fish completions for git with GitHub, GitLab, and Codeberg support

# GitHub URL
complete -c git -n '__fish_seen_subcommand_from clone' -a 'https://github.com/' -d ' GitHub repository URL'
complete -c git -n '__fish_seen_subcommand_from remote add' -a 'https://github.com/' -d ' GitHub repository URL'
complete -c git -n '__fish_seen_subcommand_from remote set-url' -a 'https://github.com/' -d ' GitHub repository URL'

# GitLab URL
complete -c git -n '__fish_seen_subcommand_from clone' -a 'https://gitlab.com/' -d ' GitLab repository URL'
complete -c git -n '__fish_seen_subcommand_from remote add' -a 'https://gitlab.com/' -d ' GitLab repository URL'
complete -c git -n '__fish_seen_subcommand_from remote set-url' -a 'https://gitlab.com/' -d ' GitLab repository URL'

# Codeberg URL
complete -c git -n '__fish_seen_subcommand_from clone' -a 'https://codeberg.org/' -d ' Codeberg repository URL'
complete -c git -n '__fish_seen_subcommand_from remote add' -a 'https://codeberg.org/' -d ' Codeberg repository URL'
complete -c git -n '__fish_seen_subcommand_from remote set-url' -a 'https://codeberg.org/' -d ' Codeberg repository URL'

# SSH URL
complete -c git -n '__fish_seen_subcommand_from clone' -a 'git@github.com:' -d ' GitHub SSH URL'
complete -c git -n '__fish_seen_subcommand_from remote add' -a 'git@github.com:' -d ' GitHub SSH URL'
complete -c git -n '__fish_seen_subcommand_from remote set-url' -a 'git@github.com:' -d ' GitHub SSH URL'

complete -c git -n '__fish_seen_subcommand_from clone' -a 'git@gitlab.com:' -d ' GitLab SSH URL'
complete -c git -n '__fish_seen_subcommand_from remote add' -a 'git@gitlab.com:' -d ' GitLab SSH URL'
complete -c git -n '__fish_seen_subcommand_from remote set-url' -a 'git@gitlab.com:' -d ' GitLab SSH URL'

complete -c git -n '__fish_seen_subcommand_from clone' -a 'git@codeberg.org:' -d ' Codeberg SSH URL'
complete -c git -n '__fish_seen_subcommand_from remote add' -a 'git@codeberg.org:' -d ' Codeberg SSH URL'
complete -c git -n '__fish_seen_subcommand_from remote set-url' -a 'git@codeberg.org:' -d ' Codeberg SSH URL'

# GitHub CLI (gh)
complete -c gh -n __fish_use_subcommand -a auth -d ' Authenticate with GitHub'
complete -c gh -n __fish_use_subcommand -a repo -d ' Manage repositories'
complete -c gh -n __fish_use_subcommand -a issue -d ' Manage issues'
complete -c gh -n __fish_use_subcommand -a pr -d ' Manage pull requests'
complete -c gh -n __fish_use_subcommand -a release -d ' Manage releases'
complete -c gh -n __fish_use_subcommand -a workflow -d ' Manage GitHub Actions workflows'
complete -c gh -n __fish_use_subcommand -a clone -d ' Clone a repository'
complete -c gh -n __fish_use_subcommand -a codespace -d ' Manage GitHub Codespaces'
complete -c gh -n __fish_use_subcommand -a gists -d ' Manage gists'
complete -c gh -n __fish_use_subcommand -a search -d ' Search GitHub'
complete -c gh -n __fish_use_subcommand -a api -d ' Make API requests'

# Branch completions for push/pull
# complete -c git -n '__fish_git_is_dir_repo' -n '__fish_seen_subcommand_from push' -a $(git branch --format='%(refname:short)') -d ' Local branches'
# complete -c git -n '__fish_git_is_dir_repo' -n '__fish_seen_subcommand_from pull' -a (git branch --format='%(refname:short)') -d ' Local branches'
# complete -c git -n '__fish_git_is_dir_repo' -n '__fish_seen_subcommand_from fetch' -a (git branch --format='%(refname:short)') -d ' Local branches'
#
# # Remote
# complete -c git -n '__fish_git_is_dir_repo' -n '__fish_seen_subcommand_from push' -a (git remote) -d ' Remote repositories'
# complete -c git -n '__fish_git_is_dir_repo' -n '__fish_seen_subcommand_from pull' -a (git remote) -d ' Remote repositories'
# complete -c git -n '__fish_git_is_dir_repo' -n '__fish_seen_subcommand_from fetch' -a (git remote) -d ' Remote repositories'
