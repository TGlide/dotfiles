function reload-env
    for line in (grep -v '^#' /etc/environment | grep '=')
        set -l pair (string split -m 1 '=' $line)
        set -gx $pair[1] $pair[2]
    end
end
