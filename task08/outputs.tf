output "aci_fqdn" {
  value       = module.aci.fqdn
  description = "fully qualified domain name for container group"
}

output "aks_lb_ip" {
  value       = data.kubernetes_service.app_service.status[0].load_balancer[0].ingress[0].ip
  description = "load balancer ip for kubernetes cluster"
}