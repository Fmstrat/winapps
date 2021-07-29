#!/usr/bin/env bash

${SUDO} rm -f "/usr/local/bin/winapps"
${SUDO} rm -rf "/usr/local/share/winapps"
for F in $(grep -l -d skip "bin/winapps" "/usr/share/applications/"*); do
    echo -n "  Removing ${F}..."
    ${SUDO} rm "${F}"
    echo " Finished."
done
for F in $(grep -l -d skip "bin/winapps" "/usr/local/bin/"*); do
    echo -n "  Removing ${F}..."
    ${SUDO} rm "${F}"
    echo " Finished."
done
