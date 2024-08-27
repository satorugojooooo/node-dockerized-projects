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
                    // System update (optional, be careful on production environments)
                    sh 'sudo yum update -y'
                    
                    // Install Node.js and npm using nvm (recommended)
                    sh '''
                        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
                        . ~/.nvm/nvm.sh
                        nvm install 16
                        nvm use 16
                        npm install
                    '''
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
                    // Log in to DockerHub securely
                    sh 'echo $DOCKERHUB_PASSWORD | docker login -u $DOCKERHUB_USERNAME --password-stdin'
                    
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
