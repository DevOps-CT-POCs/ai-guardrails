package kubernetes.admission

violation contains {"msg": msg} if {
  input.review.kind.kind == "Pod"

  container := input.review.object.spec.containers[_]
  image := container.image

  not allowed_image(image)

  msg := sprintf(
    "Image '%s' is not from an approved registry",
    [image]
  )
}

allowed_image(image) if {
  registry := data.allowed_registries.allowed_registries[_]
  startswith(image, registry)
}