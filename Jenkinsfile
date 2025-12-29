pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t projcert:latest .'
            }
        }

        stage('Run Container') {
            steps {
                sh '''
                docker rm -f projcert || true
                docker run -d -p 8080:80 --name projcert projcert:latest
                '''
            }
        }
    }

    post {
        success {
            echo "Application deployed successfully!"
        }
        failure {
            echo "Build failed!"
        }
    }
}
