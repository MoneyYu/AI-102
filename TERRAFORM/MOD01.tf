resource "azurerm_cognitive_account" "lab01" {
  name                = "${local.lab01_name}-ai-service-${local.random_str}"
  location            = azurerm_resource_group.ai102.location
  resource_group_name = azurerm_resource_group.ai102.name
  sku_name            = "S0"
  kind                = "CognitiveServices"
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_group#environment_variables
resource "azurerm_container_group" "lab01" {
  name                = "${local.lab01_name}-aci-${local.random_str}"
  location            = azurerm_resource_group.ai102.location
  resource_group_name = azurerm_resource_group.ai102.name
  ip_address_type     = "Public"
  dns_name_label      = "${local.lab01_name}-aci-${local.random_str}"
  os_type             = "Linux"
  restart_policy      = "OnFailure"

  container {
    name   = "textanalytics"
    image  = "mcr.microsoft.com/azure-cognitive-services/textanalytics/language:latest"
    cpu    = "1"
    memory = "12"

    environment_variables {

    }

    secure_environment_variables {

    }

    ports {
      port     = 443
      protocol = "TCP"
    }
  }

  tags = {
    environment = local.group_name
  }
}
