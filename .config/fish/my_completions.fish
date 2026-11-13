# Fish completions for git with GitHub, GitLab, and Codeberg support

function git_url_comp -a url desc
    complete -c git \
        -n '__fish_seen_subcommand_from clone' -a $url -d $desc
    complete -c git \
        -n '__fish_seen_subcommand_from remote' \
        -n '__fish_seen_subcommand_from add' -a $url -d $desc
    complete -c git \
        -n '__fish_seen_subcommand_from remote' \
        -n '__fish_seen_subcommand_from set-url' -a $url -d $desc
end

# GitHub
git_url_comp 'https://github.com/' ' GitHub repository URL'
git_url_comp 'git@github.com:' ' GitHub SSH URL'

# GitLab
git_url_comp 'https://gitlab.com/' ' GitLab repository URL'
git_url_comp 'git@gitlab.com:' ' GitLab SSH URL'

# Codeberg
git_url_comp 'https://codeberg.org/' ' Codeberg repository URL'
git_url_comp 'git@codeberg.org:' ' Codeberg SSH URL'

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
