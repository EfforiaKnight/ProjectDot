function __fzf_cd
  set -q FZF_CD_COMMAND
  or set -l FZF_CD_COMMAND "
  command find -L . \\( -path '*/\\.*' -o -fstype 'dev' -o -fstype 'proc' \\) -prune \
  -o -type d -print 2> /dev/null | sed 1d | cut -b3-"
  begin
    set -lx FZF_DEFAULT_OPTS "$FZF_CD_OPTS $FZF_DEFAULT_OPTS"
    # Fish hangs if the command before pipe redirects (2> /dev/null)
    eval "$FZF_CD_COMMAND | "(__fzfcmd) -m  --query '(commandline)' | read -l select
    if [ -n "$select" ]
      cd "$select"
      commandline -t ""
    end
  end
  commandline -f repaint
end
