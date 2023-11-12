# https://stackoverflow.com/a/18915067
function ssh-activate --description 'Start ssh-agent if not already running'
    function __start_agent
        ssh-agent | sed 's/^SSH/export SSH/' | sed 's/^echo/#echo/' > "$SSH_ENV"
        chmod 600 "$SSH_ENV"
        . "$SSH_ENV" > /dev/null
    end

    if test -f "$SSH_ENV"
        . "$SSH_ENV" > /dev/null
        ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null || begin
            __start_agent;
        end
    else
        __start_agent;
    end
end
