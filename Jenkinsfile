pipeline {
    agent any

    environment {
        IMAGE_NAME = "docker-jenkins"
        IMAGE_TAG = "test"
        SONAR_TOKEN = credentials('SONAR_TOKEN') // Jenkins credentials ID for Sonar token
    }

    stages {
        stage('Install JS Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Run JS Tests') {
            steps {
                sh 'npm test -- --passWithNoTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }
    }
}
