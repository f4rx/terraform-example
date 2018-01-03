provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "test_vm_1" {
  name         = "test-vm-1"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "ubuntu-1604-lts"
    }
  }

  network_interface {
    network = "default"

    access_config = {}

  }

  metadata {
    sshKeys = "appuser:${file(var.public_key_path)}"
  }

  provisioner "file" {
    source      = "files/test.txt"
    destination = "/tmp/test.txt"
  }

}
