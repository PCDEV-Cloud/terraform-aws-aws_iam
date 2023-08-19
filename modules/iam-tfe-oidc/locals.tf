locals {
  site_address = trimprefix(var.identity_provider_url, "https://")

  role_names = [for i, k in distinct(var.access_configuration) : replace(join("-", [k.organization, k.project, join("+", k.workspaces), k.run_phase]), "-*", "")]
  roles      = { for i, k in distinct(var.access_configuration) : local.role_names[i] => [for j in k.workspaces : join(":", ["organization", "${k.organization}", "project", "${k.project}", "workspace", "${j}", "run_phase", "${k.run_phase}"])] }
}