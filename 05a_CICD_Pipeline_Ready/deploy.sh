#!/bin/bash

# This script deploys a service to Google Cloud Run.

# Exit on error
set -e

# Check for the required arguments
if [ "$#" -ne 2 ]; then
  echo "Usage: ./deploy.sh <service-name> <substitutions>"
  echo "Example: ./deploy.sh backend _GENMEDIA_BUCKET=my-bucket"
  echo "Example: ./deploy.sh frontend _BACKEND_URL=http://my-backend-url"
  exit 1
fi

SERVICE_NAME=$1
SUBSTITUTIONS=$2

# Submit the build to Google Cloud Build
gcloud builds submit --config "$SERVICE_NAME/cloudbuild.yaml" "$SERVICE_NAME" --substitutions="$SUBSTITUTIONS"