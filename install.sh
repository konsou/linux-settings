#!/usr/bin/env bash

function append_to_file_if_not_there {
  grep "${1}" "${2}" > /dev/null || echo "${1}" >> "${2}"
}

SCRIPT_DIR=$(dirname $(realpath $0))

echo "Set KONSO_SETTINGS_* env vars"
fish -c "set -Ux KONSO_SETTINGS_REPO ${SCRIPT_DIR}"
fish -c "set -Ux KONSO_SETTINGS_LAST_UPDATE $(date +\"%s\")"

echo "Install fish config file"
mkdir -p -v "${HOME}/.config/fish"
FISH_CONFIG="${HOME}/.config/fish/config.fish"
append_to_file_if_not_there "# Shared fish config" "${FISH_CONFIG}"
append_to_file_if_not_there ". ${SCRIPT_DIR}/config.fish" "${FISH_CONFIG}"

echo "Install nanorc"
NANORC_DIR="${HOME}/.config/nano"
NANORC="${NANORC_DIR=}/nanorc"
mkdir -p -v "${NANORC_DIR}"
if [[ -f "${NANORC}" ]] \
 && [[ $(readlink -f "${NANORC}") != "${SCRIPT_DIR}/nanorc" ]]
then
  echo "${NANORC} exists"
  mv -v --backup=numbered "${NANORC}" "${NANORC}.konso.bak"
fi
echo "Create nanorc symlink"
ln -svf "${SCRIPT_DIR}/nanorc" "${NANORC}"

