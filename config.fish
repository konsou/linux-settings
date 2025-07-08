if status is-interactive
  echo "Loading shared fish config"

  # FISH SETTINGS
  # Disable the "Welcome to fish..." text
  set -Ux fish_greeting ""

  # ALIASES
  alias .. "cd .."
  alias anacrontab "nano ~/.anacron/etc/anacrontab"
  alias cd.. "cd .."
  alias fish_config_file "nano ~/.config/fish/config.fish"
  alias ls "ls --time-style=iso --color -lh"
  alias process-list "ps aux"
  alias rtfm tldr
  alias untar "tar -xvf"
  alias upgrade-pip "python -m pip install --upgrade pip"

  # SELF UPDATE
  $KONSO_SETTINGS_REPO/update.fish

  # OTHER COMMANDS
  zoxide init fish --cmd cd | source
  fastfetch
  echo "Utils reminder: bashtop dysk htop iotop jdupes jnettop ncdu nvtop"
end

