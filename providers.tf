provider "azurerm" {
  features {
    resource_group {
      # Azure auto-adds a bunch of resources into each new resource group.
      # Don't let those stop us from destroying infrastructure.
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "google" {
  # Service account credentials
  credentials = file("YOUR OWN CREDENTIAL")
  project     = "YOUR OWN PROJECT"
}
