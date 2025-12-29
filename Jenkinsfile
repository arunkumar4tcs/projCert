pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "sonuarun004/projcert:latest"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE .'
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    docker push $DOCKER_IMAGE
                    '''
                }
            }
        }

        stage('Deploy to DEV (K8s)') {
            steps {
                sh 'kubectl apply -f k8s/dev/'
            }
        }

        stage('APPROVAL GATE') {
            steps {
                input message: 'Approve deployment to PRODUCTION?',
                      ok: 'Approve',
                      submitter: 'admin,devops'
            }
        }

        stage('Deploy to PROD (K8s)') {
            steps {
                sh 'kubectl apply -f k8s/prod/'
            }
        }
    }
}
