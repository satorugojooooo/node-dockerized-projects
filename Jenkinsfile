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

        stage('Build Docker Image') {
            steps {
                // Build Docker image
                sh 'docker build -t my-node-app:1.0 .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker_cred', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                    // Log in to DockerHub
                    sh 'docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD'
                    
                    // Tag the Docker image
                    sh 'docker tag my-node-app:1.0 thirunavukkarasuj/my-node-app:1.0'
                    
                    // Push the Docker image
                    sh 'docker push thirunavukkarasuj/my-node-app:1.0'
                    
                    // Log out from DockerHub
                    sh 'docker logout'
                }
            }
        }
    }
}
