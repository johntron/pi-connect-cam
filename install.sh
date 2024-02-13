#!/bin/bash

# set -x

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <username> <token> <fingerprint>"
    exit 1
fi

USERNAME=$1
TOKEN=$2
FINGERPRINT=$3

SERVICE_NAME=connect-cam

# Generate the script
TEMPLATE_SCRIPT_PATH="$PWD/connect-cam.sh.template"
OUTPUT_SCRIPT_PATH="/home/$USERNAME/connect-cam.sh"
# OUTPUT_SCRIPT_PATH="$PWD/connect-cam.sh.parsed"
sed "s/\$TOKEN/$TOKEN/g; s/\$FINGERPRINT/$FINGERPRINT/g" "$TEMPLATE_SCRIPT_PATH" > "$OUTPUT_SCRIPT_PATH"
chmod +x "$OUTPUT_SCRIPT_PATH"

# Generate the service
TEMPLATE_SERVICE_PATH="$PWD/connect-cam.service.template"
OUTPUT_SERVICE_PATH="/etc/systemd/system/$SERVICE_NAME.service"
# OUTPUT_SERVICE_PATH="$PWD/$SERVICE_NAME.service.parsed"
sed "s/\$USERNAME/$USERNAME/g; s#\$OUTPUT_SCRIPT_PATH#$OUTPUT_SCRIPT_PATH#g" "$TEMPLATE_SERVICE_PATH" > "$OUTPUT_SERVICE_PATH"

# Enable and start the service
systemctl daemon-reload
systemctl enable "$SERVICE_NAME.service"
systemctl start "$SERVICE_NAME.service"
