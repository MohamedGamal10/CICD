pipeline {
agent any
  stages {
    stage('Retrieve Version') {
      steps {
        script {
          def gitUrl = 'https://github.com/MohamedGamal10/CICD'
          def branch = 'main'
          def packageJsonPath = 'package.json'
          def packageJsonUrl = "${gitUrl}/blob/${branch}/${packageJsonPath}"
          def packageJson = sh(returnStdout: true, script: "curl -s ${packageJsonUrl}")
          echo "${packageJson}"
          def version = sh(returnStdout: true, script: "echo '${packageJson}' | jq -r '.version'")

          echo "Package version is ${version}"
        }
      }
    }

    stage('Clean Old Docker image') {
      steps {
        sshPublisher(continueOnError: true,
          publishers: [
            sshPublisherDesc(configName: 'remote',verbose: true,
              transfers: [
                sshTransfer(execCommand: "docker stop app"),
                sshTransfer(execCommand: "docker rm app",),
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
                sshTransfer(execCommand: "docker build https://github.com/MohamedGamal10/CICD.git#main -t react_app:1.0"),
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
