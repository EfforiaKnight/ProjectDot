set -g theme_nerd_fonts yes
set -g theme_color_scheme solarized
set -g fish_prompt_pwd_dir_length 0
set -g theme_title_use_abbreviated_path no
#set -g theme_date_format "+%a %H:%M"
set -g theme_display_date no
set -x EDITOR nvim
set -x TERM xterm-256color-italic

set -x FZF_DEFAULT_COMMAND 'ag --hidden -l -g ""'

function mkd --description 'mkdir -p and cd into'
    mkdir -p $argv
    and cd $argv
end

function yt2mp3 --description 'Download from YouTube in mp3 format to my music folder'
    youtube-dl --extract-audio --audio-format mp3 -f bestaudio --ignore-errors -o "/run/media/efforia/Music/Music/%(title)s.%(ext)s" $argv
end

function mm --description 'Start listening to YouTube in CLI'
    mpv --no-video --ytdl-format=bestaudio ytdl://ytsearch10:"$argv"
end

function gcreate --description 'Create new Repository in GitHub (must define github.user with git config)'
    curl -u (git config github.user) https://api.github.com/user/repos -d "{\"name\": \"$argv[1]\",\"description\": \"$argv[2]\"}"
end
