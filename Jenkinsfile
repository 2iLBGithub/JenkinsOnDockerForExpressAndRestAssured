// pipeline {
//     agent any
//     stages {
//         stage('Checkout SCM') {
//             steps {
//                 checkout scm
//             }
//         }
//         stage('Start Express Server') {
//             steps {
//                 script {
//                     // Navigate to the Express server directory
//                     dir('DockerExpressServer') {
//                         // Start the Express server in the background
//                         sh 'node server.js &'
//                     }
//                     // Wait for the server to start
//                     sleep 60
//                 }
//             }
//         }
//         stage('Run Rest-Assured Tests') {
//             steps {
//                 script {
//                     // Navigate to the Rest-Assured tests directory and run the tests
//                     dir('DockerRestAssuredServer') {
//                         sh 'mvn test'
//                     }
//                 }
//             }
//         }
//     }
//     post {
//         always {
//             script {
//                 // Stop the Express server
//                 sh 'pkill node'
//             }
//         }
//     }
// }

pipeline {
    agent any
    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }
        stage('Verify Files') {
            steps {
                script {
                    // List files to verify they are present
                    sh 'ls -la DockerExpressServer'
                    sh 'ls -la DockerRestAssuredServer'
                }
            }
        }
        stage('Start Express Server') {
            steps {
                script {
                    dir('DockerExpressServer') {
                        // Start the Express server in the background and redirect output to a file
                        sh 'nohup node server.js > server.log 2>&1 &'
                    }
                    // Wait for the server to start
                    sleep 30
                }
            }
        }
        stage('Verify Server is Running') {
            steps {
                script {
                    // Check if the server is running
                    def response = sh(script: 'curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/beverages', returnStdout: true).trim()
                    if (response != '200') {
                        error "Express server is not running or not reachable"
                    }
                    // Print server log to verify it started correctly
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
                // Stop the Express server
                sh 'pkill node'
            }
        }
    }
}
