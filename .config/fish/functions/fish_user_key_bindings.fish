### fzf ###
if test "$FZF_LEGACY_KEYBINDINGS" -eq 1
    bind \ct '__fzf_find_file'
    bind \cr '__fzf_reverse_isearch'
    bind \ec '__fzf_cd'
    bind \eC '__fzf_cd --hidden'
    if bind -M insert >/dev/null ^/dev/null
        bind -M insert \ct '__fzf_find_file'
        bind -M insert \cr '__fzf_reverse_isearch'
        bind -M insert \ec '__fzf_cd'
        bind -M insert \eC '__fzf_cd --hidden'
    end
else
    bind \cf '__fzf_find_file'
    bind \cs '__fzf_find_file --locate'
    bind \cr '__fzf_reverse_isearch'
    bind \eo '__fzf_cd'
    bind \ei '__fzf_cd --hidden'
    if bind -M insert >/dev/null ^/dev/null
        bind -M insert \cf '__fzf_find_file'
        bind -M insert \cs '__fzf_find_file --locate'
        bind -M insert \cr '__fzf_reverse_isearch'
        bind -M insert \eo '__fzf_cd'
        bind -M insert \ei '__fzf_cd --hidden'
    end
end
### fzf ###
