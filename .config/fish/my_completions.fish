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

# Conventional commits
# https://gist.github.com/qoomon/5dfcdf8eec66a051ecd85625518cfd13
complete -c git -n '__fish_git_using_command commit' -l message -s m -r \
	-a 'feat' -d '  Commits that add, adjust or remove a new feature to the API or UI'
complete -c git -n '__fish_git_using_command commit' -l message -s m -r \
	-a 'fix' -d '  Commits that fix an API or UI bug of a preceded feat commit'
complete -c git -n '__fish_git_using_command commit' -l message -s m -r \
	-a 'refactor' -d '  Commits that rewrite or restructure code without altering API or UI behavior'
complete -c git -n '__fish_git_using_command commit' -l message -s m -r \
	-a 'perf' -d '  Commits are special type of refactor commits that specifically improve performance'
complete -c git -n '__fish_git_using_command commit' -l message -s m -r \
	-a 'style' -d '  Commits that address code style (e.g., white-space, formatting, missing semi-colons) and do not affect application behavior'
complete -c git -n '__fish_git_using_command commit' -l message -s m -r \
	-a 'test' -d '  Commits that add missing tests or correct existing ones'
complete -c git -n '__fish_git_using_command commit' -l message -s m -r \
	-a 'docs' -d '  Commits that exclusively affect documentation'
complete -c git -n '__fish_git_using_command commit' -l message -s m -r \
	-a 'build' -d '  Commits that affect build-related components such as build tools, dependencies, project version, ...'
complete -c git -n '__fish_git_using_command commit' -l message -s m -r \
	-a 'ops' -d '  Commits that affect operational aspects like infrastructure (IaC), deployment scripts, CI/CD pipelines, backups, monitoring, or recovery procedures, ...'
complete -c git -n '__fish_git_using_command commit' -l message -s m -r \
	-a 'chore' -d '  Commits that represent tasks like initial commit, modifying .gitignore, ...'
