pipeline {
    agent any
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
                script {
                    sh 'ls -la DockerExpressServer'
                }
            }
        }
        stage('Start Express Server') {
            steps {
                script {
                    dir('DockerExpressServer') {
                        sh 'nohup node server.js > server.log 2>&1 &'
                    }
                    sleep 10
                }
            }
        }
        stage('Verify Server is Running') {
            steps {
                script {
                    def response = sh(script: 'curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/beverages', returnStdout: true).trim()
                    if (response != '200') {
                        error "Express server is not running or not reachable"
                    }
                    sh 'cat DockerExpressServer/server.log'
                }
            }
        }
        stage('Run Rest-Assured Tests') {
            steps {
                script {
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
                sh 'pkill node'
            }
        }
    }
}
