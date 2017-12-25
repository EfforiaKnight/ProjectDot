#  ================ EfforiaKnight ================
#  ================ Modeline and Notes ================ {
# vim: foldmarker={,} foldmethod=marker foldlevel=0:
# }

# ================ Theme and Terminal ================ {
set -g theme_nerd_fonts yes
set -g theme_color_scheme solarized
set -g fish_prompt_pwd_dir_length 0
set -g theme_title_use_abbreviated_path no
#set -g theme_date_format "+%a %H:%M"
set -g theme_display_date no
set -x EDITOR nvim
set -x TERM xterm-256color
#set -x TERM screen-256color

# Set better LS_Colors
set -gx LS_COLORS (echo (dircolors -c ~/.dircolors/dircolors.256dark | string split ' ')[3] |string split "'")[2]

# Configuration of [ https://github.com/decors/fish-colored-man ]
# Solarized Dark theme of man pages
if type -q fisher; and fisher ls |grep colored-man > /dev/null
    set -g man_blink -o red
    set -g man_bold -o green
    set -g man_standout -u af0000
    set -g man_underline -u 93a1a1
end
# }

# ================ Alias================ {
alias rm='echo "Use trash instead of rm."; false'
# }

# ================ FZF ================ {
## FZF Defaults {
# ---------------------------------------------------------------------------------
set -x FZF_DEFAULT_COMMAND "rg \
    --files \
    --smart-case \
    --no-ignore \
    --hidden \
    --follow \
    --no-messages \
    --glob '!.git/*' \
    "

set -x FZF_DEFAULT_OPTS " \
    --inline-info \
    --reverse \
    --bind 'ctrl-alt-j:down,ctrl-alt-k:up' \
    "

set -x FZF_TMUX 1
set -x FZF_LEGACY_KEYBINDINGS 0
## }

## FZF Find command {
# ---------------------------------------------------------------------------------
set -x FZF_FIND_FILE_COMMAND "rg \
    --files \
    --smart-case \
    --no-ignore \
    --hidden \
    --follow \
    --no-messages \
    --glob '!.git/*' \
    "

set -x FZF_FIND_FILE_OPTS " \
    --preview 'rougify {} 2>/dev/null' \
    --preview-window right:60%:hidden \
    --bind 'ctrl-e:execute(tmux split-window -fh nvim {})' \
    --bind 'ctrl-o:execute(open {})' \
    --bind 'alt-n:preview-down' \
    --bind 'alt-p:preview-up' \
    --bind '?:toggle-preview' \
    --history='/home/efforia/.cache/FZF_history' \
    "
## }

## FZF Historty {
# ---------------------------------------------------------------------------------
set -x FZF_REVERSE_ISEARCH_OPTS '--history=/home/efforia/.cache/FZF_reverse_history'
set -x FZF_FIND_AND_EXECUTE_OPTS '--history=/home/efforia/.cache/FZF_reverse_history'
## }

## FZF cd command {
# ---------------------------------------------------------------------------------
set -x FZF_CD_OPTS '--history=/home/efforia/.cache/FZF_cd_history'
set -x FZF_CD_WITH_HIDDEN_OPTS '--history=/home/efforia/.cache/FZF_cd_history'
## }

## FZF Locate command {
# ---------------------------------------------------------------------------------
set -x FZF_LOCATE_OPTS " \
    --preview 'rougify {} 2>/dev/null' \
    --preview-window right:60%:hidden \
    --bind 'ctrl-e:execute(tmux split-window -fh nvim {})' \
    --bind 'ctrl-o:execute(open {})' \
    --bind 'alt-n:preview-down' \
    --bind 'alt-p:preview-up' \
    --bind '?:toggle-preview' \
    --history='/home/efforia/.cache/FZF_history' \
    "
## }

## FZF Color Theme {
# ---------------------------------------------------------------------------------
function gen_fzf_default_opts --description "Solarized theme for fzf"
    set -l color00 '#002b36'
    set -l color01 '#073642'
    set -l color02 '#586e75'
    set -l color03 '#657b83'
    set -l color04 '#839496'
    set -l color05 '#93a1a1'
    set -l color06 '#eee8d5'
    set -l color07 '#fdf6e3'
    set -l color08 '#dc322f'
    set -l color09 '#cb4b16'
    set -l color0A '#b58900'
    set -l color0B '#859900'
    set -l color0C '#2aa198'
    set -l color0D '#268bd2'
    set -l color0E '#6c71c4'
    set -l color0F '#d33682'

    set -x FZF_DEFAULT_OPTS " \
        $FZF_DEFAULT_OPTS \
        --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D \
        --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C \
        --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D \
    "
end

# Set default fzf opts
gen_fzf_default_opts
## }
# }

# ================ virtualfish ================ {
eval (python -m virtualfish auto_activation global_requirements)
# }

# ================ Functions ================ {
function mkd --description 'mkdir -p and cd into'
    mkdir -p $argv
    and cd $argv
end

function yt2mp3 --description 'Download from YouTube in mp3 format to my music folder'
    youtube-dl --extract-audio --audio-format mp3 -f bestaudio --ignore-errors -o "'/run/media/efforia/Music/Music/%(title)s.%(ext)s" $argv
end

function mm --description 'Start listening to YouTube in CLI'
    mpv --no-video --ytdl-format=bestaudio ytdl://ytsearch10:"$argv"
end

function gcreate --argument-names name description --description 'Create new Repository in GitHub {Name} {Description} (must define github.user with git config)'
    if test -n $name -a -n $description 2> /dev/null
        curl -u (git config github.user) https://api.github.com/user/repos -d "{\"name\": \"$name\",\"description\": \"$description\"}"
    else
        echo Please provide name and description of the branch!
    end
end

function glog --description 'Git log with fzf node'
    git log --color --pretty=format:'%Cred%h%Creset -%C(auto)%d% %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit | fzf --ansi --multi --reverse --no-sort --preview-window right:70%:hidden --bind 'alt-n:preview-down,alt-p:preview-up,?:toggle-preview' --preview 'git show --color=always {+1}'
end

function gcd --description 'Go to a path relative to the top directory of the current git worktree'
    set -l topdir (git rev-parse --show-toplevel 2> /dev/null)
    if test $status -ne 0
        return 1
    end
    cd "$topdir/$argv"
end
# }
