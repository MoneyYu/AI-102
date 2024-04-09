resource "azurerm_cognitive_account" "openai" {
  kind                = "OpenAI"
  location            = azurerm_resource_group.ai050.location
  name                = "${local.lab_name}-aoai-${local.random_str}"
  resource_group_name = azurerm_resource_group.ai050.name
  sku_name            = "S0"

  tags = {
    environment = local.group_name
  }
}

resource "azurerm_cognitive_deployment" "gpt35" {
  name                 = "gpt-35-turbo-16k"
  cognitive_account_id = azurerm_cognitive_account.openai.id
  model {
    format  = "OpenAI"
    name    = "gpt-35-turbo-16k"
    version = "0613"
  }

  scale {
    type = "Standard"
  }
}

resource "azurerm_cognitive_deployment" "gpt4" {
  name                 = "gpt-4"
  cognitive_account_id = azurerm_cognitive_account.openai.id
  model {
    format  = "OpenAI"
    name    = "gpt-4"
    version = "0125-Preview"
  }

  scale {
    type = "Standard"
  }
}

resource "azurerm_cognitive_deployment" "dalle3" {
  name                 = "dalle3"
  cognitive_account_id = azurerm_cognitive_account.openai.id
  model {
    format  = "OpenAI"
    name    = "dall-e-3"
    version = "3.0"
  }

  scale {
    type = "Standard"
  }
}

resource "azurerm_storage_account" "stor" {
  name                     = "${local.lab_name}stor${local.random_str}"
  resource_group_name      = azurerm_resource_group.ai050.name
  location                 = azurerm_resource_group.ai050.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = local.group_name
  }
}

resource "azurerm_search_service" "aisearch" {
  name                = "${local.lab_name}-ai-search-${local.random_str}"
  resource_group_name = azurerm_resource_group.ai050.name
  location            = azurerm_resource_group.ai050.location
  sku                 = "standard"
}
