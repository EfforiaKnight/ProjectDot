# Defined in /tmp/fish.ZJwDvJ/t.fish @ line 2
function t --description 'Start default tmux'
	set -l WHOAMI (whoami)
    if tmux has-session -t $WHOAMI 2>/dev/null
        tmux attach-session -t $WHOAMI 2>/dev/null
    else
        tmux new-session -s $WHOAMI 2>/dev/null
    end
end
