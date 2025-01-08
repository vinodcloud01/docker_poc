#!/bin/bash

# Configuration
SECRETS_DIR="./secrets"

# Check if the secrets directory exists
if [ -d "$SECRETS_DIR" ]; then
  # Remove all files in the secrets directory except .enc files
  find "$SECRETS_DIR" -type f ! -name "*.enc" -exec rm -f {} \;
  echo "All secrets (except .enc files) have been removed from $SECRETS_DIR."
else
  echo "Error: Secrets directory $SECRETS_DIR does not exist."
  exit 1
fi

exit 0
