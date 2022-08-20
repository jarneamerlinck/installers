# tmux plugin manager

```git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm```

```tmux source ~/.tmux.conf```        update live tmux

## themes
- to install add ... to ~/.tmux.conf and PREFIX I
- add to ~/.tmux.conf all below

## List of plugins
- see dotconfig repo


```
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'git@github.com:user/plugin'
# set -g @plugin 'git@bitbucket.com:user/plugin'

set -g @plugin 'tmux-plugins/tmux-prefix-highlight'
set -g @plugin 'charlietag/tmux-themes'
set -g @theme-dark-mode 'on'
```