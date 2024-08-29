pipeline {
    agent any  // Defines where the pipeline will run

    stages {
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
