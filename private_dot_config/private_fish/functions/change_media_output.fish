function change_media_output
wpctl status | sed -n '/Sinks:/,/Sources:/p' | string replace -a '├' '' | string replace -a '─' '' | string replace -a '│' '' | string replace -a '└' '' | string match -r '.*\[vol:.*' | string replace -r '\s*\[vol:.*$' '' | string replace -r '^\s*(\d+)\.' '$1\t' | string replace -r '.*?\\*.*?(\\d+).*?(\\w.*$)' '<b>$1 $2 *</b>' | string replace -r '\s+' ' ' | wofi --show=dmenu --hide-scroll --allow-markup | read -l choice; and wpctl set-default (string match -r '^\d+' "$choice")
end
