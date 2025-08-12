pipeline {
    agent any
    stages {
        stage('Install') {
            steps {
                sh 'npm install'
            }
        }
        stage('Test & Coverage') {
            steps {
                sh 'npm test'
            }
        }
        stage('SonarQube Analysis') {
            environment {
                SONAR_TOKEN = credentials('sonar-token')
            }
            steps {
                sh """
                npx sonar-scanner \
                -Dsonar.login=$SONAR_TOKEN
                """
            }
        }
    }
}
