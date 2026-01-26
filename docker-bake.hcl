group "default" {
  targets = ["jenkins"]
}

target "jenkins" {
  context = "."
  dockerfile = "Dockerfile"
  tags = ["myjenkins:latest"]
  platforms = ["linux/amd64"]
}
