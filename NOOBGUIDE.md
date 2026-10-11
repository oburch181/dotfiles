# Survival Guide

## Apply Nix Changes
* **Sync Environment:** `nix run home-manager/master -- switch --flake .#orion@ubuntu -b backup`
* **Update Packages:** `nix flake update`

## Micro (Text Editor)
* `Ctrl + S`: Save file
* `Ctrl + Q`: Quit
* `Ctrl + F`: Find
* `Ctrl + G`: Open command bar (e.g., to type 'help')

## Tmux (Terminal Multiplexer)
* `tmux`: Start a new session
* `Ctrl + b` then `%`: Split pane vertically
* `Ctrl + b` then `"`: Split pane horizontally 
* `Ctrl + b` then `Arrow Key`: Move between panes
* `Ctrl + b` then `d`: Detach (leaves it running in the background)

## Herdr (Agent Multiplexer)
* `herdr`: Start the Herdr server and interface
* *Mouse First:* You can click panes, drag borders, and right-click to split.
* *Keyboard:* Uses the exact same `Ctrl + b` prefix and shortcuts as Tmux above.