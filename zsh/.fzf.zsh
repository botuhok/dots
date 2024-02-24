# Setup fzf
# ---------
if [[ ! "$PATH" == */home/astat/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/astat/.fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/astat/.fzf/shell/completion.zsh"

# Key bindings
# ------------
source "/home/astat/.fzf/shell/key-bindings.zsh"
