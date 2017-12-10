function __fzf_locate --description 'Search using locate command with fzf'
  set -l commandline (__fzf_parse_commandline)
  set -l fzf_query $commandline[2]
  set -q FZF_LOCATE_COMMAND
  or set -l FZF_LOCATE_COMMAND "command locate /"
  begin
    set -lx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS $FZF_LOCATE_OPTS"
    eval "$FZF_LOCATE_COMMAND | "(__fzfcmd) -m  --query "'$fzf_query'" | while read -l s; set selects $selects $s; end
  end
  if [ -z "$selects" ]
    commandline -f repaint
    return
  else
    # Remove last token from commandline.
    commandline -t ""
  end
  for select in $selects
    commandline -it -- (string escape $select)
    commandline -it -- ' '
  end
  commandline -f repaint
end
