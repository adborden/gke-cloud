#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset
set -x


function kubectl_args () {
  kubectl_extra_args=
  if [[ -n "${app_namespace:-}" ]]; then
    kubectl_extra_args="--namespace ${app_namespace}"
  fi

  if [[ -n "$kustomize_overlay_name" ]]; then
    echo -n "--kustomize $app_name/overlays/$kustomize_overlay_name $kubectl_extra_args"
  else
    echo -n "--filename $app_name $kubectl_extra_args"
  fi
}

function run_apply () {
  kubectl apply --wait $(kubectl_args)
}

function run_diff () {
  kubectl diff $(kubectl_args)
}

while [[ "$#" -gt 0 ]]; do
  option=$1
  shift

  case $option in
    --commit)
      run_apply
      ;;
    *)
      echo Unknown option $option >&2
      exit 1
      ;;
  esac
done

run_diff
