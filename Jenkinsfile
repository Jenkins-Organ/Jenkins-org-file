pipeline {
    agent any

    environment {
        APP_NAME = 'my-app'
    }

    stages {
        stage('Build') {
            steps {
                sh """
                    echo Building ${APP_NAME}...
                    ./scripts/build.sh
                """
            }
        }

        stage('Test') {
            steps {
                sh """
                    echo Running tests...
                    ./scripts/test.sh
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
