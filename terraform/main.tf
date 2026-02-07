
provider "kubernetes" {
  config_path = "~/.cube/config" #Config k8s locale

}

provider "helm" {
  kubernetes {
    config_path = "~/.cuke/config"
  }
}



#Pour cilium plus tard
# module "cilium" {
#    source = "./modules/cilium"
#}
