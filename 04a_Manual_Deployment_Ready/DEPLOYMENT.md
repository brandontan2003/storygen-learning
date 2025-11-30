# Manual Deployment Plan for StoryGen

This document outlines the steps to manually deploy the StoryGen application to Google Cloud Platform.

## Prerequisites

1.  Google Cloud SDK (`gcloud`) installed and configured.
2.  Docker installed.
3.  Terraform installed.

## Deployment Steps

### 1. Configure Environment Variables

-   Create a `.env` file in the root of the project.
-   Add the following variables to the `.env` file, replacing the placeholder values with your own:

```
# .env
# Environment variables for StoryGen deployment

# GCP Configuration
PROJECT_ID="your-gcp-project-id"
LOCATION="us-central1"
REGION="us-central1"

# Service Names
FRONTEND_SERVICE_NAME="genai-frontend"
BACKEND_SERVICE_NAME="genai-backend"

# Docker/GCR Configuration
FRONTEND_IMAGE_NAME="gcr.io/${PROJECT_ID}/${FRONTEND_SERVICE_NAME}"
BACKEND_IMAGE_NAME="gcr.io/${PROJECT_ID}/${BACKEND_SERVICE_NAME}"

# Storage Bucket
BUCKET_NAME="genai-story-images-${PROJECT_ID}"
```

### 2. Grant Permissions to Scripts

Make the deployment scripts executable:

```bash
chmod +x 01-setup.sh 02-build-images.sh 03-deploy-infrastructure.sh
```

### 3. Run the Deployment Scripts

Execute the scripts in the following order:

1.  **`./01-setup.sh`**: This script will guide you through authenticating with GCP and will enable the necessary APIs for the project.

2.  **`./02-build-images.sh`**: This script will build the Docker images for the frontend and backend applications and push them to Google Container Registry.

3.  **`./03-deploy-infrastructure.sh`**: This script will use Terraform to deploy the Cloud Run services and the storage bucket.

## Generated Files

Here is a summary of the files that were generated:

-   **`load-env.sh`**: A helper script to load environment variables from the `.env` file.
-   **`01-setup.sh`**: Sets up the GCP environment.
-   **`02-build-images.sh`**: Builds and pushes Docker images.
-   **`03-deploy-infrastructure.sh`**: Deploys the infrastructure using Terraform.
-   **`backend/Dockerfile`**: The Dockerfile for the Python backend application.
-   **`terraform_code/variables.tf`**: Defines the variables used in the Terraform configuration.
-   **`.env`**: A sample environment file. **Please fill this in with your actual project details.**

The `terraform_code/main.tf` file was also modified to use variables, making the infrastructure code more modular and reusable.
