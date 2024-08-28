pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test') {
            steps {
                // Install npm non-interactively
                sh 'sudo apt-get update'
                sh 'sudo DEBIAN_FRONTEND=noninteractive apt-get install -y npm'
                sh 'npm test'
            }
        }

        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
    } 
}
