function fs --description 'Switch tmux session'
	tmux list-sessions -F "#{session_name}" | __fzfcmd --reverse | xargs tmux switch-client -t
end
