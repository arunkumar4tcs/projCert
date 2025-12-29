pipeline {
    agent any

    environment {
        IMAGE = "sonuarun004/projcert:latest"
    }

    stages {

        stage('Build Image') {
            steps {
                sh 'docker build -t $IMAGE .'
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh '''
                      echo "$PASS" | docker login -u "$USER" --password-stdin
                      docker push $IMAGE
                    '''
                }
            }
        }

        stage('Deploy to DEV') {
            steps {
                sh 'kubectl apply -f k8s/dev/'
            }
        }

        stage('Approval Gate') {
            steps {
                input message: 'Approve deployment to PROD?', ok: 'Approve'
            }
        }

        stage('Deploy to PROD') {
            steps {
                sh 'kubectl apply -f k8s/prod/'
            }
        }
    }
}
