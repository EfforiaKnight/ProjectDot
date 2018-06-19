function __fzf_cd -d "Change directory"
    set -l options  "h/hidden"

    argparse $options -- $argv

    set -l COMMAND

    set -q FZF_CD_COMMAND
    or set -l FZF_CD_COMMAND "
    command find -L . \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | sed 1d | cut -b3-"

    set -q FZF_CD_WITH_HIDDEN_COMMAND
    or set -l FZF_CD_WITH_HIDDEN_COMMAND "
    command find -L . \
    \\( -path '*/\\.git*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | sed 1d | cut -b3-"

    if set -q _flag_hidden
        set COMMAND $FZF_CD_WITH_HIDDEN_COMMAND
    else
        set COMMAND $FZF_CD_COMMAND
    end

    set -lx FZF_DEFAULT_OPTS "$FZF_CD_OPTS $FZF_DEFAULT_OPTS"
    eval "$COMMAND | "(__fzfcmd) +m  --query '(commandline)' | read -l select

    if not test -z "$select"
        cd "$select"

        # Remove last token from commandline.
        commandline -t ""
    end

    commandline -f repaint
end
