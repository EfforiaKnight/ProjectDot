### EfforiaKnight README

* Enable *italic* in tmux, run
    ```bash
    tic /path/to/xterm-256color-italic.terminfo
    ```
[Reference link](https://bruinsslot.jp/post/how-to-enable-true-color-for-neovim-tmux-and-gnome-terminal/)  
[Tmux Cheat Sheet](https://tmuxcheatsheet.com/)

* **Workaround**: Play-Pause media control doesn't work in Plasma
    - Install `playerctl`
    - Set new **shortcut** in _Custom Shortcuts_ settings
    - _New_ -> _Global Shortcut_ -> _Command/URL_
    - _Trigger_ = _Media Play_
    - _Action_ = `playerctl play-pause`
    - **Enjoy**
