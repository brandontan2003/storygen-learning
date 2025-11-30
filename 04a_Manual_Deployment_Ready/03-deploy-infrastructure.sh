#!/bin/bash
# 03-deploy-infrastructure.sh
# This script deploys the StoryGen infrastructure using Terraform.

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
print_message "Starting Infrastructure Deployment with Terraform"

# Step 1: Navigate to Terraform directory
print_message "Step 1: Navigating to terraform_code directory"
cd terraform_code

# Step 2: Initialize Terraform
print_message "Step 2: Initializing Terraform"
terraform init

# Step 3: Apply Terraform Configuration
print_message "Step 3: Applying Terraform Configuration"
terraform apply -auto-approve \
  -var="project_id=$PROJECT_ID" \
  -var="location=$LOCATION" \
  -var="frontend_service_name=$FRONTEND_SERVICE_NAME" \
  -var="backend_service_name=$BACKEND_SERVICE_NAME" \
  -var="frontend_image_name=$FRONTEND_IMAGE_NAME" \
  -var="backend_image_name=$BACKEND_IMAGE_NAME" \
  -var="bucket_name=$BUCKET_NAME"

# Step 4: Navigate back to the root directory
print_message "Step 4: Navigating back to the root directory"
cd ..

print_message "Infrastructure Deployment Complete!"
