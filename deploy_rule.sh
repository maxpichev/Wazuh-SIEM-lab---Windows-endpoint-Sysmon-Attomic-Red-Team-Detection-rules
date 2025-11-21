#!/usr/bin/env bash
# Usage: ./deploy_rule.sh <rulefile.xml>
set -euo pipefail

SRC_DIR="/home/max/rules-custom"    # your folder with rule files
DST_DIR="/var/ossec/etc/rules"      # wazuh rule directory
SERVICE="wazuh-manager"             # wazuh service

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <rulefile.xml>"
  exit 1
fi

RULE_FILE="$1"

if [[ ! -f "$SRC_DIR/$RULE_FILE" ]]; then
  echo " Not found: $SRC_DIR/$RULE_FILE"
  exit 2
fi

echo "→ Copying $RULE_FILE to $DST_DIR ..."
sudo cp "$SRC_DIR/$RULE_FILE" "$DST_DIR/$RULE_FILE"

echo "→ Restarting $SERVICE ..."
sudo systemctl restart "$SERVICE"

echo " Deployed $RULE_FILE and restarted $SERVICE."
