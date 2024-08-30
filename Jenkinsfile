pipeline {
    agent any

    environment {
        KUBERNETES_CREDENTIALS_ID = 'k8scred'
        KUBE_CONTEXT = 'my-cluster-context'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Install kubectl') {
            steps {
                script {
                    sh '''
                        curl -LO "https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl"
                        chmod +x ./kubectl
                        sudo mv ./kubectl /usr/local/bin/kubectl
                        kubectl version --client
                    '''
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withKubeConfig([credentialsId: "${KUBERNETES_CREDENTIALS_ID}", contextName: "${KUBE_CONTEXT}"]) {
                        sh 'kubectl apply -f deployment.yml'
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Deployment process finished.'
        }
    }
}
