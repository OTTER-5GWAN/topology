provider "azurerm" {
  features {
    resource_group {
      # Azure auto-adds a bunch of resources into each new resource group.
      # Don't let those stop us from destroying infrastructure.
      prevent_deletion_if_contains_resources = false
    }
  }
  subscription_id = "YOUR OWN SUBSCRIPTION"
}

provider "google" {
  # Service account credentials
  # follow instructions at https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#adding-credentials
  credentials = file("YOUR OWN CREDENTIAL")
  project     = "YOUR OWN PROJECT"
}
