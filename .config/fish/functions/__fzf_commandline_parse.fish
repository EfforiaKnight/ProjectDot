function __fzf_commandline_parse --description 'Parse commandline'
    set -l commandline (string split " " (commandline))
    type -qf $commandline[1]
    if [ (count $commandline) -gt 1 -a $status -eq 0 ]
        echo $commandline[2..-1]
    else
        echo $commandline
    end
end
