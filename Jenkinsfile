pipeline {
    agent { 
        node {
            label 'docker-agent-python'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'docker buildx bake'
            }
        }
    }
}
