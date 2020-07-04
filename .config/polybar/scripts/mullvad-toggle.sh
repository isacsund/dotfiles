#!/bin/bash

if [ "$(mullvad status)" = 'Tunnel status: Disconnected' ]; then
    mullvad connect &>/dev/null
else
    mullvad disconnect &>/dev/null
fi
