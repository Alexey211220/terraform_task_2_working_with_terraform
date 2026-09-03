terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "5.3.0"
    }
  }
}

resource "azurerm_resource_group" "task_2_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "task_2_sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.task_2_rg.name
  location                 = azurerm_resource_group.task_2_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "task_2_container" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.task_2_sa.id
  container_access_type = "private"
}

resource "azurerm_storage_blob" "task_2_blob" {
  name                 = var.blob_name
  storage_container_id = azurerm_storage_container.task_2_container.id
  type                 = "Block"
  source               = "terraform-code.zip"
}