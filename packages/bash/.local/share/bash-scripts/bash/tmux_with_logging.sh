## Tmux + SSH --------------------------------------------------------
function withlogging_tmux() {
  tmux split-window -F "#{pane_id}" "echo -e \"\033]11;#0000FF\007\" && exec $@" \; \
       run-shell       "[ ! -d $HOME/.tmuxlog/wlog/#W/$(date +%Y-%m/%d) ] && mkdir -p $HOME/.tmuxlog/wlog/#W/$(date +%Y-%m/%d)" \; \
       pipe-pane       "cat >> $HOME/.tmuxlog/wlog/#W/$(date +%Y-%m/%d/%H%M%S.log)" \; \
}

function test_arguments() {
  echo "Arguments: $@"
}

if [[ $TERM = screen ]] || [[ $TERM = screen-256color ]] ; then
  alias wlog=withlogging_tmux
fi
