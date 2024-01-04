if not status is-interactive
    exit
end

set fish_tmux_autostart false

# Automatically connect to the session
set sessions $(tmux ls -F "#{session_name}:#{session_attached}" 2> /dev/null)
for s in $sessions
    set parts $(string split ':' $s)
    if [ $parts[1] = "default" ]
        set default_session_state $parts[2]
        break
    end
end

if not set -q default_session_state # Session does not exist
    tmux new -s "default" > /dev/null
else if [ $default_session_state = "0" ] # Session exists but is not attatched
    tmux attach -t "default"
end
