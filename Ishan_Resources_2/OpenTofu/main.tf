terraform {
  required_version = ">= 0.13.1"
  required_providers {
    spotinst = {
      source  = "terraform-spotinst/local/spotinst"
      version = ">=99.0.0"
    }
  }
}

provider "spotinst" {
  # Configuration options
  token = "<Test>"
  account = "act-c23ac1f8"
}

resource "spotinst_elastigroup_azure_v3" "test_azure_group" {
  name                = "Test-EG"
  resource_group_name = "AutomationResourceGroup"
  region              = "eastus"
  os                  = "Linux"

  // --- CAPACITY ------------------------------------------------------
  min_size         = 0
  max_size         = 3
  desired_capacity = 1
  // -------------------------------------------------------------------

  // --- INSTANCE TYPES ------------------------------------------------
    vm_sizes{
       od_sizes   = ["standard_a1_v2"]
       spot_sizes = ["standard_a1_v2","standard_ds2_v2"]
    }

  // -------------------------------------------------------------------

  // --- LAUNCH SPEC ---------------------------------------------------
  custom_data = null

#   managed_service_identity {
#   resource_group_name = "MC_ocean-westus-dev_ocean-westus-dev-aks_westus"
#   name                = "ocean-westus-dev-aks-agentpool"
#   }

  tags {
  key = "creator"
  value = "Gude"
  }

  tags {
  key = "team"
  value = "Automation"
  }

  // --- IMAGE ---------------------------------------------------------
  image {
    marketplace {
      publisher = "Canonical"
      offer     = "UbuntuServer"
      sku       = "18.04-LTS"
      version   = "latest"
    }
  }
  // -------------------------------------------------------------------

  // --- STRATEGY ------------------------------------------------------
  //on_demand_count     = 1
  spot_percentage       = 65
  draining_timeout      = 300
  fallback_to_on_demand = true
  // -------------------------------------------------------------------

  // --- NETWORK -------------------------------------------------------
  network {
    virtual_network_name = "Automation-VirtualNetwork"
    resource_group_name  = "AutomationResourceGroup"

    network_interfaces {
      subnet_name      = "Automation-PrivateSubnet"
      assign_public_ip = false
      is_primary       = true

#       additional_ip_configs {
#         name             = "SecondaryIPConfig"
#         PrivateIPVersion = "IPv4"
#       }

      application_security_group {
        name                = "Automation-Application-Security-Group-Do-Not-Delete"
        resource_group_name = "AutomationResourceGroup"
      }
    }
  }
  // -------------------------------------------------------------------

  // --- LOGIN ---------------------------------------------------------
  login {
    user_name      = "ubuntu"
    #ssh_public_key = "TestSSHPublicKey==="
    password      = "Netapp@123@321"
  }
  // -------------------------------------------------------------------
}