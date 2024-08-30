pipeline {
    agent any

    environment {
        // Define the Kubernetes credentials ID (this is used for authentication)
        KUBERNETES_CREDENTIALS_ID = 'k8scred'
        // Define the Kubernetes cluster context if necessary
        KUBE_CONTEXT = 'my-cluster-context' // Adjust this as needed
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repository containing your deployment.yml
                checkout scm
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Ensure you have the Kubernetes CLI installed and configured
                    withKubeConfig([credentialsId: "${KUBERNETES_CREDENTIALS_ID}", contextName: "${KUBE_CONTEXT}"]) {
                        // Apply the deployment.yml file to the Kubernetes cluster
                        sh 'kubectl apply -f deployment.yml'
                    }
                }
            }
        }
    }

    post {
        always {
            // Clean up or perform any post-deployment steps if needed
            echo 'Deployment process finished.'
        }
    }
}
