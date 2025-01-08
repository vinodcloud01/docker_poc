#!/bin/bash

# Configuration
SECRETS_DIR="./secrets"
ENCRYPTED_FILE="$SECRETS_DIR/secrets.env.enc"
DECRYPTED_FILE="$SECRETS_DIR/secrets.env"

# Ensure the secrets directory exists
mkdir -p "$SECRETS_DIR"

# Decrypt the secrets.env file
echo "Enter the password to decrypt secrets.env.enc:"
openssl enc -aes-256-cbc -salt -d -pbkdf2 -iter 100000 -in "$ENCRYPTED_FILE" -out "$DECRYPTED_FILE"
if [ $? -ne 0 ]; then
  echo "Error: Failed to decrypt $ENCRYPTED_FILE."
  exit 1
fi

# Create individual secret files
while IFS='=' read -r key value; do
  if [[ -n "$key" && -n "$value" ]]; then
    printf "%s" "$value" | tr -d '\r\n' > "$SECRETS_DIR/$key"
    chmod 600 "$SECRETS_DIR/$key"
    echo "Created secret file: $SECRETS_DIR/$key"
  fi
done < "$DECRYPTED_FILE"

# Securely delete the decrypted file
shred -u "$DECRYPTED_FILE"
echo "Decrypted secrets processed and cleaned up."

docker-compose -f docker-compose_secrets.yml up -d
#docker-compose -f docker-compose_secrets.yml down --remove-orphans --rmi all --volumes

exit 0
