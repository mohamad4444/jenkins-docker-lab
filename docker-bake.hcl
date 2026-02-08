# Version variables
variable "JENKINS_VERSION" {
  default = "0.1.1"
}

variable "APP_VERSION" {
  default = "0.1.0"
}

variable "MYSERVICE_VERSION" {
  default = "0.1.0"
}

# Add a registry variable
variable "REGISTRY" {
  default = "localhost:5000"  # Change this to your registry
}

# Group of targets
group "default" {
  targets = ["jenkins", "myapp", "myservice"]
}

# Jenkins build target
target "jenkins" {
  context = "jenkins"
  dockerfile = "Dockerfile"
  tags = [
    "${REGISTRY}/myjenkins:${JENKINS_VERSION}",
    "${REGISTRY}/myjenkins:latest"
  ]
  platforms = ["linux/amd64"]
}

# MyApp build target
target "myapp" {
  context = "myapp"
  dockerfile = "Dockerfile"
  tags = [
    "${REGISTRY}/myapp:${APP_VERSION}",
    "${REGISTRY}/myapp:latest"
  ]
  platforms = ["linux/amd64"]
}

# MyService build target
target "myservice" {
  context = "myservice"
  dockerfile = "Dockerfile"
  tags = [
    "${REGISTRY}/myservice:${MYSERVICE_VERSION}",
    "${REGISTRY}/myservice:latest"
  ]
  platforms = ["linux/amd64"]
}
