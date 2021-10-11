package main

deny[msg] {
  input.kind == "Kustomization"
  not input.commonLabels

  msg := "Kustomization files should have commonLabels"
}
