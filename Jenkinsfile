pipeline {
    agent {
        docker {
            image 'lb2idocker/djra_project:latest'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    environment {
        WORKSPACE_DIR = "${env.WORKSPACE}"
    }
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }
        stage('Build and Deploy with Docker Compose') {
            steps {
                script {
                    dir("${env.WORKSPACE_DIR}") {
                        sh 'docker-compose up --build -d'
                        sleep 60
                    }
                }
            }
        }
        stage('Run Rest-Assured Tests') {
            steps {
                script {
                    dir("${env.WORKSPACE_DIR}") {
                        sh 'docker-compose run rest-assured-tests'
                    }
                }
            }
        }
    }
    post {
        always {
            script {
                dir("${env.WORKSPACE_DIR}") {
                    sh 'docker-compose down'
                }
            }
        }
    }
}
