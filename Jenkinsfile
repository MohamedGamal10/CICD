pipeline {
    agent any
    stages {
        stage('Test Catch') {
            steps {
                script {
                    try {
                        sh 'invalid-command'
                    } catch (Exception ex) {
                        echo "Caught exception: ${ex.getMessage()}"
                    }
                }
            }
        }
    }
}
