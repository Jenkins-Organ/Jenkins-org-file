pipeline {
    agent any

    environment {
        APP_NAME = 'my-app'
        SONAR_HOST_URL = 'https://sonarcloud.io'
        SONAR_TOKEN = credentials('SONAR_TOKEN') // store SONAR_TOKEN in Jenkins credentials
    }

    stages {
        stage('Install dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build') {
            steps {
                sh """
                    chmod +x build.sh
                    echo "Building ${APP_NAME}..."
                    ./build.sh
                """
            }
        }

        stage('Test with coverage') {
            steps {
                sh """
                    chmod +x test.sh
                    echo "Running tests..."
                    npm run test -- --coverage
                """
            }
        }

        stage('SonarQube Analysis') {
            steps {
                sh """
                    npx sonar-scanner \
                        -Dsonar.projectKey=jenkins-organ_test \
                        -Dsonar.organization=Jenkins-Organ \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=${SONAR_HOST_URL} \
                        -Dsonar.login=${SONAR_TOKEN} \
                        -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info
                """
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
