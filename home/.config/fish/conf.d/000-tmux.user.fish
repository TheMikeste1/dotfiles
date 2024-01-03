if not status is-interactive
    exit
end

set fish_tmux_autostart false

if not tmux ls &> /dev/null
    tmux new > /dev/null
end
