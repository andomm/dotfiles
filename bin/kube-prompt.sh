#!/bin/bash
__kube_ps1()
{
    CONTEXT=$(kubectl config current-context 2>/dev/null)

    if [ -n "$CONTEXT" ]; then
        echo "(${CONTEXT##*-})"
    fi
}
