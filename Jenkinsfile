pipeline {
    agent any

    environment {
        IMAGE_NAME = "bssrikanthgowda/test-repo"
        IMAGE_TAG = "tagname" // Change this to dynamic tag if needed
        SONAR_TOKEN = credentials('SONAR_TOKEN')
        SONAR_SKIP_GITHUB_STATUS = 'true'
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

        stage('Vulnerability Scan with Trivy') {
            steps {
                sh "trivy image ${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                withDockerRegistry(credentialsId: 'DOCKERHUB_CREDENTIALS', url: 'https://index.docker.io/v1/') {
                    sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                }
            }
        }
    }
}
