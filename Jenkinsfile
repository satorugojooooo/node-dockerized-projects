pipeline {
    agent any

    environment {
        dockerimagename = "thirunavukkarasuj/my-node-app"
        dockerImage = ""
        KUBECONFIG = '/home/ubuntu/.kube/config'
    }

    stages {
        stage('Deploying App to Kubernetes') {
            steps {
                script {
                    // Verify kubectl client version
                    sh '/home/ubuntu/bin/kubectl version --client'
                    
                    // Apply Kubernetes deployment configuration
                    sh '/home/ubuntu/bin/kubectl apply -f deployment.yml'
                }
            }
        }
    }
}
