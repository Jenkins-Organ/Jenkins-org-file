pipeline {
    agent any

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

        stage('Run Python Tests') {
            steps {
                sh 'pip install pytest pytest-cov'
                sh 'pytest --cov=hello --cov-report=xml'
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh """
                        sonar-scanner \
                        -Dsonar.projectKey=jenkins-organ_test \
                        -Dsonar.organization=Jenkins-Organ \
                        -Dsonar.sources=. \
                        -Dsonar.python.coverage.reportPaths=coverage.xml \
                        -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info \
                        -Dsonar.host.url=https://sonarcloud.io \
                        -Dsonar.login=$SONAR_TOKEN
                    """
                }
            }
        }
    }
}
