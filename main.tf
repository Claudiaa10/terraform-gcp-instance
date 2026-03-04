resource "google_compute_instance" "tf_vm" {
  name         = "tf-vm"
  zone         = "europe-west1-b"
  machine_type = "n1-standard-1"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  metadata = {
    ssh-keys = "${var.gcp-username}:${file(pathexpand("../.ssh/id_rsa.pub"))}"
  }

  tags = ["http"]

  metadata_startup_script = file("setup-docker.sh")

  network_interface {
    network = var.gcp-network
    access_config {}
  }
}

output "tf_vm_internal_ip" {
  value      = google_compute_instance.tf_vm.network_interface[0].network_ip
  depends_on = [google_compute_instance.tf_vm]
}

output "tf_vm_ephemeral_ip" {
  value      = google_compute_instance.tf_vm.network_interface[0].access_config[0].nat_ip
  depends_on = [google_compute_instance.tf_vm]
}