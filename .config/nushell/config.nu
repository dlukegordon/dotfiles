use std/util "path add"

# Config
$env.config.show_banner = false
$env.config.buffer_editor = 'nvim'
$env.config.history = {
  file_format: sqlite
  max_size: 1_000_000
  sync_on_enter: true
  isolation: true
}

# Path
path add "~/bin"

# Env vars
$env.EDITOR = $env.config.buffer_editor
$env.VISUAL = $env.config.buffer_editor
$env.PAGER = 'nvimpager'
$env.FZF_DEFAULT_OPTS = "--pointer='>' --color=bg+:#30363F,fg+:white,gutter:-1,hl:#C98E56,hl+:#C98E56,pointer:#C98E56"
$env.LESS = '--mouse --wheel-lines=1'

# Defs
def la [...pattern] {
    let pattern = if ($pattern | is-empty) { 
        ["."] 
    } else { 
        $pattern | each { |p| $p | path expand }
    }
    ls -la ...$pattern | sort-by type name
}

def lad [...pattern] {
    let pattern = if ($pattern | is-empty) { 
        ["."] 
    } else { 
        $pattern | each { |p| $p | path expand }
    }
    ls -ladt ...$pattern | sort-by type name
}

def wbrl [] {
    pkill waybar; hyprctl dispatch exec waybar
}

# Aliases
alias ll = lsd --color always -1 --group-directories-first
alias lla = lsd --color always -lA --date relative --group-directories-first --git
alias lt = lsd --color always -A --date relative --group-directories-first --tree
alias lt2 = lsd --color always -A --date relative --group-directories-first --tree --depth 2
alias lt3 = lsd --color always -A --date relative --group-directories-first --tree --depth 3
alias ns = nix-shell --command nu
alias t = tms ~/scratch
alias v = nvim

# Git Defs
def is-git-repo [] {
    let git_check = git rev-parse --is-inside-work-tree | complete | get exit_code
    if $git_check != 0 {
        print "Not a git repository"
    }
    $git_check == 0
}

def git-main-branch [] {
    if (is-git-repo) == false {
        return
    }
    let branches = (git branch --format="%(refname:short)" | lines)
    if ('master' in $branches) {
        'master'
    } else {
        'main'
    }
}

def grbm [] {
    git checkout (git-main-branch); git pull; git checkout -; git rebase (git-main-branch)
}

# Git aliases
alias g = git
alias gg = git status
alias gp = git pull
alias gP = git push
alias gPf = git push --force
alias gcom = git checkout (git-main-branch)
alias gcob = git checkout -b
alias gcol = git checkout -
alias gcf = git commit --fixup HEAD
alias gcaf = git commit -a -m "fixup"
alias gdh = git diff HEAD
alias gdh1 = git diff HEAD~1
alias gdh2 = git diff HEAD~2
alias gdh3 = git diff HEAD~3
alias gdh4 = git diff HEAD~4
alias grim = git rebase -i --autosquash (git_main_branch)
alias gri2 = git rebase -i --autosquash HEAD~2
alias gri3 = git rebase -i --autosquash HEAD~3
alias gri4 = git rebase -i --autosquash HEAD~4
alias gri5 = git rebase -i --autosquash HEAD~5
alias gsu = git submodule update --init --recursive --force
alias ghh = git rev-parse HEAD

# Zoxide
zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")

# Asdf
let shims_dir = (
  if ( $env | get --ignore-errors ASDF_DATA_DIR | is-empty ) {
    $env.HOME | path join '.asdf'
  } else {
    $env.ASDF_DATA_DIR
  } | path join 'shims'
)
$env.PATH = ( $env.PATH | split row (char esep) | where { |p| $p != $shims_dir } | prepend $shims_dir )

# Prompt
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
$env.TRANSIENT_PROMPT_COMMAND = {||
    let dir = match (do -i { $env.PWD | path relative-to $nu.home-path }) {
        null => $env.PWD
        '' => '~'
        $relative_pwd => ([~ $relative_pwd] | path join)
    }

    let time = date now | format date '%I:%M%P '

    let duration = if ($env.CMD_DURATION_MS | into float) > 1000.0 {
        $" (($env.CMD_DURATION_MS | into float) / 1000.0 | math floor)s"
    } else { "" }

    let path_color = (if (is-admin) { ansi red_bold } else { ansi blue })
    let separator_color = (if (is-admin) { ansi red_bold } else { ansi blue })
    let duration_color = ansi yellow
    let character_color = ansi yellow
    let time_color = ansi dark_gray

    let path_segment = $"($time_color)($time)($path_color)($dir)($duration_color)($duration)($character_color) ❯ "

    $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
}
