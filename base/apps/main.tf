resource "kubectl_manifest" "staging_apps" {
  provider  = kubectl
  for_each  = fileset(path.module, "apps/*/envs/staging/application.yml")
  yaml_body = file(each.value)

  server_side_apply = true
}

resource "kubectl_manifest" "prod_apps" {
  provider  = kubectl
  for_each  = fileset(path.module, "apps/*/envs/prod/application.yml")
  yaml_body = file(each.value)

  server_side_apply = true
}
