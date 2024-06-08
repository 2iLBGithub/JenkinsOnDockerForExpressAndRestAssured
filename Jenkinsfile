pipeline {
    agent any
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }
        stage('Start Express Server') {
            steps {
                script {
                    // Navigate to the Express server directory
                    dir('DockerExpressServer') {
                        // Start the Express server in the background
                        sh 'node server.js &'
                    }
                    // Wait for the server to start
                    sleep 60
                }
            }
        }
        stage('Run Rest-Assured Tests') {
            steps {
                script {
                    // Navigate to the Rest-Assured tests directory and run the tests
                    dir('DockerRestAssuredServer') {
                        sh 'mvn test'
                    }
                }
            }
        }
    }
    post {
        always {
            script {
                // Stop the Express server
                sh 'pkill node'
            }
        }
    }
}
