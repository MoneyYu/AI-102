resource "azurerm_cognitive_account" "lab03-analyze" {
  name                = "${local.lab03_name}-text-analyze-${local.random_str}"
  location            = azurerm_resource_group.ai102.location
  resource_group_name = azurerm_resource_group.ai102.name
  sku_name            = "S"
  kind                = "TextAnalytics"

  custom_question_answering_search_service_id  = azurerm_search_service.lab03-aisearch.id
  custom_question_answering_search_service_key = azurerm_search_service.lab03-aisearch.primary_key

  identity {
    type = "SystemAssigned"
  }

  # storage {
  #   storage_account_id = azurerm_storage_account.lab03-stor.id
  #   identity_client_id = azurerm_storage_account.lab03-stor.identity.0.principal_id
  # }

  tags = {
    environment = local.group_name
  }
}

resource "azurerm_search_service" "lab03-aisearch" {
  name                = "${local.lab03_name}-ai-search-${local.random_str}"
  resource_group_name = azurerm_resource_group.ai102.name
  location            = azurerm_resource_group.ai102.location
  sku                 = "standard"

  tags = {
    environment = local.group_name
  }
}

resource "azurerm_storage_account" "lab03-stor" {
  name                     = "${local.lab03_name}stor${local.random_str}"
  resource_group_name      = azurerm_resource_group.ai102.name
  location                 = azurerm_resource_group.ai102.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = local.group_name
  }
}

resource "azurerm_cognitive_account" "lab03-translation" {
  name                = "${local.lab03_name}-translation-${local.random_str}"
  location            = azurerm_resource_group.ai102.location
  resource_group_name = azurerm_resource_group.ai102.name
  sku_name            = "S1"
  kind                = "TextTranslation"

  tags = {
    environment = local.group_name
  }
}

resource "azurerm_cognitive_account" "lab03-speech" {
  name                = "${local.lab03_name}-speech-${local.random_str}"
  location            = azurerm_resource_group.ai102.location
  resource_group_name = azurerm_resource_group.ai102.name
  sku_name            = "S0"
  kind                = "SpeechServices"

  tags = {
    environment = local.group_name
  }
}