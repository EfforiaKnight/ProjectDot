function __fzf_find_file
    set -l commandline (__fzf_parse_commandline)
    set -l fzf_query $commandline[2]
  set -q FZF_FIND_FILE_COMMAND
  or set -l FZF_FIND_FILE_COMMAND "command find -L \$PWD -mindepth 1 \\( -path \$PWD'*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' \\) -prune \
    -o -type f -print \
    -o -type d -print \
    -o -type l -print 2> /dev/null"
  begin
    set -lx FZF_DEFAULT_OPTS "$FZF_FIND_FILE_OPTS $FZF_DEFAULT_OPTS"
    eval "$FZF_FIND_FILE_COMMAND | "(__fzfcmd) -m --query "'$fzf_query'" | while read -l s; set selects $selects $s; end
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
