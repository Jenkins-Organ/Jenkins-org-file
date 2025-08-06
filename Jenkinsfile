pipeline {
    agent any

    environment {
        APP_NAME = 'my-app'
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
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
