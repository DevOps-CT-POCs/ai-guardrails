package kubernetes.admission

violation[{"msg": msg}] {
  input.review.kind.kind == "Pod"
  some i
  container := input.review.object.spec.containers[i]
  container.securityContext.runAsNonRoot == false
  msg := sprintf("container %v must run as non-root", [container.name])
}