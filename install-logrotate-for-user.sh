#!/usr/bin/env bash
# Creates $USER/.log directory
# Generates a logrotate conf file there
# Adds a daily cronjob

LOG_DIR="${HOME}/.log"
LOGROTATE_CONFIG="${LOG_DIR}/logrotate.conf"
LOGROTATE_EXECUTABLE="$(which logrotate)"
LOGROTATE_STATE="${LOG_DIR}/logrotate.state"

if [[ -z $LOGROTATE_EXECUTABLE ]]; then
  echo "No logrotate! Exiting"
  exit 1
fi

echo "Creating ${LOG_DIR} if it doesn't exist"
mkdir -p "${LOG_DIR}"

if [[ -f $LOGROTATE_CONFIG ]]; then
  echo "Config file ${LOGROTATE_CONFIG} already exists - please check manually"
  exit 1
fi

echo "Creating ${LOGROTATE_CONFIG}"
cat >  "${LOGROTATE_CONFIG}" << EOF
${LOG_DIR}/*.log {
    daily
    rotate 7
    missingok
    notifempty
    compress
}
EOF

echo "Adding to crontab to run at midnight"
(crontab -l 2>/dev/null; echo "0 0 * * * ${LOGROTATE_EXECUTABLE} --state=${LOGROTATE_STATE} $LOGROTATE_CONFIG") | crontab -

echo "Done"
