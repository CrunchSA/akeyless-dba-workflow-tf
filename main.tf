terraform {
  required_providers {
    akeyless = {
      version = ">= 1.0.0"
      source  = "akeyless-community/akeyless"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  # backend "gcs" {
  #   bucket = "akeyless-cg-tf"
  #   prefix = "dba-example"
  # }
}

provider "akeyless" {
  api_gateway_address = "https://api.akeyless.io"
  jwt_login {
    access_id = var.AKEYLESS_ACCESS_ID
    jwt       = var.AKEYLESS_AUTH_JWT
  }
  
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Make a aws mysql instance

resource "aws_db_instance" "mysql" {
  identifier            = "my-mysql-instance"  # Replace with a unique identifier for your instance
  allocated_storage     = 20
  engine                = "mysql"
  engine_version        = "5.7"
  instance_class        = "db.t2.micro"
  name                  = "mydatabase"  # Replace with your desired database name
  username              = "dbuser"  # Replace with your desired database username
  password              = "dbpassword"  # Replace with your desired database password
  publicly_accessible   = false
}


# module "mongodb_atlas_producer" {
#   source = "./producer"
#   dyn_secret_config = {
#     # The name of the dynamic secret
#     resourceName = "/mongodb_user"
#     # The name of the target database that the dynamic secret will be applied to
#     targetName = "/mongodb"
#     # The time to live for the temporary credentials produced by the dynamic secret
#     user_ttl = "1h"
#     # The roles that the dynamic secret will have access to
#     mongodb_roles = [
#       {
#         roleName     = "readWrite",
#         databaseName = "sample_analytics"
#       }
#     ]
#     # The name of the role that will grant the team access to the resource
#     roleName = "/terraform-db"
#     auth_methods = {
#       # The key is the full path to the kubernetes auth method
#       "/my-k8s-auth-method" = {
#         subClaims = {
#           namespace = "team1"
#         }
#       }
#       # The key is the full path to the SAML provider so the team members can access the secret
#       "/OktaSAML" = {
#         subClaims = {
#           groups = "Team1"
#         }
#       }
#     }
#     ruleList = {
#       # The key is the access path to the secret object
#       "/k8s/*" = {
#         # What permissions do you want the team to have
#         allowedCapabilities = ["read", "list"]
#         # The type of rule (eg. item-rule, target-rule, role-rule, auth-method-rule)
#         ruleType = "item-rule"
#       }
#       # The key is the access path to the secret object
#       "/Azure MongoDB Atlas - Sample Analytics" = {
#         # What permissions do you want the team to have
#         allowedCapabilities = ["read", "list"]
#         # The type of rule (eg. item-rule, target-rule, role-rule, auth-method-rule)
#         ruleType = "item-rule"
#       }
#     }
#   }
# }

# module "mongodb_atlas_producer2" {
#   source = "./producer"
#   dyn_secret_config = {
#     # The name of the dynamic secret
#     resourceName = "/Azure MongoDB Atlas - Sample Restaurants"
#     # The name of the target database that the dynamic secret will be applied to
#     targetName = "/Azure Atlas"
#     # The time to live for the temporary credentials produced by the dynamic secret
#     user_ttl = "8h"
#     # The roles that the dynamic secret will have access to
#     mongodb_roles = [
#       {
#         roleName     = "readWrite",
#         databaseName = "sample_restaurants"
#       }
#     ]
#     # The name of the role that will grant the team access to the resource
#     roleName = "/terraform-db/Team2"
#     auth_methods = {
#       # The key is the full path to the kubernetes auth method
#       "/my-k8s-auth-method" = {
#         subClaims = {
#           namespace = "team2"
#         }
#       }
#       # The key is the full path to the SAML provider so the team members can access the secret
#       "/OktaSAML" = {
#         subClaims = {
#           groups = "Team2"
#         }
#       }
#     }
#     ruleList = {
#       # The key is the access path to the secret object
#       "/k8s/*" = {
#         # What permissions do you want the team to have
#         allowedCapabilities = ["read", "list"]
#         # The type of rule (eg. item-rule, target-rule, role-rule, auth-method-rule)
#         ruleType = "item-rule"
#       }
#       # The key is the access path to the secret object
#       "/Azure MongoDB Atlas - Sample Restaurants" = {
#         # What permissions do you want the team to have
#         allowedCapabilities = ["read", "list"]
#         # The type of rule (eg. item-rule, target-rule, role-rule, auth-method-rule)
#         ruleType = "item-rule"
#       }
#     }
#   }
# }