#!/bin/bash
# ============================================
# DevOps Auto Deployment Script
# Repo: devops-auto-deploy
# Author: Arnab
# ============================================

set -e        # Stop on error
set -u        # Stop if variable missing

# Log file
LOG_FILE="$HOME/deployments/devops-auto-deploy/deploy.log"
exec > "$LOG_FILE" 2>&1

# Config
APP_DIR="$HOME/deployments/devops-auto-deploy"
REPO_URL="https://github.com/Arnazz10/devops-auto-deploy.git"
BRANCH="main"

echo "===================================="
echo " Deployment Started: $(date)"
echo "===================================="

# If project folder missing, clone
if [ ! -d "$APP_DIR/.git" ]; then
    echo "Cloning repository..."
    git clone "$REPO_URL" "$APP_DIR"
fi

# Go to project folder
cd "$APP_DIR"

echo "Fetching latest code..."
git fetch origin

echo "Resetting to latest version..."
git reset --hard origin/$BRANCH

echo "Pulling updates..."
git pull origin $BRANCH

# Example: Run extra scripts (optional)
if [ -f "run.sh" ]; then
    echo "Running project script..."
    chmod +x run.sh
    ./run.sh
fi

echo "===================================="
echo " Deployment Finished: $(date)"
echo "===================================="
