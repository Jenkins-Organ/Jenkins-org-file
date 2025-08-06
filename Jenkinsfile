pipeline {
    agent any

    environment {
        APP_NAME = 'my-app'
    }

    stages {
        stage('Build') {
            steps {
                sh '''
                    echo Building ${ APP_NAME }...
                    sh ./build.sh
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    echo Running tests...
                    sh ./scripts/test.sh
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline finished.'
        }
    }
}
