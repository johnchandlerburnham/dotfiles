set -x _JAVA_AWT_WM_NONREPARENTING 1
set -gx PATH $PATH $HOME/.local/bin
set -gx PATH $PATH $HOME/.npm-global/bin
set -x EDITOR nvim
alias e=nvim

set -g fish_key_bindings fish_vi_key_bindings
set -g pure_symbol_prompt "Λ"
set -g pure_symbol_reverse_prompt "∀"
set pure_color_primary brblue
set pure_color_info blue
set pure_color_success normal
set pure_color_mute  green
set pure_color_danger red
