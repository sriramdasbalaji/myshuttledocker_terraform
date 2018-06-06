terraform {
  required_version = ">= 0.11"

  backend "azurerm" {
  storage_account_name = "terraformstorage3"
    container_name       = "terraformstate"
    key                  = "terraform.tfstate"
	access_key  ="RWS/bJ4wT8ubD7IBjmJfKvJbohiYoh6rMaalG4Ep1vDHsYAubNPqf/fxY6m5RRy6uvU1HJ3we9BuwOSdx4lKKg=="}
}

provider "azurerm" {
   subscription_id = "1e8dd12f-b232-4895-9848-41766310c63a"
   client_id       = "22530b13-39b1-42f5-8c2e-6402dceb8305"
   client_secret   = "P2ssw0rd"
   tenant_id       = "7be67d77-cc3f-4e1e-b2d9-bc3bdbdab7dd"
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
            key_data = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDhYTK8uzGEU+4qqzKaGBF/ULCoRJES8PR4K3GjueSTB/Cq9xh7cpcXdteQRM3ZsQERmVeyvdqW+JdRfWIEsg6xR6AZolcD5DOEI6R6Ec6WoDZYjBi38BE0c3Qp/1AkG5ltDLyoiiCQhQnuqOoS4x6KBZkI1pZsqUobYst5nHFZ3KUjwnphRwS1yDPZqg669teE6vhLlpT+K+1Co7JvmRuqVZpdrma/p+Z3EcGUSreAhJhzxppBr/b4do4vKe1fRqIl6pSRUlCoLVS1XJmxj3MhpLD0Nv4ncHhc1P2FiUofpsQMsas71adw9B40i95ArgpSXEE//VFqhIqRdxXx1k5z rakesh@Thailanddemo"
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