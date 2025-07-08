#!/usr/bin/env bash

function append_to_file_if_not_there {
  # Grep doesn't like .* (and lots of other chars as well,
  # but we don't care about them yet)
  local escaped=$(echo "${1}" | sed "s/[*.]/\\\&/g")
  grep "${escaped}" "${2}" > /dev/null || echo "${1}" >> "${2}"
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
NANORC="${NANORC_DIR}/nanorc"
mkdir -p -v "${NANORC_DIR}"
if [[ ! -f "${SCRIPT_DIR}/nanorc" ]]; then
  cp -v "${SCRIPT_DIR}/nanorc.template" "${SCRIPT_DIR}/nanorc"
fi
if [[ -f "${NANORC}" ]] \
 && [[ $(readlink -f "${NANORC}") != "${SCRIPT_DIR}/nanorc" ]]
then
  echo "${NANORC} exists"
  mv -v --backup=numbered "${NANORC}" "${NANORC}.konso.bak"
fi
if [[ ! -f "${NANORC}" ]]; then
  echo "Create nanorc symlink"
  ln -sv "${SCRIPT_DIR}/nanorc" "${NANORC}"
fi
append_to_file_if_not_there "# Very much syntax highlighting" "${NANORC}"
append_to_file_if_not_there "include \"${SCRIPT_DIR}/nano-syntax-highlighting/*.nanorc\"" "${NANORC}"

