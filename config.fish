if status is-interactive
  echo "Loading shared fish config"


  # FISH SETTINGS
  # Disable the "Welcome to fish..." text
  set -Ux fish_greeting ""
  function fish_greeting
    # pass
  end
  # Format man pages
  set -x MANROFFOPT "-c"
  set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"


  # ALIASES
  alias .. "cd .."
  alias anacrontab "nano ~/.anacron/etc/anacrontab"
  alias cd.. "cd .."
  alias fish_config_file "nano ~/.config/fish/config.fish"

  # Replace ls with eza
  alias ls='eza -l --time-style=iso --color=always --group-directories-first --icons'  # preferred listing
  alias la='eza -a --time-style=iso --color=always --group-directories-first --icons'  # all files and dirs
  alias lt='eza -aT --time-style=iso --color=always --group-directories-first --icons' # tree listing
  alias l.="eza -a | grep -e '^\.'"                                                    # show only dotfile

  alias process-list "ps aux"
  alias rtfm tldr
  alias untar "tar -xvf"
  alias upgrade-pip "python -m pip install --upgrade pip"

  # Add color
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'


  # SSH Agent - fix
  # systemctl --user is-active --quiet ssh-agent.service
  # if test $status -gt 0
  #   echo "Enabling and starting ssh-agent"
  #   systemctl --user enable --now ssh-agent.service
  # end


  # SELF UPDATE
  $KONSO_SETTINGS_REPO/update.fish


  # OTHER COMMANDS
  zoxide init fish --cmd cd | source
  fastfetch
  echo "Utils reminder: bashtop dysk htop iotop jdupes jnettop ncdu nvtop"
end

