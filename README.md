# gke-cloud

Automation for GKE cloud project.

## Deploy

Check the diff.

    $ kubectl diff --namespace $app_namespace --filename $app_name --prune

Apply the changes.

    $ kubectl diff --namespace $app_namespace --filename $app_name --prune --wait

## Apps

### external-dns

Configured for automatic update of project DNS zones.

## CICD

https://cloud.google.com/kubernetes-engine/docs/how-to/api-server-authentication#applications_in_other_environments

`GCLOUD_SERVICE_ACCOUNT_KEY`
