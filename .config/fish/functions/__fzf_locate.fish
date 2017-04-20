function __fzf_locate --description 'Search using locate command with fzf'
	set -q FZF_LOCATE_COMMAND
    or set -l FZF_LOCATE_COMMAND "command locate /"
    fish -c "$FZF_LOCATE_COMMAND" | __fzfcmd -m $FZF_DEFAULT_OPTS $FZF_LOCATE_OPTS | while read -l s; set selects $selects $s; end
    for select in $selects
        commandline -it -- "\"$select\""
        commandline -it -- " "
    end
    commandline -f repaint
end
