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

        stage('Install npm') {
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

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t my-node-app:1.0 .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker_cred', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                    sh 'docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD'
                    sh 'docker tag my-node-app:1.0 thirunavukkarasuj/my-node-app:1.0'
                    sh 'docker push thirunavukkarasuj/my-node-app:1.0'
                    sh 'docker logout'
                }
            }
        }

        stage('Install kubectl') {
            steps {
                script {
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
            echo 'Pipeline completed.'
        }
    }
}
