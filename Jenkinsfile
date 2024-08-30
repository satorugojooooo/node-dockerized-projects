pipeline {
    agent any

    environment {
        KUBERNETES_CREDENTIALS_ID = 'k8scred'
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
                    // Install kubectl
                    sh '''
                        curl -LO "https://dl.k8s.io/release/v1.27.3/bin/linux/amd64/kubectl"
                        chmod +x ./kubectl
                        if [ ! -d /usr/local/bin ]; then sudo mkdir -p /usr/local/bin; fi
                        sudo mv ./kubectl /usr/local/bin/kubectl
                        kubectl version --client
                    '''
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    withKubeConfig([credentialsId: "${KUBERNETES_CREDENTIALS_ID}"]) {
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
