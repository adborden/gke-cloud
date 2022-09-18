#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset

helm_secret_values=$(mktemp)
cat <<<${HELM_SECRET_VALUES:-} > $helm_secret_values

set -x

function helm_args () {
  additional_args=

  # Add any namespace specific values files
  if [[ -e "$app_name/$app_namespace.yaml" ]]; then
    additional_args="${additional_args} --values ${app_name}/${app_namespace}.yaml"
  fi

  # Add any values files containing secrets
  if [[ -s "$helm_secret_values" ]]; then
    additional_args="${additional_args} --values ${helm_secret_values}"
  fi

  echo -n "$app_name $app_name/$helm_repository_name --namespace $app_namespace --values $app_name/values.yaml $additional_args $helm_additional_args"
}

function helm_template () {
  exec helm template $(helm_args)
}

function helm_upgrade () {
  exec helm upgrade $(helm_args) --install --wait
}


while [[ "$#" -gt 0 ]]; do
  option=$1
  shift

  case $option in
    --commit)
      helm_upgrade
      ;;
    *)
      echo "Unknown option $option" >&2
      exit 1
  esac
done

helm_template
