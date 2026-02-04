package kubernetes.admission

required_labels := {
  "app",
  "owner",
  "environment"
}

violation contains {"msg": msg} if {
  input.review.kind.kind == "Pod"

  labels := input.review.object.metadata.labels
  labels != null

  missing := required_labels - {k | labels[k]}
  count(missing) > 0

  msg := sprintf(
    "Missing required labels: %v",
    [missing]
  )
}