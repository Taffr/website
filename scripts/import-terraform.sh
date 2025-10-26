#!/bin/bash
set -euo pipefail

PROJECT="simon-tenggren-website"
REGION="europe-north1"

echo "Importing Cloud Run service..."
terraform import \
  google_cloud_run_v2_service.default \
  "projects/${PROJECT}/locations/${REGION}/services/cr-simon-tenggren-website"

echo "Importing Cloud Run IAM binding..."
terraform import \
  google_cloud_run_service_iam_binding.default \
  "projects/${PROJECT}/locations/${REGION}/services/cr-simon-tenggren-website roles/run.invoker"

echo "Importing Artifact Registry repository..."
terraform import \
  google_artifact_registry_repository.website-repo \
  "projects/${PROJECT}/locations/${REGION}/repositories/website-repo"

echo "✅ All resources imported successfully!"
