pipeline {
    agent any
 
    stages {
        stage('Build') {
            steps {
                sh 'docker-compose build'
            }
        }
        stage('Test') {
            steps {
                sh 'docker-compose run --rm nodejs npm test'
            }
        }
        stage('Deploy') {
            steps {
                sh 'docker-compose up -d'
            }
            post {
                success {
                    script {
                        def containerId = sh(script: 'docker ps -q --filter "ancestor=nodejs"', returnStdout: true).trim()
                        sh "docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $containerId"
                    }
                }
            }
        }
    }
}
