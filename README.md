# AFT Account Requests

This folder uses a single account map plus one dynamic `module "account_requests"` block. That keeps account vending declarative and avoids one resource/module block per AWS account.

## How to request or change accounts

1. Edit `accounts.auto.tfvars.json`.
2. Add or update one entry under `accounts`.
3. Open a PR.
4. After review and merge, AFT provisions or updates the account through the AFT workflow.

## OU names

Use Control Tower OU names in `ou`. For nested OUs, use path format such as:

- `Workloads (Production)`
- `Workloads (Non-Production)`
- `Data (Production)`
- `Data (Non-Production)`

## Notes

- The diagram showed duplicate names for data-platform and AI platform accounts under production and non-production. The Terraform map uses unique AWS account names: `*-prod` and `*-nonprod`.
- Replace placeholder email aliases and SSO owner details before merge. AWS account root emails must be unique and routable.
# trigger
