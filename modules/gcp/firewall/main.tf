# Add firewall rules to VPC
resource "google_compute_firewall" "allow_icmp" {
  name    = "${var.vpc}-allow-icmp"
  network = var.vpc
  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "allow_ssh" {
  name    = "${var.vpc}-allow-ssh"
  network = var.vpc
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "allow_internal" {
  name    = "${var.vpc}-allow-internal"
  network = var.vpc
  allow {
    protocol = "all"
  }
  source_ranges = var.gcp_ips
}
resource "google_compute_firewall" "allow_azure" {
  name    = "${var.vpc}-allow-azure"
  network = var.vpc
  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  #source_ranges = var.azure_ips
}