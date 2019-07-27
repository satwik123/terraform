provider "google" {
  credentials = "${file("service-account.json")}"
  project = "testing-terraform-248016"
  region  = "us-central1"
  zone    = "us-central1-b"
}


// A single Google Cloud Engine instance
resource "google_compute_instance" "default" {
 name         = "test-vm"
 machine_type = "f1-micro"
 zone         = "us-central1-b"

 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }

// Make sure flask is installed on all new instances for later steps
 metadata_startup_script = "sudo apt-get update; sudo apt-get install -yq build-essential python-pip rsync; pip install flask"

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}
