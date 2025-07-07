#!/usr/bin/env bash

SCRIPT_PATH=$(realpath $0)
SCRIPT_DIR=$(dirname $SCRIPT_PATH)

# Set repo path for updater in fish config
fish -c "set -Ux KONSO_SETTINGS_REPO ${SCRIPT_DIR}"
fish -c "set -Ux KONSO_SETTINGS_LAST_UPDATE $(date +\"%s\")"

echo "Install fish config file"
mkdir -p -v "${HOME}/.config/fish"
FISH_CONFIG="${HOME}/.config/fish/config.fish"
# Remove duplicates
# TODO: trim blank lines
sed -i "s;# Shared fish config;;g" "${FISH_CONFIG}"
sed -i "s;. ${SCRIPT_DIR}/config.fish;;g" "${FISH_CONFIG}"
echo "" >> "${FISH_CONFIG}"
echo "# Shared fish config" >> "${FISH_CONFIG}"
echo ". ${SCRIPT_DIR}/config.fish" >> "${FISH_CONFIG}"
