resource "null_resource" "create_admin_role" {
  provisioner "local-exec" {
    command = "kubectl create clusterrolebinding admin-role-binding --clusterrole=cluster-admin --user=adamjohnson35@gmail.com"
  }
  depends_on = [null_resource.update_kubeconfig]
}

resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --zone ${google_container_cluster.primary.location}"
  }
}

resource "null_resource" "rename_kube_context" {
  provisioner "local-exec" {
    command = "kubectl config rename-context gke_nhyne-233223_${google_container_cluster.primary.location}_${google_container_cluster.primary.name} nhyne"
  }

  depends_on = [null_resource.update_kubeconfig]
}

