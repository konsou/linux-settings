#!/usr/bin/env fish
# SELF UPDATE

# Check updates once a day
set update_interval 86400
set current_timestamp (date +"%s")

if ! test $current_timestamp -ge \
   (math $KONSO_SETTINGS_LAST_UPDATE + $update_interval)
  echo "Last settings update was at $(date --date @$KONSO_SETTINGS_LAST_UPDATE --rfc-3339=seconds), no need to update"
  exit 0
end

echo "Update shared settings..."
set saved_pwd (pwd)
set git_pull_result (cd $KONSO_SETTINGS_REPO && git pull)
cd $saved_pwd
set -Ux KONSO_SETTINGS_LAST_UPDATE $current_timestamp

if test $git_pull_result = "Already up to date."
  echo $git_pull_result
  exit 0
end

echo "Re-run install.sh..."
$KONSO_SETTINGS_REPO/install.sh
