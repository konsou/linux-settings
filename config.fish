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
  # Check updates once a day
  set update_interval 86400
  set current_timestamp (date +"%s")
  if test $current_timestamp -ge \
     (math $KONSO_SETTINGS_LAST_UPDATE + $update_interval)
    echo "Update shared settings..."
    fish -c "cd $KONSO_SETTINGS_REPO && git pull"
    set -Ux KONSO_SETTINGS_LAST_UPDATE $current_timestamp
  end

  # OTHER COMMANDS
  zoxide init fish --cmd cd | source
  fastfetch
  echo "Utils reminder: bashtop dysk htop iotop jdupes jnettop ncdu nvtop"
end

