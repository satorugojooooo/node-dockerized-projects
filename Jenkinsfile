pipeline {
    agent any  // Defines where the pipeline will run

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'sudo apt-get update'
                sh 'sudo DEBIAN_FRONTEND=noninteractive apt-get install -y npm'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test'
            }
        }

        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: 'k8scred', variable: 'KUBECONFIG')]) {
                    sh 'kubectl apply -f deployment.yml'
                    sh 'kubectl rollout status deployment/my-node-app'
                }
            }
        }
    }
}
