function pomodoro --argument type
    set -l durations work 45 break 10
    set -l idx (contains -i -- $type $durations)

    if test -n "$idx"
        set -l minutes $durations[(math $idx + 1)]
        echo $type | lolcat
        timer {$minutes}m
        espeak "$type session done"
    end
end
