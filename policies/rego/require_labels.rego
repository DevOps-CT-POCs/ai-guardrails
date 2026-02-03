package kubernetes.admission

required_labels := {
  "app",
  "owner",
  "environment"
}

violation[{"msg": msg}] {
  input.review.kind.kind == "Pod"

  labels := input.review.object.metadata.labels
  missing := required_labels - {key | labels[key]}

  count(missing) > 0

  msg := sprintf(
    "Missing required labels: %v",
    [missing]
  )
}