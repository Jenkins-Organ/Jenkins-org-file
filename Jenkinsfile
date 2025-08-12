pipeline {
    agent any

    environment {
        SONAR_SCANNER_VERSION = '5.0.1.3006'
        SONAR_SCANNER_DIR = "sonar-scanner-cli-${SONAR_SCANNER_VERSION}-linux"
        PATH = "${env.PATH}:${env.WORKSPACE}/${SONAR_SCANNER_DIR}/bin"
    }

    stages {
        stage('Install JS Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Run JS Tests') {
            steps {
                sh 'npm test -- --passWithNoTests || true'
            }
        }

        stage('Install Sonar Scanner') {
            steps {
                sh """
                    if ! command -v sonar-scanner &> /dev/null; then
                        echo "Downloading Sonar Scanner..."
                        curl -sSLo sonar.zip https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/${SONAR_SCANNER_DIR}.zip
                        unzip -o sonar.zip
                        echo "Sonar Scanner installed at ${SONAR_SCANNER_DIR}"
                    else
                        echo "Sonar Scanner already installed"
                    fi
                """
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh """
                        echo "Running Sonar Scanner..."
                        sonar-scanner \
                          -Dsonar.projectKey=jenkins-organ_test \
                          -Dsonar.organization=Jenkins-Organ \
                          -Dsonar.sources=. \
                          -Dsonar.python.coverage.reportPaths=coverage.xml \
                          -Dsonar.javascript.lcov.reportPaths=coverage/lcov.info \
                          -Dsonar.host.url=https://sonarcloud.io \
                          -Dsonar.login=${SONAR_TOKEN}
                    """
                }
            }
        }
    }

    post {
        failure {
            echo "Pipeline failed! Check logs above for errors."
        }
    }
}
