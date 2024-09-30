#!/bin/bash
# pipe to less and keep the same layout as with the pipe
# TODO: not finished yet
rg --heading --color=always --line-number $1 $2 | less -R
