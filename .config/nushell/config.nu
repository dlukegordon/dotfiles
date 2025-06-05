use std/util "path add"

# Config
$env.config.show_banner = false
$env.config.buffer_editor = 'nvim'
$env.config.history = {
  file_format: sqlite
  max_size: 1_000_000
  sync_on_enter: true
  isolation: false
}

# Path
path add "~/bin"
path add "~/.cargo/bin"

# Env vars
$env.EDITOR = $env.config.buffer_editor
$env.VISUAL = $env.config.buffer_editor
$env.PAGER = 'ov --quit-if-one-screen --exit-write'
$env.BAT_PAGER = 'ov --quit-if-one-screen --exit-write'
$env.FZF_DEFAULT_OPTS = "--pointer='>' --color=bg+:#30363F,fg+:white,gutter:-1,hl:#C98E56,hl+:#C98E56,pointer:#C98E56"
$env.LESS = '--mouse --wheel-lines=1'
$env.SSH_AUTH_SOCK = (gpgconf --list-dirs agent-ssh-socket | str trim)

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
    pkill waybar
    hyprctl dispatch exec waybar
}
def wbrln [] {
    pkill waybar
    niri msg action spawn -- waybar
}

def c [input?: string] {
    if $input != null {
        wl-copy $input
    } else {
        wl-copy $in
    }
}

def p [] {
    wl-paste
}

def clc [] {
    history | last 2 | get 0.command | c
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
alias less = bat --plain
alias cat = bat --plain --paging=never
alias wat = hwatch --interval 2 --differences=word --color --exec nu --login -c
alias wat1 = hwatch --interval 1 --differences=word --color --exec nu --login -c
alias wat5 = hwatch --interval 5 --differences=word --color --exec nu --login -c
alias wat10 = hwatch --interval 10 --differences=word --color --exec nu --login -c

# Git defs
def is-git-repo [] {
    let git_check = git rev-parse --is-inside-work-tree | complete | get exit_code
    if $git_check != 0 {
        print "Not a git repository"
    }
    $git_check == 0
}

def git-trunk-branch [] {
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
    git checkout (git-trunk-branch); git pull; git checkout -; git rebase (git-trunk-branch)
}

# Git aliases
alias g = git
alias gc = git commit
alias gs = git status
alias gl = git pull
alias gp = git push
alias gpf = git push --force
alias gaa = git add -A
alias gd = git diff
alias gcom = git checkout (git-trunk-branch)
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

# Jj defs
def is-jj-repo [] {
    let jj_check = jj status | complete | get exit_code
    if $jj_check != 0 {
        print "Not a jj repository"
    }
    $jj_check == 0
}

def jj-trunk-bookmark [] {
    let bookmarks = jj bookmark list -T name | lines
    let has_master = "master" in bookmarks
    let has_main = "main" in bookmarks
    if $has_main and not $has_master {
        "main"
    } else {
        "master"
    }
}

def --wrapped jd [...args] {
    PAGER='ov' jj diff ...$args
}

# Jj aliases
alias j = jj status
alias jl = jj log --revisions 'all()' --limit 10
alias jla = jj log --revisions 'all()'
alias jr = jj describe
alias jrm = jj describe -m
alias jrb = jj describe -r @-
alias jrmb = jj describe -r @- -m
alias je = jj edit
alias jef = jj edit --ignore-immutable
alias jeb = jj edit @-
alias jdb = jd -r @-
alias jn = jj new
alias jnm = jj new (jj-trunk-bookmark)
alias jnb = jj new --insert-before @ --no-edit
alias js = jj squash
alias jsf = jj squash --ignore-immutable
alias jsi = jj squash --interactive
alias jg = jj git
alias jf = jj git fetch
alias jp = jj git push
alias jb = jj bookmark
alias jbl = jj bookmark list
alias jbc = jj bookmark create
alias jbs = jj bookmark set
alias jm = jj bookmark set (jj-trunk-bookmark) --revision @
alias jmb = jj bookmark set (jj-trunk-bookmark) --revision @-
alias ja = jj abandon
alias jab = jj abandon -r @-
alias ju = jj undo
alias jc = jj commit
alias jcm = jj commit -m
alias jclone = jj git clone --colocate
alias lj = lazyjj --revisions 'all()'

# Asdf
let shims_dir = (
  if ( $env | get --ignore-errors ASDF_DATA_DIR | is-empty ) {
    $env.HOME | path join '.asdf'
  } else {
    $env.ASDF_DATA_DIR
  } | path join 'shims'
)
$env.PATH = ( $env.PATH | split row (char esep) | where { |p| $p != $shims_dir } | prepend $shims_dir )

# Zoxide
zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")

# Carapace
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
carapace _carapace nushell | save -f ($nu.data-dir | path join "vendor/autoload/carapace.nu")

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
