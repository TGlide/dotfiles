function bw-create-note
    function bw-create-note --argument-names content_or_name name
        if isatty stdin
            # Direct input mode
            set notes_content $content_or_name
            set note_name $name
        else
            # Pipe mode
            read -z notes_content
            set note_name $content_or_name
        end

        # If no name provided, use default
        if test -z "$note_name"
            set note_name secure-note
        end

        # If no content, show usage
        if test -z "$notes_content"
            echo "Usage: bw-create-note 'content' 'note name'"
            echo "Or: command | bw-create-note 'note name'"
            return 1
        end

        bw get template item | jq --arg folderId (bw list folders | jq -r '.[] | select(.name == "chezmoi") | .id') \
            --arg notes "$notes_content" \
            --arg name "$note_name" \
            '.type = 2 | .secureNote.type = 0 | .notes=$notes | .name = $name | .folderId=$folderId' | bw encode | bw create item
    end
end
