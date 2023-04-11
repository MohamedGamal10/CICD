pipeline {
agent any
  stages {
    stage('Build Docker image') {
      steps {
        sshPublisher(continueOnError: true, failOnError: true,
          publishers: [
            sshPublisherDesc(configName: 'remote',verbose: true,
              transfers: [
                sshTransfer(execCommand: "docker build https://github.com/MohamedGamal10/CICD.git#main -t react_app:1.0"),
              ]
            )
          ]
        )
      }
    }
    stage('Docker Run Container1') {
      steps {
        sshPublisher(continueOnError: true, failOnError: true,
          publishers: [
            sshPublisherDesc(configName: 'remote',verbose: true,
              transfers: [
                sshTransfer(execCommand: "docker run --name app -p 80:80 -d react_app:1.0"),
              ]
            )
          ]
        )
      }
    }
  }
    post {
        always {
            cleanWs()
        }
        success {
            echo 'Build successful!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}
