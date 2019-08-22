scaffold_policy_name="aar-policy"
pkg_name="aar-policy"
pkg_origin="lnxchk"
pkg_version="0.1.0"
pkg_maintainer="Mandi Walls <mandi@chef.io>"
pkg_scaffolding="chef/scaffolding-chef-infra"
pkg_svc_user=("root")
pkg_exports=(
  [chef_client_ident]="chef_client_ident"
)
