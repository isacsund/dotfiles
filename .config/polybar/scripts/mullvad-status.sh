#!/bin/bash

MULLVAD_STATUS=$(mullvad status)
MULLVAD_SERVER=$(mullvad relay get | rev | cut -d' ' -f1 | rev)

if echo $MULLVAD_STATUS | grep -q 'Connected'; then
    echo $MULLVAD_SERVER
elif echo $MULLVAD_STATUS | grep -q 'Connecting'; then
    echo "connecting..."
else
    echo "disconnected"
fi
