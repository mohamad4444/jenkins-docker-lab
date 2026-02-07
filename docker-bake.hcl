variable "JENKINS_VERSION" {
  default = trimspace(file("VERSION"))
}

variable "APP_VERSION" {
  default = trimspace(file("myapp/VERSION"))
}

variable "MYSERVICE_VERSION" {
  default = trimspace(file("myservice/VERSION"))
}

group "default" {
  targets = ["jenkins", "myapp", "myservice"]
}

target "jenkins" {
  context = "."
  dockerfile = "Dockerfile"
  tags = [
    "docker.io/myjenkins:${JENKINS_VERSION}",
    "docker.io/myjenkins:latest"
  ]
  platforms = ["linux/amd64"]
}

target "myapp" {
  context = "myapp"
  dockerfile = "Dockerfile"
  tags = [
    "docker.io/myapp:${APP_VERSION}",
    "docker.io/myapp:latest"
  ]
  platforms = ["linux/amd64"]
}

target "myservice" {
  context = "myservice"
  dockerfile = "Dockerfile"
  tags = [
    "docker.io/myservice:${MYSERVICE_VERSION}",
    "docker.io/myservice:latest"
  ]
  platforms = ["linux/amd64"]
}
