locals {
  account_requests = {
    for key, account in var.accounts : key => merge(account, {
      module_name = replace(key, "-", "_")
      sso_email   = coalesce(try(account.sso_user_email, null), var.default_sso_user.email)
      sso_first   = coalesce(try(account.sso_first_name, null), var.default_sso_user.first_name)
      sso_last    = coalesce(try(account.sso_last_name, null), var.default_sso_user.last_name)
      tags = merge(var.default_tags, {
        Application = account.application
        Environment = account.environment
      }, try(account.tags, {}))
    })
  }
}

module "account_requests" {
  for_each = local.account_requests

  source = "git::https://github.com/aws-ia/terraform-aws-control_tower_account_factory.git//modules/aft-account-request?ref=v1.20.0"

  control_tower_parameters = {
    AccountEmail              = each.value.email
    AccountName               = each.value.name
    ManagedOrganizationalUnit = each.value.ou
    SSOUserEmail              = each.value.sso_email
    SSOUserFirstName          = each.value.sso_first
    SSOUserLastName           = each.value.sso_last
  }

  account_tags = each.value.tags

  change_management_parameters = {
    change_requested_by = "cloud-platform"
    change_reason       = "EBOS landing zone account request for ${each.value.name}"
  }

  custom_fields = merge({
    account_key = each.key
    ou_path     = each.value.ou
    application = each.value.application
    environment = each.value.environment
  }, try(each.value.custom_fields, {}))

  account_customizations_name = each.value.customization
}