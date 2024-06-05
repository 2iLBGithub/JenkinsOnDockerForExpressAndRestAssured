pipeline {
    agent any
    environment {
        DOCKER_IMAGE = 'jenkins-docker-express-restassured-project:latest'
    }
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }
        stage('Build and Deploy with Docker Compose') {
            steps {
                script {
                    sh 'docker-compose -f docker-compose.yml up --build -d'
                    sleep 60 
                }
            }
        }
        stage('Run Rest-Assured Tests') {
            steps {
                script {
                    sh 'docker-compose -f docker-compose.yml run rest-assured-tests'
                }
            }
        }
    }
    post {
        always {
            script {
                sh 'docker-compose -f docker-compose.yml down'
            }
        }
    }
}
