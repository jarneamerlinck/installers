tmux new-session -d -s TmuxSessionName \; \
	rename-window -t 0 Overview \; \
	split-window -v -p 50 \; \
	select-pane -t 1 \; \
	split-window -h -p 50 \;\
	select-pane -t 0 \; \
	split-window -h -p 50 \;\
	select-pane -t 0 \;\
	send-keys 'zsh' C-m \; \
	select-pane -t 1 \;\
	send-keys 'zsh' C-m \; \
	select-pane -t 2 \;\
	send-keys 'zsh' C-m \; \
	select-pane -t 3 \;\
	send-keys 'zsh' C-m \; \

