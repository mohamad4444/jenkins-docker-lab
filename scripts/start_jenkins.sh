#!/bin/bash
set -e

# Configuration
CONTAINER_NAME="jenkins"
PASSWORD_FILE="/var/jenkins_home/secrets/initialAdminPassword"
TIMEOUT=300 # 5 minutes
INTERVAL=5

echo "Starting Registry..."
docker-compose -f registry/docker-compose.yml up -d

echo "Starting Jenkins environment..."
docker-compose up -d

echo "Waiting for Jenkins to initialize..."
start_time=$(date +%s)

while true; do
    # Check if container is running
    if ! docker ps | grep -q "$CONTAINER_NAME"; then
        echo "Error: Container '$CONTAINER_NAME' is not running."
        exit 1
    fi

    # Check for password file existence
    if docker exec "$CONTAINER_NAME" test -f "$PASSWORD_FILE" 2>/dev/null; then
        echo "Jenkins initialized!"
        echo "---------------------------------------------------"
        echo "Initial Admin Password:"
        docker exec "$CONTAINER_NAME" cat "$PASSWORD_FILE"
        echo "---------------------------------------------------"
        echo "Access Jenkins at: http://localhost:8080"
        exit 0
    fi

    # Check timeout
    current_time=$(date +%s)
    elapsed=$((current_time - start_time))
    if [ "$elapsed" -ge "$TIMEOUT" ]; then
        echo "Timeout reached waiting for Jenkins to initialize."
        exit 1
    fi

    echo "Waiting for password file... (${elapsed}s elapsed)"
    sleep "$INTERVAL"
done
