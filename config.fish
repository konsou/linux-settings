if status is-interactive
  echo "Loading shared fish config"

  # ALIASES
  alias ls "ls --time-style=iso --color -lh"
  alias "anacrontab" "nano ~/.anacron/etc/anacrontab"
  alias "fish_config_file" "nano ~/.config/fish/config.fish"
  alias rtfm tldr
  alias upgrade-pip "python -m pip install --upgrade pip"
  alias untar "tar -xvf"
  alias .. "cd .."

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
end

