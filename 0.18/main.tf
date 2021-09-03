provider "google" {
  credentials = file("mygcp-cred.json")
  project = ""
  region = "us-west1"
  zone = "us-west1-b"
}

resource "google_compute_instance" "my_server" {
  name = "my-gcp-server"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
        image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network = "default"
  }
}