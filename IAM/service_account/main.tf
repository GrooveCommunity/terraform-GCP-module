provider "random" {
  version = "~> 2.1"
}


resource "random_id" "entropy" {
  byte_length = 6
}

# https://www.terraform.io/docs/providers/google/r/google_service_account.html
resource "google_service_account" "default" {
  provider = google

  account_id   = "cluster-${var.client}-${random_id.entropy.hex}"
  display_name = "Conta para administração dos Clusters  do cliente${var.client}"
  project      = var.gcp_project_id
}

# https://www.terraform.io/docs/providers/google/r/google_project_iam.html
resource "google_project_iam_member" "logging-log-writer" {
  provider = google

  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.default.email}"
  project = var.gcp_project_id
}

resource "google_project_iam_member" "monitoring-metric-writer" {
  provider = google

  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.default.email}"
  project = var.gcp_project_id
}

resource "google_project_iam_member" "monitoring-viewer" {
  provider = google

  role    = "roles/monitoring.viewer"
  member  = "serviceAccount:${google_service_account.default.email}"
  project = var.gcp_project_id
}

resource "google_project_iam_member" "storage-object-viewer" {
  provider = google

  count   = var.access_private_images == "true" ? 1 : 0
  role    = "roles/storage.objectViewer"
  member  = "serviceAccount:${google_service_account.default.email}"
  project = var.gcp_project_id
}

resource "google_project_iam_member" "gke-admin" {
  provider = google

  role    = "roles/gkehub.admin"
  member  = "serviceAccount:${google_service_account.default.email}"
  project = var.gcp_project_id
}
