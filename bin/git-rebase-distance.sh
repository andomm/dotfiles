#!/usr/bin/bash
git log --oneline | nl | grep -vE "^\s+[0-9]+\s+[0-9a-f]+\s+fix, " -m 1 | awk '{print $1;}'
