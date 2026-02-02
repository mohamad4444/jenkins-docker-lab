group "default" {
  targets = ["jenkins", "myapp"]
}

target "jenkins" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["myjenkins:latest"]
  platforms = ["linux/amd64"]
}

target "myapp" {
  context = "myapp"
  dockerfile = "Dockerfile"
  tags = ["myapp:latest"]
  platforms = ["linux/amd64"]
}
