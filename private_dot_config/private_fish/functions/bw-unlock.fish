function bw-unlock
    set -Ux BW_SESSION (bw unlock --raw || echo "Error unlocking BW")
end
