provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "terraform" {
  name     = "terraform-resources"
  location = "Central US"
}

resource "azurerm_container_group" "terraform" {
  name                = "Central US-continst"
  location            = "${azurerm_resource_group.terraform.location}"
  resource_group_name = "${azurerm_resource_group.terraform.name}"
  ip_address_type     = "public"
  os_type             = "linux"

  image_registry_credential {
    server   = "hub.docker.com"
    username = "fabiovg10"
    password = "Docker.1010"
  }

  container {
    name   = "react-pdn"
    image  = "fabiovg10/react-pdn:v1"
    cpu    = "0.5"
    memory = "1.5"
  }

  tags = {
    environment = "pdn"
  }
}