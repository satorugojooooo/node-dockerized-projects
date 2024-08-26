pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Install Dependencies and Test') {
            steps {
                script {
                    // System update and install npm as root (if sudo is configured for passwordless)
                    sh 'sudo yum update -y'
                    sh 'sudo yum install -y npm'
                }
                // Run tests using npm
                sh 'npm test'
            }
        }
        
        stage('Build') {
            steps {
                // Build the project
                sh 'npm run build'
            }
        }
    }
}
