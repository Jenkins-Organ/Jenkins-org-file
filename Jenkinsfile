pipeline {
    agent any

    environment {
        APP_NAME = 'my-app'
        SONAR_TOKEN = credentials('sonar-token') // Store in Jenkins credentials
    }

    stages {
        stage('Build') {
            steps {
                sh """
                    chmod +x build.sh
                    echo Building ${APP_NAME}...
                    ./build.sh
                """
            }
        }

        stage('Test & Sonar Analysis') {
            parallel {
                stage('Test') {
                    steps {
                        sh """
                            chmod +x test.sh
                            echo Running tests with coverage...
                            ./test.sh
                        """
                    }
                }

                stage('SonarCloud Analysis') {
                    steps {
                        // Wait until test coverage is generated
                        sh 'sleep 5'
                        sh """
                            sonar-scanner \
                              -Dsonar.projectKey=jenkins-organ_test \
                              -Dsonar.organization=jenkins-organ \
                              -Dsonar.host.url=https://sonarcloud.io \
                              -Dsonar.login=${SONAR_TOKEN}
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
