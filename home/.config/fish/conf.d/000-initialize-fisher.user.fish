if not status is-interactive
    exit
end

# Initialize fisher
if not functions -q fisher
    echo "Installing fisher. . ."
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish \
        | source \
        && fisher update >/dev/null
end
