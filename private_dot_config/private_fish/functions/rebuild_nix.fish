function rebuild_nix
    nix run home-manager/release-24.11 -- switch --flake ~/nix#thomasgl
end
