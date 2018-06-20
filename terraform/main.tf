terraform {
  required_version = ">= 0.11"

  backend "azurerm" {
  storage_account_name = "terraformstorage23"
    container_name       = "terraformstate"
    key                  = "terraform.tfstate"
	access_key  ="TlvaBt7CTfJOT4TBFSVBPzNuQs93Ko/10zs8QGYQYR2CRH+tOE0A/BGohEF92HHciSxqUWD8DMqSkp9ZveeH7Q=="}
}

provider "azurerm" {
   subscription_id = "5ae35b9e-9571-4a30-8426-62c1ba3394c4"
   client_id       = "3a0796f5-a7e4-4dc8-a8cc-ec95d0fac553"
   client_secret   = "P2ssw0rd"
   tenant_id       = "9fdb9cd0-248c-4fa9-bfcb-d000f2411b95"
 }
resource "azurerm_resource_group" "akc-rg" {
    name     = "terraformakc"
    location = "east us"
}

resource "azurerm_storage_account" "acr-storage" {
  name                     = "storageaccountacr65124"
  resource_group_name      = "${azurerm_resource_group.akc-rg.name}"
  location                 = "${azurerm_resource_group.akc-rg.location}"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_kubernetes_cluster" "aks_container" {
    name        = "akc-121313"
    location    = "east us"
    dns_prefix  = "akc-121313"

    resource_group_name = "${azurerm_resource_group.akc-rg.name}"
    kubernetes_version  = "1.8.7"


    linux_profile {
        admin_username = "vmadmin"
        ssh_key {
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCh8l9Dvh9gHSX4lq7W1nTkQSrhSY9iPDgi8Oz2iKETMRkv2VIedKqPBceOEaxzlJtxdapW8zWfzMyN5CINLNnf24mFcJXxS4uICPh3qLyPBr44YnDlW5pA86D8xNduk+/QNFgXVxVpCcElWaYVWU4S7cicVt+ub1luElvR6urCmWco+MgHmd3WPjZggoxE4rFFN4a1IiDjFCmM/Wjhqv6RDmGItq+nCfDUKVjwrhDS8hPT7KP4Em4lLJ90WDY3JLKtCngPxEmlls7Cz9UJCGDDVVJ0VvyhYwrxCJdsjdiCLBepvbbM1ooih+l5dK+gI7q60m+kEtxIca+j0nXQhhjD sriramdasbalaji@Windows10E"
        }
    }

    agent_pool_profile {
        name        = "agentpool"
        count       = "1"
        vm_size     = "Standard_DS2_v2"
        os_type     = "Linux"
    }

    service_principal {
        client_id     = "22530b13-39b1-42f5-8c2e-6402dceb8305"
        client_secret = "P2ssw0rd"
    }
}