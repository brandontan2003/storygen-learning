#!/bin/bash
# load-env.sh
# This script loads environment variables from a .env file.
# It's designed to be sourced by other scripts, not executed directly.

set -a # automatically export all variables
source .env
set +a
