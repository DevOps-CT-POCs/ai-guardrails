package kubernetes.admission

violation contains {"msg": msg} if {
  input.review.kind.kind == "Pod"

  container := input.review.object.spec.containers[_]
  container.securityContext.privileged == true

  msg := sprintf(
    "Privileged container '%s' is not allowed",
    [container.name]
  )
}