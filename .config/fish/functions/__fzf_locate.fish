function __fzf_locate --description 'Search using locate command with fzf. Edit file with Ctrl+e'
    set -q FZF_LOCATE_COMMAND
    or set -l FZF_LOCATE_COMMAND "command locate /"
    fish -c "$FZF_LOCATE_COMMAND" | fzf +m --bind "ctrl-e:execute($EDITOR {})+abort" $FZF_LOCATE_OPTS $FZF_DEFAULT_OPTS
end
