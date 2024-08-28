pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'my-node-app'
        DOCKER_IMAGE_TAG = '1.0'
        DOCKER_REGISTRY = 'jeevac33'
        KUBE_DEPLOYMENT_NAME = 'my-node-app'
        DOCKER_CREDENTIALS_ID = 'docker_cred'
        KUBE_CREDENTIALS_ID = 'kubeconfig'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test') {
            steps {
                sh 'sudo apt-get update'
                sh 'sudo DEBIAN_FRONTEND=noninteractive apt-get install -y npm'
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
                script {
                    def imageName = "${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                    sh "docker build -t ${imageName} ."
                }
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                    script {
                        def imageName = "${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                        def fullImageName = "${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                        sh "docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD"
                        sh "docker tag ${imageName} ${fullImageName}"
                        sh "docker push ${fullImageName}"
                        sh 'docker logout'
                    }
                }
            }
        }

        stage('Install kubectl') {
            steps {
                sh '''
                    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
                    chmod +x ./kubectl
                    ./kubectl version --client
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withKubeConfig([credentialsId: KUBE_CREDENTIALS_ID]) {
                    script {
                        def imageName = "${DOCKER_REGISTRY}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                        sh "kubectl set image deployment/${KUBE_DEPLOYMENT_NAME} ${KUBE_DEPLOYMENT_NAME}=${imageName}"
                    }
                }
            }
        }

        stage('Deploy to Cluster') {
            steps {
                // Ensure deploy.yaml exists and is correctly configured
                sh "envsubst < ${WORKSPACE}/deploy.yaml | kubectl apply -f -"
            }
        }
    }
}
