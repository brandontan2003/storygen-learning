#!/bin/bash
# 01-setup.sh
# This script sets up the GCP environment for the StoryGen application.

# --- Configuration ---
# Source environment variables
source load-env.sh

# --- Functions ---
# Function to print messages
function print_message() {
  echo "--------------------------------------------------"
  echo "$1"
  echo "--------------------------------------------------"
}

# --- Main Script ---
print_message "Starting GCP Setup for StoryGen"

# Step 1: Authenticate with GCP
print_message "Step 1: Authenticating with GCP"
gcloud auth login
gcloud auth application-default login

# Step 2: Configure GCP Project
print_message "Step 2: Configuring GCP Project"
gcloud config set project $PROJECT_ID

# Step 3: Enable Required GCP APIs
print_message "Step 3: Enabling Required GCP APIs"
gcloud services enable \
  run.googleapis.com \
  containerregistry.googleapis.com \
  iam.googleapis.com \
  aiplatform.googleapis.com \
  storage.googleapis.com \
  cloudresourcemanager.googleapis.com

print_message "GCP Setup Complete!"
