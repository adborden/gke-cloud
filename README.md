# gke-cloud

Automation for GKE cloud project.

## Deploy

Check the diff.

    $ kubectl diff --namespace $app_namespace --filename $app_directory --prune

Apply the changes.

    $ kubectl diff --namespace $app_namespace --filename $app_directory --prune --wait

## Apps

### external-dns

Configured for automatic update of project DNS zones.
