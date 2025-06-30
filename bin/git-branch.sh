#!/bin/bash

__git_branch() {
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

    if [ -n "$branch" ]; then
        echo "(${branch})"
    fi
}
