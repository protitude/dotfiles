#
# Powerline Cyan - Tmux Theme
# Created by Jim Myhrberg <contact@jimeh.me>.
#
# Inspired by vim-powerline: https://github.com/Lokaltog/powerline
#
# Requires terminal to be using a powerline compatible font, find one here:
# https://github.com/Lokaltog/powerline-fonts
#


# Basic status bar colors
set -g status-fg colour240
set -g status-bg colour233

# Left side of status bar
set -g status-left-bg colour233
set -g status-left-fg colour243
set -g status-left-length 40
#set -g status-left "#[fg=colour232,bg=colour39,bold] ♟ #S #[fg=colour39,bg=colour240,nobold]#[fg=colour233,bg=colour240] #(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/') #[fg=colour240,bg=colour235]#[fg=colour240,bg=colour235] #I:#P #[fg=colour235,bg=colour233,nobold]"
set -g status-left "🫠"

# Right side of status bar
set -g status-right-bg colour233
set -g status-right-fg colour243
set -g status-right-length 150
set -g status-right "#[fg=colour235,bg=colour233]#[fg=colour240,bg=colour235] #(pwd)  #[fg=colour240,bg=colour235]#[fg=colour233,bg=colour240] %d-%b-%y #[fg=colour245,bg=colour240]#[fg=colour232,bg=colour245,bold] "

# Window status
set -g window-status-format "  #I:#W#F  "
set -g window-status-current-format "#[fg=colour233,bg=black]#[fg=colour81,nobold] #I:#W#F #[fg=colour233,bg=black,nobold]"

# Current window status
set -g window-status-current-bg colour39
set -g window-status-current-fg colour235

# Window with activity status
set -g window-status-activity-bg colour245 # fg and bg are flipped here due to
set -g window-status-activity-fg colour233 # a bug in tmux

# Window separator
set -g window-status-separator ""

# Window status alignment
set -g status-justify centre

# Pane border
set -g pane-border-bg default
set -g pane-border-fg colour238

# Active pane border
set -g pane-active-border-bg default
set -g pane-active-border-fg colour39

# Pane number indicator
set -g display-panes-colour colour233
set -g display-panes-active-colour colour245

# Clock mode
set -g clock-mode-colour colour39
set -g clock-mode-style 24

# Message
set -g message-bg colour39
set -g message-fg black

# Command message
set -g message-command-bg colour233
set -g message-command-fg black

# Mode
set -g mode-bg colour39
set -g mode-fg colour232

# Status update interval
set -g status-interval 1
