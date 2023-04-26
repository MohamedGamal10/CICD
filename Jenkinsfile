pipeline {
agent any
  stages {
    stage('Clean Old Docker image') {
      steps {
        sshPublisher(continueOnError: true,
          publishers: [
            sshPublisherDesc(configName: 'remote',verbose: true,
              transfers: [
                sshTransfer(execCommand: "docker stop app"),
                sshTransfer(execCommand: "docker rm app",),
                sshTransfer(execCommand: "docker rmi react_app:1.0"),
              ])
          ]) 
      }
    }

      stage('Build Docker image') {
      steps {
        sshPublisher(continueOnError: true,
          publishers: [
            sshPublisherDesc(configName: 'remote',verbose: true,
              transfers: [
                sshTransfer(execCommand: "git clone https://github.com/MohamedGamal10/CICD.git"),
                sshTransfer(execCommand: "cd /root/CICD"),
                sshTransfer(execCommand: "docker build --name react_app --tag 1.0 ."),
              ])
          ])  
      }
    }

    stage('Docker Run Container') {
      steps {
        sshPublisher(continueOnError: true,
          publishers: [
            sshPublisherDesc(configName: 'remote',verbose: true,
              transfers: [
                sshTransfer(execCommand: "docker run --name app -p 80:80 -d react_app:1.0"),
              ])
          ])
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
