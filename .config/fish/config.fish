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
set -x TERM xterm-256color-italic
#set -x TERM screen-256color
# }

# ================ FZF ================ {
set -x FZF_DEFAULT_COMMAND 'ag --hidden --ignore .git -g ""'
set -x FZF_DEFAULT_OPTS '--inline-info'

set -x FZF_TMUX 1
set -x FZF_LEGACY_KEYBINDINGS 0

set -x FZF_FIND_FILE_COMMAND 'ag -l --hidden --ignore .git'
set -x FZF_FIND_FILE_OPTS '--history=/home/efforia/.cache/FZF_history'

set -x FZF_REVERSE_ISEARCH_OPTS '--history=/home/efforia/.cache/FZF_reverse_history'
set -x FZF_FIND_AND_EXECUTE_OPTS '--history=/home/efforia/.cache/FZF_reverse_history'

set -x FZF_CD_OPTS '--history=/home/efforia/.cache/FZF_cd_history'
set -x FZF_CD_WITH_HIDDEN_OPTS '--history=/home/efforia/.cache/FZF_cd_history'

set -x FZF_LOCATE_OPTS "--preview 'rougify {} 2>/dev/null' --header-lines=1 --preview-window hidden --bind '?:toggle-preview' --history='/home/efforia/.cache/FZF_history'"
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
    git log --oneline | fzf --multi --reverse --no-sort --ansi --border --bind 'alt-n:preview-down' --bind 'alt-p:preview-up' --preview 'git show --color=always {+1}'
end
# }
