use std/util "path add"

# Config
$env.config.show_banner = false
$env.config.buffer_editor = 'nvim'
$env.config.history = {
  file_format: sqlite
  max_size: 10_000
  sync_on_enter: true
  isolation: false
}
$env.config.menus = [
  {
    name: completion_menu
    only_buffer_difference: false
    marker: ""
    type: {
      layout: ide
      border: false
      correct_cursor_pos: true
      max_completion_height: 25
    }
    style: {
      text: white
      selected_text: green_reverse
      description_text: yellow
      match_text: { attr: u }
      selected_match_text: { attr: ur }
    }
  }
]

# Path
path add "~/bin"
path add "~/.cargo/bin"
path add "~/.npm-global/bin"
if ($nu.os-info.name == "macos") {
    path add "/usr/local/bin"
    path add $"($nu.home-dir)/.nix-profile/bin"
    path add $"/etc/profiles/per-user/($env.user)/bin"
    path add "/run/current-system/sw/bin"
    path add "/nix/var/nix/profiles/default/bin"
    path add $"($nu.home-dir)/.local/share/mise/shims"
    path add "/opt/homebrew/bin/"
    path add "/opt/homebrew/opt/rustup/bin"
}

# Env vars
$env.EDITOR = $env.config.buffer_editor
$env.VISUAL = $env.config.buffer_editor
$env.PAGER = 'ov --exit-write'
$env.BAT_PAGER = 'ov --quit-if-one-screen --exit-write'
$env.FZF_DEFAULT_OPTS = "--pointer='>' --gutter=' ' --color=bg+:#30363F,fg+:white,gutter:-1,hl:#C98E56,hl+:#C98E56,pointer:#C98E56"
$env.LESS = '--mouse --wheel-lines=1'
$env.SSH_AUTH_SOCK = (gpgconf --list-dirs agent-ssh-socket | str trim)
# $env.OPENCODE_EXPERIMENTAL_LSP_TOOL = true

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

def clc [] {
    history | last 2 | get 0.command | c
}

# Need to run like this so opencode gets the proper PATH
def --wrapped oc [...passed_args] {
    let path_string = $env.PATH | str join (char esep)
    let args = if ($passed_args | is-empty) {
        "--port"
    } else {
        $passed_args | str join ' '
    }
    zsh -i -c $"export PATH='($path_string)'; opencode ($args)"
}

# Aliases
alias cat = bat --plain --paging=never
alias ff = fastfetch
alias less = bat --plain
alias ll = lsd --color always -1 --group-directories-first
alias lla = lsd --color always -lA --date relative --group-directories-first --git
alias lt = lsd --color always -A --date relative --group-directories-first --tree
alias lt2 = lsd --color always -A --date relative --group-directories-first --tree --depth 2
alias lt3 = lsd --color always -A --date relative --group-directories-first --tree --depth 3
alias mj = ~/projects/majjit/target/release/majjit
alias ns = nix-shell --command /usr/local/bin/nu
alias nsc = nix-shell ~/dotfiles/nix/shells/rust-c.nix --command /usr/local/bin/nu
alias sha = hash sha256
alias t = tms ~/scratch
alias v = nvim
alias wat = hwatch --interval 2 --differences=word --color --exec nu --login -c
alias wat1 = hwatch --interval 1 --differences=word --color --exec nu --login -c
alias wat10 = hwatch --interval 10 --differences=word --color --exec nu --login -c
alias wat5 = hwatch --interval 5 --differences=word --color --exec nu --login -c

# Jj defs
def is-jj-repo [] {
    let jj_check = jj status | complete | get exit_code
    if $jj_check != 0 {
        print "Not a jj repository"
    }
    $jj_check == 0
}

def ji [] {
    jj git init --colocate
    jj bookmark create master
}

def --wrapped jd [...args] {
    PAGER='ov' jj diff ...$args
}

# Jj aliases
alias j = jj status
alias ja = jj abandon
alias jab = jj abandon -r @-
alias jb = jj bookmark
alias jbr = jj log -r "heads(::@ & bookmarks())" --no-graph -T 'bookmarks.map(|b| b.name())'
alias jbc = jj bookmark create
alias jbl = jj bookmark list
alias jbmt = jj bookmark move --from 'heads(::@- & bookmarks())' --to @
alias jbs = jj bookmark set
alias jc = jj commit
alias jclone = jj git clone --colocate
alias jcm = jj commit -m
alias jdb = jd -r @-
alias jdr = jj describe
alias jdrb = jj describe -r @-
alias jdrm = jj describe -m
alias jdrmb = jj describe -r @- -m
alias je = jj edit
alias jeb = jj edit @-
alias jef = jj edit --ignore-immutable
alias jf = jj git fetch
alias jg = jj git
alias jjs = jj --stat
alias jl = jj log --revisions 'all()' --limit 10
alias jla = jj log --revisions 'all()'
alias jlas = jj log --revisions 'all()' --stat
alias jls = jj log --revisions 'all()' --limit 10 --stat
alias jn = jj new
alias jnb = jj new --insert-before @ --no-edit
alias jnm = jj new 'trunk()'
alias jp = jj git push
alias jrm = jj rebase -s @ -d 'trunk()'
alias js = jj squash
alias jsf = jj squash --ignore-immutable
alias jsi = jj squash --interactive
alias ju = jj undo

# Github aliases
alias pr = gh pr view --web (jbr)
alias prnew = gh pr new --head (jbr)
alias prnewdraft = gh pr new --draft --head (jbr)
alias prchecks = gh pr checks --web (jbr)
alias prready = gh pr ready (jbr)
alias prdraft = gh pr ready --undo (jbr)
alias predit = gh pr edit (jbr)
alias prcomment = gh pr comment (jbr)
alias prreview = gh pr review (jbr)
alias browse = gh browse
alias browseb = gh browse --branch (jbr)
alias repo = gh repo view --web

# Direnv
# From: https://github.com/nushell/nu_scripts/blob/main/nu-hooks/nu-hooks/direnv/config.nu
$env.config.hooks.env_change.PWD = [
  { ||
    if (which direnv | is-empty) {
        return
    }

    direnv export json | from json | default {} | load-env
    # Direnv outputs $PATH as a string, but nushell silently breaks if isn't a list-like table.
    # The following behemoth of Nu code turns this into nu's format while following the standards of how to handle quotes, use it if you need quote handling instead of the line below it:
    # $env.PATH = $env.PATH | parse --regex ('' + `((?:(?:"(?:(?:\\[\\"])|.)*?")|(?:'.*?')|[^` + (char env_sep) + `]*)*)`) | each {|x| $x.capture0 | parse --regex `(?:"((?:(?:\\"|.))*?)")|(?:'(.*?)')|([^'"]*)` | each {|y| if ($y.capture0 != "") { $y.capture0 | str replace -ar `\\([\\"])` `$1` } else if ($y.capture1 != "") { $y.capture1 } else $y.capture2 } | str join }
    $env.PATH = $env.PATH | split row (char env_sep)
  }
]

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
