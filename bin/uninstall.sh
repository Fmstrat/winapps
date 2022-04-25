#!/usr/bin/env bash

${SUDO} rm -f "/usr/local/bin/winapps"
${SUDO} rm -rf "/usr/local/share/winapps"

grep -l -d skip "bin/winapps" "/usr/share/applications/"* |
    while read -r F; do
        echo -n "  Removing ${F}..."
        ${SUDO} rm "${F}"
        echo " Finished."
    done
grep -l -d skip "bin/winapps" "/usr/local/bin/"* |
    while read -r F; do
        echo -n "  Removing ${F}..."
        ${SUDO} rm "${F}"
        echo " Finished."
    done
