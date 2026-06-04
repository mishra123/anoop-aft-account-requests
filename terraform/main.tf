module "account_requests" {
  for_each = local.account_requests

  source = "./modules/aft-account-request"

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