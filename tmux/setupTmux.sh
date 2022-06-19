#!/bin/bash
SCRIPT_PATH=`readlink -f "$0"`
SCRIPT_DIR=`dirname "$SCRIPT_PATH"`
echo "$SCRIPT_DIR"
tmux new-session -d -s test
test=$(tmux list-sessions | grep TmuxSessionName)
if [ "$SESSIONEXISTS" = "" ];then
	sh $SCRIPT_DIR/createTmux.sh
else
        echo "Exitst"
fi
tmux kill-session -t test
