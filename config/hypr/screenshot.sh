#!/usr/bin/env bash
pkill slurp
sleep 0.2
area=$(slurp) || exit 0
grim -g "$area" - | wl-copy
