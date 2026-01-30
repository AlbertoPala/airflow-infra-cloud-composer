# Airflow Infra Dataprocs

This repository contains the Terraform infrastructure code for deploying **Google Cloud Composer** (Airflow) and **Dataproc** environments on Google Cloud Platform (GCP). It is designed to be deployed via GitHub Actions using Workload Identity Federation (WIF).

## 🏗 Architecture

The infrastructure includes the following components:

*   **Cloud Composer 3**: A managed Apache Airflow environment (Small size, Image: `composer-3-airflow-3.1.0`).
*   **Google Cloud Storage (GCS)**:
    *   `tf-state-***`: Bucket for Terraform state file storage.
    *   `***-data-lake-***`: Bucket for data processing input/output.
    *   `***-dags-***`: Bucket for storing Airflow DAGs.
*   **Workload Identity Federation (WIF)**: Secure authentication for GitHub Actions to deploy infrastructure without long-lived keys.
*   **Dataproc**: Enabled API (Clusters to be configured in future updates).

## 📂 Repository Structure

```
├── .github/workflows/   # CI/CD pipelines (GitHub Actions)
├── terraform/
│   ├── envs/            # Environment-specific configurations
│   │   └── dev/         # Development environment
│   └── modules/         # Reusable Terraform modules
│       ├── composer/    # Cloud Composer configuration
│       ├── dataprocs/   # Dataproc configuration
│       ├── gcs/         # Cloud Storage buckets
│       └── wif/         # Workload Identity Federation
```

## 🚀 Prerequisites

Before deploying, ensure you have the following:

1.  **GCP Project**: An active Google Cloud Project with billing enabled.
2.  **Terraform Backend Bucket**: A GCS bucket to store the Terraform state (referenced in `backend.tf`).
3.  **APIs Enabled**: Ensure the Cloud Resource Manager API and Service Usage API are enabled to allow Terraform to enable other APIs.

### GitHub Secrets

The following secrets must be configured in your GitHub repository for the CI/CD pipeline to work:

| Secret Name | Description |
| :--- | :--- |
| `GCP_PROJECT_ID` | The ID of your GCP project. |
| `PROJECT_NUMBER` | The numeric project number (e.g., `123456789012`). |
| `GCP_CI_SA` | Email of the Service Account used by CI/CD (e.g., `github-actions@...`). |
| `GCP_WIF_PROVIDER` | Full resource name of the WIF Provider. |
| `GCP_WIF_POOL` | Full resource name of the WIF Pool (Must use **Project Number**).<br>Format: `projects/123456789/locations/global/workloadIdentityPools/my-pool` |
| `VAR_GITHUB_ORG` | Your GitHub Organization or Username. |
| `REPO` | The name of this repository (`airflow-infra-dataprocs`). |
| `COMPOSER_SA` | Service Account email to be attached to the Composer environment. |

## 🛠️ Usage

### Deployment (CI/CD)
The infrastructure is automatically deployed on push to the `main` branch via GitHub Actions.
1.  Make changes to the Terraform code.
2.  Commit and push to `main`.
3.  The workflow `Terraform Infra` will trigger:
    *   **Init**: Initialize Terraform.
    *   **Plan**: Generate an execution plan.
    *   **Apply**: Apply the changes to GCP.

### Local Development
To run locally, you must authenticate with GCP and provide the necessary variables.

1.  **Authenticate**:
    ```bash
    gcloud auth application-default login
    ```
2.  **Initialize**:
    ```bash
    cd terraform/envs/dev
    terraform init
    ```
3.  **Plan/Apply**:
    Create a `terraform.tfvars` file (DO NOT COMMIT THIS) with your variable values:
    ```hcl
    project_id     = "your-project-id"
    project_number = "your-project-number"
    env            = "dev"
    # ... other variables
    ```
    Then run:
    ```bash
    terraform plan
    terraform apply
    ```

## 📦 Modules

*   **`wif`**: Configures IAM bindings to allow GitHub Actions to impersonate the CI Service Account using OIDC.
*   **`composer`**: Provisions the Cloud Composer environment. configured for `ENVIRONMENT_SIZE_SMALL`.
*   **`gcs`**: Reusable module for creating secure GCS buckets with versioning enforced.
*   **`dataprocs`**: Manages Dataproc resources (currently API enablement only).
