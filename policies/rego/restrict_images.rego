package kubernetes.admission

violation[{"msg": msg}] {
  input.review.kind.kind == "Pod"

  container := input.review.object.spec.containers[_]
  image := container.image

  not startswith_any(image, data.allowed_registries.allowed_registries)

  msg := sprintf(
    "Image '%s' is not from an approved registry",
    [image]
  )
}

startswith_any(image, registries) {
  some r
  startswith(image, r)
}