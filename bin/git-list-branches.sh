#!/usr/bin/bash
git branch --list $* | sed -E "s/^.*?\s(origin\/)?(\S+)$/\2/" | sort | uniq
