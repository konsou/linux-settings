#!/usr/bin/env fish

# SELF UPDATE
# Check updates once a day
set update_interval 86400
set current_timestamp (date +"%s")
if test $current_timestamp -ge \
   (math $KONSO_SETTINGS_LAST_UPDATE + $update_interval)
  echo "Update shared settings..."
  fish -c "cd $KONSO_SETTINGS_REPO && git pull"
  set -Ux KONSO_SETTINGS_LAST_UPDATE $current_timestamp
else
  echo "Last settings update was at $(date --date @$KONSO_SETTINGS_LAST_UPDATE --rfc-3339=seconds), no need to update"
end
