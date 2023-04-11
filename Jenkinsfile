pipeline {
agent any
  stages {
    stage('Download App') {
      steps {
        sshPublisher(continueOnError: true, failOnError: true,
          publishers: [
            sshPublisherDesc(configName: 'remote',verbose: true,
              transfers: [
                sshTransfer(execCommand: "rm -r /root/CICD"),
                sshTransfer(execCommand: "git clone https://github.com/MohamedGamal10/CICD.git")
              ]
            )
          ]
        )
      }
    }
    stage('Build Docker image') {
      steps {
        sshPublisher(continueOnError: true, failOnError: true,
          publishers: [
            sshPublisherDesc(configName: 'remote',verbose: true,
              transfers: [
                sshTransfer(execCommand: "docker build --tag react_app ./root/CICD/cicd_app"),
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
