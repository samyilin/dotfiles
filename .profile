#!/bin/bash
# login loads this file before bashrc, so put here just in case
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.profile.bak" ]; then
        . "$HOME/.profile.bak"
    fi
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi
