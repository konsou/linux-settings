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

  # OTHER COMMANDS
  zoxide init fish --cmd cd | source
  fastfetch
end

