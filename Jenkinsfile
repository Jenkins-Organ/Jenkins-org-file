pipeline {
    agent any

    environment {
        APP_NAME = 'my-app'
        SONAR_HOST_URL = 'https://sonarcloud.io'
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

        stage('Test') {
            steps {
                sh """
                    chmod +x test.sh
                    echo Running tests...
                    ./test.sh
                """
            }
        }

        stage('Install SonarScanner') {
            steps {
                sh '''
                    if [ ! -d "$WORKSPACE/sonar-scanner" ]; then
                        echo "Downloading SonarScanner CLI..."
                        wget -q -O sonar-scanner.zip "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip"
                        unzip -q sonar-scanner.zip -d $WORKSPACE
                        mv $WORKSPACE/sonar-scanner-* $WORKSPACE/sonar-scanner
                        rm sonar-scanner.zip
                    fi
                '''
            }
        }

        stage('SonarCloud Analysis') {
            steps {
                withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]) {
                    sh '''
                        export PATH=$WORKSPACE/sonar-scanner/bin:$PATH
                        sonar-scanner \
                          -Dsonar.login=${SONAR_TOKEN}
                    '''
                }
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
            cleanWs()
        }
    }
}
