#!/bin/bash

if [ "$1" = "ragent" ]; then
   su - usr1cv8 -c "/opt/1cv8/x86_64/$ENV_ONEC_VERSION/ragent -debug"
fi

exec  "$@"
