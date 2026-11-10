eval "$(starship init bash)"

if [[ $- == *i* && "$TERM" == "xterm-kitty" ]]; then
  fastfetch
fi
