pipeline {
    agent any

    tools {
        nodejs "NodeJS_16"  // Configure this in Jenkins Global Tool Configuration
    }

    environment {
        APP_NAME = 'my-app'
        SONAR_HOST_URL = 'https://sonarcloud.io'
        SONAR_TOKEN = credentials('SONAR_TOKEN') // Jenkins credential
        SONAR_PROJECT_KEY = 'jenkins-organ_test'
        SONAR_ORG = 'Jenkins-Organ'
    }

    stages {
        stage('Install dependencies') {
            steps {
                sh 'npm install --legacy-peer-deps'
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

        stage('Test & Sonar Analysis in Parallel') {
            parallel {
                stage('Test with coverage') {
                    steps {
                        sh """
                            chmod +x test.sh
                            echo "Running tests with coverage..."
                            npm run test -- --coverage
                        """
                    }
                }

                stage('SonarQube Analysis') {
                    steps {
                        sh """
                            npx sonar-scanner \
                                -Dsonar.projectKey=${SONAR_PROJECT_KEY} \
                                -Dsonar.organization=${SONAR_ORG} \
                                -Dsonar.sources=. \
                                -Dsonar.host.url=${SONAR_HOST_URL} \
                                -Dsonar.login=${SONAR_TOKEN} \
                                -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
