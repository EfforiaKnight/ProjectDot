function __fzf_find_file
    set -l fzf_query (__fzf_commandline_parse)

    set -l options  "l/locate"

    argparse $options -- $argv

    set -l COMMAND

    set -q FZF_FIND_FILE_COMMAND
    or set -l FZF_FIND_FILE_COMMAND "command find -L \$PWD -mindepth 1 \\( -path \$PWD'*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' \\) -prune \
        -o -type f -print \
        -o -type d -print \
        -o -type l -print 2> /dev/null"

    set -q FZF_LOCATE_COMMAND
    or set -l FZF_LOCATE_COMMAND "command locate /"        

    if set -q _flag_locate
        set COMMAND $FZF_LOCATE_COMMAND
    else
        set COMMAND $FZF_FIND_FILE_COMMAND
    end

    set -lx FZF_DEFAULT_OPTS "$FZF_FIND_FILE_OPTS $FZF_DEFAULT_OPTS"
    eval "$COMMAND | "(__fzfcmd) -m --query "'$fzf_query'" | while read -l s; set selects $selects $s; end

    if not test -z "$select"
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
