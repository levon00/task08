output "aci_fqdn" {
  description = "Fully Qualified Domain Name (FQDN) for the deployed container in Azure Container Instance"
  value       = module.aci.fqdn
  sensitive   = true
}

output "aks_lb_ip" {
  value       = data.kubernetes_service.this.status[0].load_balancer[0].ingress[0].ip
  description = "The IP address of the Load Balancer"
}
