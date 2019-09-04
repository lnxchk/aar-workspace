scaffold_policy_name="aar-host"
pkg_name="aar-host"
pkg_origin="lnxchk"
pkg_version="0.1.4"
pkg_maintainer="Mandi Walls <mandi@chef.io>"
pkg_scaffolding="chef/scaffolding-chef-infra"
pkg_svc_user=("root")
pkg_exports=(
  [chef_client_ident]="chef_client_ident"
)
