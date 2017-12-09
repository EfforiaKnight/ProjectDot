function __fzf_reverse_isearch
  begin
    set -lx FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_REVERSE_ISEARCH_OPTS +m"
    history -z | eval (__fzfcmd) --read0 -q '(commandline)' | perl -pe 'chomp if eof' | read -lz result
    and commandline -- $result
  end
  commandline -f repaint
end
