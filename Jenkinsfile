pipeline {
    agent any
    
    stages {
        stage('Deploy to Cluster') {
            steps {
                // Update kubeconfig to use the EKS cluster
                sh """
                    aws eks update-kubeconfig --region ap-south-1 --name ekscluster
                """

                // Apply the Kubernetes deployment configuration
                sh """
                    kubectl apply -f deployment.yaml
                """

                // Optional: Verify the rollout status of the deployment
                // sh "kubectl rollout status deployment/my-node-app-deployment"
            }
        }
    }
}
