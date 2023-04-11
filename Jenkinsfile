pipeline {
agent any
  stages {
    stage('Build Docker image') {
      steps {
        sshPublisher(continueOnError: true, failOnError: true,
          publishers: [
            sshPublisherDesc(configName: 'remote',verbose: true,
              transfers: [
                sshTransfer(execCommand: "docker stop app",continueOnError: true),
                sshTransfer(execCommand: "docker rm app",continueOnError: true),
                sshTransfer(execCommand: "docker rmi react_app:1.0",continueOnError: true),
                sshTransfer(execCommand: "docker build https://github.com/MohamedGamal10/CICD.git#main -t react_app:1.0",continueOnError: true),
              ]
            )
          ]
        )
      }
    }
    stage('Docker Run Container') {
      steps {
        sshPublisher(continueOnError: true, failOnError: true,
          publishers: [
            sshPublisherDesc(configName: 'remote',verbose: true,
              transfers: [
                sshTransfer(execCommand: "docker run --name app -p 80:80 -d react_app:1.0",continueOnError: true),
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
