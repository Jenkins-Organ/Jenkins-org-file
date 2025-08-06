pipeline {
    agent any

    environment {
        APP_NAME = 'my-app'
    }

    stages {
        stage('Build') {
            steps {
                echo "Building ${APP_NAME}..."
                sh './build.sh'
            }
        }

        stage('Test') {
            steps {
                echo "Running tests..."
                sh './scripts/test.sh'
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
