stage('Deploy to Kubernetes') {
    steps {
        withCredentials([file(credentialsId: 'k8scred', variable: 'KUBECONFIG')]) {
            sh 'kubectl apply -f deployment.yml'
            // Optionally, you can check the status of your deployment
            sh 'kubectl rollout status deployment/my-node-app'
        }
    }
}
