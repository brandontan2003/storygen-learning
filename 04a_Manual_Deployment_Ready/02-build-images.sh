#!/bin/bash
# 02-build-images.sh
# This script builds and pushes Docker images for the frontend and backend.

# --- Configuration ---
# Exit immediately if a command exits with a non-zero status.
set -e
# Source environment variables
source load-env.sh

# --- Functions ---
function print_message() {
  echo "--------------------------------------------------"
  echo "$1"
  echo "--------------------------------------------------"
}

# --- Main Script ---
print_message "Starting Docker Image Build and Push"

# Step 1: Configure Docker for GCR
print_message "Step 1: Configuring Docker for GCR"
gcloud auth configure-docker gcr.io

# Step 2: Build and Push Frontend Image
print_message "Step 2: Building and Pushing Frontend Image"
docker build -t $FRONTEND_IMAGE_NAME ./frontend
docker push $FRONTEND_IMAGE_NAME

# Step 3: Build and Push Backend Image
print_message "Step 3: Building and Pushing Backend Image"
docker build -t $BACKEND_IMAGE_NAME ./backend
docker push $BACKEND_IMAGE_NAME

print_message "Docker Image Build and Push Complete!"
