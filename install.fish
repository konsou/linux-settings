#!/usr/bin/env fish
# TODO: WORK IN PROGRESS

function append_to_file_if_not_there -a string file
  # Grep doesn't like .* (and lots of other chars as well,
  # but we don't care about them yet)
  set escaped $(echo "$string" | sed "s/[*.]/\\\&/g")
  grep "$escaped" "$file" > /dev/null || echo "$string" >> "$file"
end

set SCRIPT_DIR (realpath (status dirname))

echo "Set KONSO_SETTINGS_* env vars"
set -Ux KONSO_SETTINGS_REPO $SCRIPT_DIR
set -Ux KONSO_SETTINGS_LAST_UPDATE $(date +\"%s\")

echo "Set other env vars"
set -Ux EDITOR $(which micro)
fish_add_path $SCRIPT_DIR/scripts

if not test "$SHELL" = "$(which fish)"
  echo "Set fish as default shell"
  chsh -s $(which fish)
else
  echo "Fish is already the default shell"
end

echo "Install fish config"
set FISH_CONFIG_DIR "$HOME/.config/fish"
set FISH_CONFIG_FILE "$FISH_CONFIG_DIR/config.fish"
set FISH_PROMPT_FILE "$FISH_CONFIG_DIR/functions/fish_prompt.fish"
mkdir -p -v "$FISH_CONFIG_DIR/functions"  # Creates the parent config dir as well
append_to_file_if_not_there "# Shared fish config" "$FISH_CONFIG_FILE"
append_to_file_if_not_there ". $SCRIPT_DIR/config.fish" "$FISH_CONFIG_FILE"

# path is --> file exists
if path is "$FISH_PROMPT_FILE"
  if test $(path resolve "$FISH_PROMPT_FILE") !=                         "$SCRIPT_DIR/fish_prompt.fish"
    echo "$FISH_PROMPT_FILE exists, moving it aside with .konso.bak extension"
    mv -v --backup=numbered "$FISH_PROMPT_FILE" "$FISH_PROMPT_FILE.konso.bak"
  end
end
if not path is "$FISH_PROMPT_FILE"
  echo "Create fish prompt file symlink"
  ln -sv "$SCRIPT_DIR/fish_prompt.fish" "$FISH_PROMPT_FILE"
end
