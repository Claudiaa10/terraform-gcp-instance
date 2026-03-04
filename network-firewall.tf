resource "google_compute_network" "vpc_network" {
name = var.gcp-network
auto_create_subnetworks = true
}
resource "google_compute_firewall" "firewall-icmp" {
name = "terraform-allow-icmp"
network = google_compute_network.vpc_network.name
allow {
protocol = "icmp"
}
source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "firewall-ssh" {
name = "terraform-allow-ssh"
network = google_compute_network.vpc_network.name
allow {
protocol = "tcp"
ports = ["22"]
}
source_ranges = ["0.0.0.0/0"]
}
resource "google_compute_firewall" "firewall-internal" {
name = "terraform-allow-internal"
network = google_compute_network.vpc_network.name
allow {
protocol = "tcp"
ports = ["0-65535"]
}
allow {
protocol = "udp"
ports = ["0-65535"]
}
allow {
protocol = "icmp"
}
source_ranges = ["10.128.0.0/20"]
}

