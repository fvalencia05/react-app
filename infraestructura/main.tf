provider "azurerm" {
  version = "=1.27"
}

variable "tag" {
  default = ""
  description = "The prefix used for all resources in this example"
}

resource "azurerm_resource_group" "terraform" {
  name     = "containers-resource-group"
  location = "westus"
}

resource "azurerm_container_group" "terraform" {
  name                = "containers-group"
  location            = "${azurerm_resource_group.terraform.location}"
  resource_group_name = "${azurerm_resource_group.terraform.name}"
  ip_address_type     = "public"
  os_type             = "linux"

  image_registry_credential {
    server   = "hub.docker.com"
    username = "<UserName>"
    password = "<Password>"
  }

  container {
    name   = "react-pdn"
    image  = "fabiovg10/react-pdn:${var.tag}"
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  tags = {
    environment = "pdn"
  }
}